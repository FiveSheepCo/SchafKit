#if os(OSX)
    import AppKit
    
    public typealias UIImage = NSImage
#else
    import UIKit
#endif

public enum PixelFormat
{
    case abgr
    case argb
    case bgra
    case rgba
}

extension CGBitmapInfo
{
    public static var byteOrder16Host: CGBitmapInfo {
        return CFByteOrderGetCurrent() == Int(CFByteOrderLittleEndian.rawValue) ? .byteOrder16Little : .byteOrder16Big
    }

    public static var byteOrder32Host: CGBitmapInfo {
        return CFByteOrderGetCurrent() == Int(CFByteOrderLittleEndian.rawValue) ? .byteOrder32Little : .byteOrder32Big
    }
}

extension CGBitmapInfo
{
    public var pixelFormat: PixelFormat? {

        // AlphaFirst – the alpha channel is next to the red channel, argb and bgra are both alpha first formats.
        // AlphaLast – the alpha channel is next to the blue channel, rgba and abgr are both alpha last formats.
        // LittleEndian – blue comes before red, bgra and abgr are little endian formats.
        // Little endian ordered pixels are BGR (BGRX, XBGR, BGRA, ABGR, BGR).
        // BigEndian – red comes before blue, argb and rgba are big endian formats.
        // Big endian ordered pixels are RGB (XRGB, RGBX, ARGB, RGBA, RGB).

        let alphaInfo: CGImageAlphaInfo? = CGImageAlphaInfo(rawValue: self.rawValue & type(of: self).alphaInfoMask.rawValue)
        let alphaFirst: Bool = alphaInfo == .premultipliedFirst || alphaInfo == .first || alphaInfo == .noneSkipFirst
        let alphaLast: Bool = alphaInfo == .premultipliedLast || alphaInfo == .last || alphaInfo == .noneSkipLast
        let endianLittle: Bool = self.contains(.byteOrder32Little)

        // This is slippery… while byte order host returns little endian, default bytes are stored in big endian
        // format. Here we just assume if no byte order is given, then simple RGB is used, aka big endian, though…

        if alphaFirst && endianLittle {
            return .bgra
        } else if alphaFirst {
            return .argb
        } else if alphaLast && endianLittle {
            return .abgr
        } else if alphaLast {
            return .rgba
        } else {
            return nil
        }
    }
}

public extension UIImage {
    
    #if os(iOS) || os(tvOS)
    // TODO: Make macOS versions
    
    /// The actual size of the image, recognizing the scale.
    var actualSize : CGSize {
        let size = self.size
        let scale = self.scale
        
        return CGSize(width: size.width * scale, height: size.height * scale)
    }
    
    /**
     The `RGBARepresentation`s of the colors at each pixel.
    
     - Note : The first array represents the x-value, the second array represents the y-value.
    
     - Important : The size to reference is the `actualSize` value.
    */
    var colorRepresentations:[[SK8BitRGBARepresentation]]{
        guard let pixelData = cgImage?.dataProvider?.data, let pixelFormat = cgImage?.bitmapInfo.pixelFormat else {
            return []
        }
        
        let data : UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let actualSize = self.actualSize
        let width = Int(actualSize.width)
        let height = Int(actualSize.height)
        
        var complete:[[SK8BitRGBARepresentation]] = []
        for x in 0..<width {
            var representations:[SK8BitRGBARepresentation] = []
            for y in 0..<height {
                let pixelInfo : Int = ((width * y) + x) * 4
                
                let b: UInt8
                let g: UInt8
                let r: UInt8
                let a: UInt8
                
                switch pixelFormat {
                case .abgr:
                    a = data[pixelInfo]
                    b = data[pixelInfo+1]
                    g = data[pixelInfo+2]
                    r = data[pixelInfo+3]
                case .argb:
                    a = data[pixelInfo]
                    r = data[pixelInfo+1]
                    g = data[pixelInfo+2]
                    b = data[pixelInfo+3]
                case .bgra:
                    b = data[pixelInfo]
                    g = data[pixelInfo+1]
                    r = data[pixelInfo+2]
                    a = data[pixelInfo+3]
                case .rgba:
                    r = data[pixelInfo]
                    g = data[pixelInfo+1]
                    b = data[pixelInfo+2]
                    a = data[pixelInfo+3]
                }
                
                representations.append(SK8BitRGBARepresentation(red: r, green: g, blue: b, alpha: a))
            }
            complete.append(representations)
        }
        
        return complete
    }
    
    /**
     The `SK8BitRGBARepresentation` of the color at the pixel.
    
     - Important : If you need a large number of pixels, using the `colorRepresentations` variable might be more efficient.
    */
    func colorRepresentation(at pixel : CGPoint) -> SK8BitRGBARepresentation {
        guard let pixelData = self.cgImage?.dataProvider?.data else {
            return SK8BitRGBARepresentation(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        let data : UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let width = Int(actualSize.width)
        
        let pixelInfo : Int = ((width * Int(pixel.y)) + Int(pixel.x)) * 4
        
        let r = data[pixelInfo]
        let g = data[pixelInfo+1]
        let b = data[pixelInfo+2]
        let a = data[pixelInfo+3]
        
        return SK8BitRGBARepresentation(red: r, green: g, blue: b, alpha: a)
    }
    
    // TODO: Comment
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    /// Returns a version of the receiver tinted with the given color.
    func tintedImage(_ color : UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale);
        let context = UIGraphicsGetCurrentContext();
        
        context!.translateBy(x: 0, y: self.size.height);
        context!.scaleBy(x: 1.0, y: -1.0);
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height);
        
        context!.setBlendMode(.normal);
        context!.draw(self.cgImage!, in: rect);
        
        context!.setBlendMode(.sourceIn);
        color.setFill()
        context!.fill(rect);
        
        let coloredImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return coloredImage
    }
    
    /**
     Returns an image containing the given image appended to the receiver.
    
     - parameter preferYAxis : Overrides the default behaviour to append on the X-Axis when both the heights and widths match.
    
     - Note : Appends the image on the X-Axis if the heights match, on the Y-Axis if the widths match. If both match, the X-Axis is chosen.
    */
    func appending(_ other : UIImage, preferYAxis : Bool = false) -> UIImage? {
        let axis : SKAxis
        
        let size : CGSize
        if self.size.height == other.size.height && !(preferYAxis && self.size.width == other.size.width) {
            axis = .x
            size = CGSize(width: self.size.width + other.size.width, height: self.size.height)
        }else if self.size.width == other.size.width {
            axis = .y
            size = CGSize(width: self.size.width, height: self.size.height + other.size.height)
        }else {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        self.draw(at: .zero)
        other.draw(at : CGPoint(x: (axis == .x) ? self.size.width : 0, y: (axis == .y) ? self.size.height : 0))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    convenience init?(named name : String, in bundle : Bundle?) {
        self.init(named: name, in: bundle, compatibleWith: nil)
    }
    #endif
}

#if os(macOS)
public extension NSImage {
    func tinted(with color: NSColor) -> NSImage {
        let image = self.copy() as! NSImage
        image.lockFocus()

        color.set()

        let imageRect = NSRect(origin: NSZeroPoint, size: image.size)
        imageRect.fill(using: .sourceAtop)

        image.unlockFocus()

        return image
    }
}
#endif
