import CoreGraphics

public protocol CGLayoutArea {
    associatedtype Anchor: CGLayoutAnchor
    func point(of anchor: Anchor) -> CGPoint
}
