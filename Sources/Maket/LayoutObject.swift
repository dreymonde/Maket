import CoreGraphics

public protocol CGLayoutObject {
    var size: CGSize { get }
    func place(on context: CGContext, at point: CGPoint)
}

extension CGLayoutObject {
    public func placePoint<LayoutArea: CGLayoutArea>(relativeTo area: LayoutArea, from anchor: LayoutArea.Anchor, vector: CGVector) -> CGPoint {
        return area.point(of: anchor).applying(anchor.shiftVector(for: self)).applying(vector)
    }
}
