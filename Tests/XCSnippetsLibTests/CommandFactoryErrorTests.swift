import XCTest
@testable import XCSnippetsLib

class CommandFactoryErrorTests: XCTestCase {

  func test_equatable() {
    XCTAssertTrue(CommandFactoryError.unsupportedCommand("command") == .unsupportedCommand("command"))
    XCTAssertFalse(CommandFactoryError.unsupportedCommand("command1") == .unsupportedCommand("command2"))
  }

}
