//  Copyright (c) 2020 Quintschaf GbR
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
#if os(OSX)
    import AppKit
    
    public typealias UIImage = NSImage
#else
    import UIKit
#endif

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
    var colorRepresentations:[[OK8BitRGBARepresentation]]{
        guard let pixelData = cgImage?.dataProvider?.data else {
            return []
        }
        
        let data : UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let actualSize = self.actualSize
        let width = Int(actualSize.width)
        let height = Int(actualSize.height)
        
        var complete:[[OK8BitRGBARepresentation]] = []
        for x in 0..<width {
            var representations:[OK8BitRGBARepresentation] = []
            for y in 0..<height {
                let pixelInfo : Int = ((width * y) + x) * 4
                
                let r = data[pixelInfo]
                let g = data[pixelInfo+1]
                let b = data[pixelInfo+2]
                let a = data[pixelInfo+3]
                
                representations.append(OK8BitRGBARepresentation(red: r, green: g, blue: b, alpha: a))
            }
            complete.append(representations)
        }
        
        return complete
    }
    
    /**
     The `OK8BitRGBARepresentation` of the color at the pixel.
    
     - Important : If you need a large number of pixels, using the `colorRepresentations` variable might be more efficient.
    */
    func colorRepresentation(at pixel : CGPoint) -> OK8BitRGBARepresentation {
        guard let pixelData = self.cgImage?.dataProvider?.data else {
            return OK8BitRGBARepresentation(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        let data : UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        let width = Int(actualSize.width)
        
        let pixelInfo : Int = ((width * Int(pixel.y)) + Int(pixel.x)) * 4
        
        let r = data[pixelInfo]
        let g = data[pixelInfo+1]
        let b = data[pixelInfo+2]
        let a = data[pixelInfo+3]
        
        return OK8BitRGBARepresentation(red: r, green: g, blue: b, alpha: a)
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
        let axis : OKAxis
        
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
