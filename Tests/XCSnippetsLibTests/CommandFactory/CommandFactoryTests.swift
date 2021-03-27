import XCTest
@testable import XCSnippetsLib

class CommandFactoryTests: XCTestCase {

  private let filesMock = FilesMock()
  private let shellMock = ShellMock()
  private let snippetDecoderMock = CodeSnippetDecoderMock()
  private lazy var factory = CommandFactory(files: filesMock, shell: shellMock, snippetDecoder: snippetDecoderMock)

  func test_make_commandNotSupported() {
    XCTAssertThrowsError(try factory.make(name: "hi")) { error in
      XCTAssertTrue(error as? CommandFactoryError == .unsupportedCommand("hi"))
    }
  }

  func test_make_missingCommand() throws {
    let command = try factory.make(name: "")
    XCTAssertTrue(command is HelpCommand)
  }

  func test_make_copyCommand() throws {
    let command = try factory.make(name: "copy")
    XCTAssertTrue(command is CopyCommand)
  }

  func test_make_installCommand() throws {
    let command = try factory.make(name: "install")
    XCTAssertTrue(command is InstallCommand)
  }

  func test_make_versionCommand() throws {
    let command = try factory.make(name: "version")
    XCTAssertTrue(command is VersionCommand)
  }

  func test_make_helpCommand() throws {
    let command = try factory.make(name: "help")
    XCTAssertTrue(command is HelpCommand)
  }

  func test_make_listCommand() throws {
    let command = try factory.make(name: "list")
    XCTAssertTrue(command is ListCommand)
  }
}
