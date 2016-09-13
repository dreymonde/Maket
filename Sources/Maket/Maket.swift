// Oppsett
// Skipulag
// Maket

import Foundation
import CoreGraphics

//context.draw(textLine, relativeTo: rect, from: .left, vector: .down(by: 5))

public extension CGVector {
    static func up(by dy: CGFloat) -> CGVector {
        return CGVector(dx: 0, dy: dy)
    }
    static func down(by dy: CGFloat) -> CGVector {
        return CGVector(dx: 0, dy: -dy)
    }
    static func left(by dx: CGFloat) -> CGVector {
        return CGVector(dx: -dx, dy: 0)
    }
    static func right(by dx: CGFloat) -> CGVector {
        return CGVector(dx: dx, dy: 0)
    }
}

public extension CGPoint {
    func applying(_ vector: CGVector) -> CGPoint {
        return CGPoint(x: x + vector.dx, y: y + vector.dy)
    }
}

public extension CGContext {
    func place<LayoutArea: CGLayoutArea>(_ layoutObject: CGLayoutObject & CGPlaceable, relativeTo area: LayoutArea, from anchor: LayoutArea.Anchor, vector: CGVector) {
        let finalPoint = layoutObject.placePoint(relativeTo: area, from: anchor, vector: vector)
        layoutObject.place(on: self, at: finalPoint)
    }
}

