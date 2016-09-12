// Oppsett
// Skipulag
// Maket

import Foundation
import CoreGraphics

//context.draw(textLine, relativeTo: rect, from: .left, vector: .down(5))

protocol CGLayoutObject {
	var size: CGSize { get }
	func draw(in context: CGContext, at point: CGPoint)
}

extension CGPoint {
	func applying(_ vector: CGVector) -> CGPoint {
		return CGPoint(x: x + vector.dx, y: y + vector.dy)
	}
}

extension CGContext {
	func draw<LayoutArea: CGLayoutArea>(_ layoutObject: CGLayoutObject, relativeTo area: LayoutArea, from anchor: LayoutArea.Anchor, vector: CGVector) {
		let finalPoint = area.point(of: anchor).applying(anchor.shiftVector(for: layoutObject)).applying(vector)
		layoutObject.draw(in: self, at: finalPoint)
	}
}

protocol CGLayoutAnchor {
	func shiftVector(for layoutObject: CGLayoutObject) -> CGVector
}

protocol CGDynamicAnchor: CGLayoutAnchor {
	var shift: (CGLayoutObject) -> CGVector { get }
}

extension CGDynamicAnchor {
	func shiftVector(for layoutObject: CGLayoutObject) -> CGVector {
		return shift(layoutObject)
	}
}

// struct CGRectDynamicAnchor: CGDynamicAnchor {
// 	var shift: (CGLayoutObject) -> CGVector
// 	init(shift: @escaping (CGLayoutObject) -> CGVector) {
// 		self.shift = shift
// 	}
// 	static var left: CGRectDynamicAnchor {
// 		return .init(shift: { .left($0.size.width) })
// 	}
// 	static var right: CGRectDynamicAnchor {
// 		return .init(shift: { .zero })
// 	}
// 	static var top: CGRectDynamicAnchor {
// 		return .init(shift: { .zero })
// 	}
// 	static var bottom: CGRectDynamicAnchor {
// 		return .init(shift: { .bottom($0.size.height) })
// 	}
// 	static var center: CGRectDynamicAnchor {
// 		return .init(shift: { .init(dx: -$0.size.width / 2, dy: -layoutObject.size.height / 2) })
// 	}
// }

enum CGRectAnhcor: CGLayoutAnchor {
	case left, right, top, bottom, center
	func shiftVector(for layoutObject: CGLayoutObject) -> CGVector {
		switch self {
		case .left: 	return .left(layoutObject.size.width)
		case .right: 	return .zero
		case .top: 		return .zero
		case .bottom: 	return .bottom(layoutObject.size.height)
		case .center: 	return CGVector(dx: -layoutObject.size.width / 2, dy: -layoutObject.size.height / 2)
		}
	}
}

protocol CGLayoutArea {
	associatedtype Anchor: CGLayoutAnchor
	func point(of anchor: Anchor) -> CGPoint
}

extension CGRect: CGLayoutArea {
	typealias Anchor = CGRectAnhcor
	func point(of anchor: Anchor) -> CGPoint {
		switch anchor {
		case .left: 	return CGPoint(x: minX, y: minY + height / 2)
		case .right: 	return CGPoint(x: maxX, y: minY + height / 2)
		case .top: 		return CGPoint(x: minX + width / 2, y: maxY)
		case .bottom: 	return CGPoint(x: minX + width / 2, y: minY)
		case .center: 	return CGPoint(x: minX + width / 2, y: minY + height / 2) 
		}
	}
}
