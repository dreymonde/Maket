import CoreGraphics

public protocol CGLayoutAnchor {
    func shiftVector(for layoutObject: CGLayoutObject) -> CGVector
}

public protocol CGDynamicAnchor: CGLayoutAnchor {
    var shift: (CGLayoutObject) -> CGVector { get }
}

extension CGDynamicAnchor {
    public func shiftVector(for layoutObject: CGLayoutObject) -> CGVector {
        return shift(layoutObject)
    }
}
