import CoreGraphics
import CoreText

extension CTLine: CGLayoutObject, CGPlaceable {
    public var size: CGSize {
        return CTLineGetImageBounds(self, nil).size
    }
    public func place(on context: CGContext, at point: CGPoint) {
        context.textPosition = point
        CTLineDraw(self, context)
    }
}

extension CGImage: CGLayoutObject, CGPlaceable {
    public var size: CGSize {
        return CGSize(width: width, height: height)
    }
    public func place(on context: CGContext, at point: CGPoint) {
        let rect = CGRect(origin: point, size: size)
        context.draw(self, in: rect)
    }
}

extension CGSize: CGLayoutObject {
    public var size: CGSize {
        return self
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

public struct CGCustomFigure {
    public let placing: (CGContext, CGSize, CGPoint) -> ()
    public init(placing: @escaping (CGContext, CGSize, CGPoint) -> ()) {
        self.placing = placing
    }
    public static func rectBased(placing: @escaping (CGContext, CGRect) -> ()) -> CGCustomFigure {
        return CGCustomFigure(placing: { (context, size, point) in
            let rect = CGRect(origin: point, size: size)
            placing(context, rect)
        })
    }
    public func ofSize(_ size: CGSize) -> CGLayoutObject {
        return CGSizedCustomFigure(size: size, placing: { (context, point) in
            self.placing(context, size, point)
        })
    }
}

fileprivate struct CGSizedCustomFigure: CGLayoutObject, CGPlaceable {
    public let size: CGSize
    public let placing: (CGContext, CGPoint) -> ()
    public func place(on context: CGContext, at point: CGPoint) {
        placing(context, point)
    }
}

