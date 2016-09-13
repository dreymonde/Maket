import CoreGraphics

public protocol CGLayoutObject {
    var size: CGSize { get }
}

public protocol CGPlaceable {
    func place(on context: CGContext, at point: CGPoint)
}

public typealias CGPlaceableLayoutObject = CGLayoutObject & CGPlaceable

extension CGLayoutObject {
    public func placePoint<LayoutArea: CGLayoutArea>(relativeTo area: LayoutArea, from anchor: LayoutArea.Anchor, vector: CGVector) -> CGPoint {
        return area.point(of: anchor).applying(anchor.shiftVector(for: self)).applying(vector)
    }
}
