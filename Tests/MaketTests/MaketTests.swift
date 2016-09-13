import XCTest
@testable import Maket
import CoreGraphics

class MaketTests: XCTestCase {

    let rect = CGRect(x: 200, y: 200, width: 600, height: 600)
    
    func testBasic() {
        let size = CGSize(width: 100, height: 100)
        let point = size.placePoint(relativeTo: rect, from: .center, vector: .zero)
        XCTAssertEqual(point, .init(x: 450, y: 450))
    }
    
    func testCircle() {
        
    }
    
    func testCustom() {
        let custom = CGCustomFigure.rectBased { (context, rect) in
            context.fill(rect)
            print(rect)
        }
        let figure = custom.ofSize(CGSize(width: 200, height: 200))
        let point = figure.placePoint(relativeTo: rect, from: .center, vector: .down(by: 10))
    }

}
