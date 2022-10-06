import CoreGraphics

public extension CGImage {

    /// Crops the insets of transparency around the image.
    ///
    /// - Parameters:
    ///   - maximumAlphaChannel: The maximum alpha channel value to consider  _transparent_ and thus crop. Any alpha value
    ///         strictly greater than `maximumAlphaChannel` will be considered opaque.
    func trimmingTransparentPixels(maximumAlphaChannel: UInt8 = 0) -> CGImage? {
        return _CGImageTransparencyTrimmer(image: self, maximumAlphaChannel: maximumAlphaChannel)?.trim()
    }

}

private struct _CGImageTransparencyTrimmer {

    let image: CGImage
    let maximumAlphaChannel: UInt8
    let cgContext: CGContext
    let zeroByteBlock: UnsafeMutableRawPointer
    let pixelRowRange: Range<Int>
    let pixelColumnRange: Range<Int>

    init?(image: CGImage, maximumAlphaChannel: UInt8) {
        guard let cgContext = CGContext(data: nil,
                                        width: image.width,
                                        height: image.height,
                                        bitsPerComponent: 8,
                                        bytesPerRow: 0,
                                        space: CGColorSpaceCreateDeviceGray(),
                                        bitmapInfo: CGImageAlphaInfo.alphaOnly.rawValue),
            cgContext.data != nil
            else { return nil }

        cgContext.draw(image,
                       in: CGRect(origin: .zero,
                                  size: CGSize(width: image.width,
                                               height: image.height)))

        guard let zeroByteBlock = calloc(image.width, MemoryLayout<UInt8>.size)
            else { return nil }

        self.image = image
        self.maximumAlphaChannel = maximumAlphaChannel
        self.cgContext = cgContext
        self.zeroByteBlock = zeroByteBlock

        pixelRowRange = 0..<image.height
        pixelColumnRange = 0..<image.width
    }

    func trim() -> CGImage? {
        guard let topInset = firstOpaquePixelRow(in: pixelRowRange),
            let bottomOpaqueRow = firstOpaquePixelRow(in: pixelRowRange.reversed()),
            let leftInset = firstOpaquePixelColumn(in: pixelColumnRange),
            let rightOpaqueColumn = firstOpaquePixelColumn(in: pixelColumnRange.reversed())
            else { return nil }

        let bottomInset = (image.height - 1) - bottomOpaqueRow
        let rightInset = (image.width - 1) - rightOpaqueColumn

        guard !(topInset == 0 && bottomInset == 0 && leftInset == 0 && rightInset == 0)
            else { return image }

        return image.cropping(to: CGRect(origin: CGPoint(x: leftInset, y: topInset),
                                         size: CGSize(width: image.width - (leftInset + rightInset),
                                                      height: image.height - (topInset + bottomInset))))
    }

    @inlinable
    func isPixelOpaque(column: Int, row: Int) -> Bool {
        // Sanity check: It is safe to get the data pointer in iOS 4.0+ and macOS 10.6+ only.
        assert(cgContext.data != nil)
        return cgContext.data!.load(fromByteOffset: (row * cgContext.bytesPerRow) + column, as: UInt8.self)
            > maximumAlphaChannel
    }

    @inlinable
    func isPixelRowTransparent(_ row: Int) -> Bool {
        assert(cgContext.data != nil)
        // `memcmp` will efficiently check if the entire pixel row has zero alpha values
        return memcmp(cgContext.data! + (row * cgContext.bytesPerRow), zeroByteBlock, image.width) == 0
            // When the entire row is NOT zeroed, we proceed to check each pixel's alpha
            // value individually until we locate the first "opaque" pixel (very ~not~ efficient).
            || !pixelColumnRange.contains(where: { isPixelOpaque(column: $0, row: row) })
    }

    @inlinable
    func firstOpaquePixelRow<T: Sequence>(in rowRange: T) -> Int? where T.Element == Int {
        return rowRange.first(where: { !isPixelRowTransparent($0) })
    }

    @inlinable
    func firstOpaquePixelColumn<T: Sequence>(in columnRange: T) -> Int? where T.Element == Int {
        return columnRange.first(where: { column in
            pixelRowRange.contains(where: { isPixelOpaque(column: column, row: $0) })
        })
    }

}
