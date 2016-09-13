import XCTest
@testable import Maket
import CoreGraphics

class MaketTests: XCTestCase {
    
    func testBasic() {
        let rect = CGRect(x: 200, y: 200, width: 600, height: 600)
        let size = CGSize(width: 100, height: 100)
        let point = size.placePoint(relativeTo: rect, from: .center, vector: .zero)
        XCTAssertEqual(point, .init(x: 450, y: 450))
    }
    
    func testCircle() {
        
    }

}
