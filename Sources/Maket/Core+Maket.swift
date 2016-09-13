import CoreGraphics
import CoreText

extension CGSize: CGLayoutObject {
    public var size: CGSize {
        return self
    }
    public func place(on context: CGContext, at point: CGPoint) {
        let rect = CGRect(origin: point, size: self)
        context.addRect(rect)
    }
}

fileprivate struct CGSize_Ellipse: CGLayoutObject {
    let size: CGSize
    func place(on context: CGContext, at point: CGPoint) {
        let rect = CGRect(origin: point, size: size)
        context.addEllipse(in: rect)
    }
}

public extension CGSize {
    var ellipse: CGLayoutObject {
        return CGSize_Ellipse(size: self)
    }
}

extension CTLine: CGLayoutObject {
    public var size: CGSize {
        return CTLineGetImageBounds(self, nil).size
    }
    public func place(on context: CGContext, at point: CGPoint) {
        context.textPosition = point
        CTLineDraw(self, context)
    }
}

extension CGImage: CGLayoutObject {
    public var size: CGSize {
        return CGSize(width: width, height: height)
    }
    public func place(on context: CGContext, at point: CGPoint) {
        let rect = CGRect(origin: point, size: size)
        context.draw(self, in: rect)
    }
}

public struct CGScaledImage {
    public let image: CGImage
    public let size: CGSize
    public init(image: CGImage, size: CGSize) {
        self.image = image
        self.size = size
    }
}

extension CGScaledImage: CGLayoutObject {
    public func place(on context: CGContext, at point: CGPoint) {
        let rect = CGRect(origin: point, size: size)
        context.draw(image, in: rect)
    }
}

public extension CGImage {
    func scaled(to size: CGSize) -> CGScaledImage {
        return CGScaledImage(image: self, size: size)
    }
    func scaled(with multiplier: CGFloat) -> CGScaledImage {
        let (newWidth, newHeight) = (CGFloat(width) * multiplier, CGFloat(height) * multiplier)
        let newSize = CGSize(width: newWidth, height: newHeight)
        return self.scaled(to: newSize)
    }
}
