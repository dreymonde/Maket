import CoreGraphics

public enum CGRectAnhcor: CGLayoutAnchor {
    case left, right, top, bottom, center
    public func shiftVector(for layoutObject: CGLayoutObject) -> CGVector {
        switch self {
        case .left: 	return .left(by: layoutObject.size.width)
        case .right: 	return .zero
        case .top: 		return .zero
        case .bottom: 	return .down(by: layoutObject.size.height)
        case .center: 	return .init(dx: -layoutObject.size.width / 2, dy: -layoutObject.size.height / 2)
        }
    }
}

extension CGRect: CGLayoutArea {
    public typealias Anchor = CGRectAnhcor
    public func point(of anchor: Anchor) -> CGPoint {
        switch anchor {
        case .left: 	return CGPoint(x: minX, y: minY + height / 2)
        case .right: 	return CGPoint(x: maxX, y: minY + height / 2)
        case .top: 		return CGPoint(x: minX + width / 2, y: maxY)
        case .bottom: 	return CGPoint(x: minX + width / 2, y: minY)
        case .center: 	return CGPoint(x: minX + width / 2, y: minY + height / 2)
        }
    }
}
