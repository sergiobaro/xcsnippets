import XCTest
@testable import XCSnippetsLib

class XCSnippetsLibTests: XCTestCase {

  func test() {
    XCTAssertNoThrow(try XCSnippets().run([]))
  }

}
