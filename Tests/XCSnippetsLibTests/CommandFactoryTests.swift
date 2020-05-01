import XCTest
@testable import XCSnippetsLib

class CommandFactoryTests: XCTestCase {

  let factory = CommandFactory()

  func test_make_commandNotSupported() {
    XCTAssertThrowsError(try factory.make(["hi"])) { error in
      XCTAssertTrue(error as? CommandFactoryError == .unsupportedCommand("hi"))
    }
  }

  func test_make_missingCommand() throws {
    let command = try factory.make([])
    XCTAssertTrue(command is HelpCommand)
  }

  func test_make_copyCommand() throws {
    let command = try factory.make(["copy", "destinationPath"])
    XCTAssertTrue(command is CopyCommand)
  }

  func test_make_installCommand() throws {
    let command = try factory.make(["install", "sourcePath"])
    XCTAssertTrue(command is InstallCommand)
  }

  func test_make_versionCommand() throws {
    let command = try factory.make(["version"])
    XCTAssertTrue(command is VersionCommand)
  }

  func test_make_helpCommand() throws {
    let command = try factory.make(["help"])
    XCTAssertTrue(command is HelpCommand)
  }
  
}
