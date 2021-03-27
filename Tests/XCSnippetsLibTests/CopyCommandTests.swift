import XCTest
import Nimble
@testable import XCSnippetsLib

class CopyCommandTests: XCTestCase {

  private let filesMock = FilesMock()
  private let shellMock = ShellMock()
  private let snippetDecoderMock = CodeSnippetDecoderMock()
  private lazy var command = CopyCommand(files: filesMock, shell: shellMock, snippetDecoder: snippetDecoderMock)

  func test_noDestinationArg_shouldThrowError() throws {
    expect(try self.command.run(args: [])).to(throwError(CommandError.missingArgument("destination")))
  }

  func test_destinationNotFound_shouldThrowError() throws {
    expect(try self.command.run(args: ["folder"])).to(throwError(CommandError.directoryNotFound("folder")))
  }

  func test_destinationFolderEmpty() throws {
    filesMock.folders = [
      "folder": [],
      Constants.snippetsDefaultPath: []
    ]

    expect(try self.command.run(args: ["folder"])).toNot(throwError())
  }

  func test_oneSnippet() throws {
    filesMock.folders = [
      "folder": [],
      Constants.snippetsDefaultPath: ["snippet.codesnippet"]
    ]

    expect(try self.command.run(args: ["folder"])).toNot(throwError())

    expect(self.shellMock.echoMessages.first).to(equal("Copying \"snippet.codesnippet\""))
  }
}
