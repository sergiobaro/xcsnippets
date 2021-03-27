import XCTest
import Nimble
@testable import XCSnippetsLib

class ListCommandTests: XCTestCase {

  private let filesMock = FilesMock()
  private let shellMock = ShellMock()
  private let snippetDecoderMock = CodeSnippetDecoderMock()
  private lazy var command = ListCommand(files: filesMock, shell: shellMock, snippetDecoder: snippetDecoderMock)

  func test_folderNotFound_shouldThrowError() throws {
    expect(try self.command.run(args: ["folder"])).to(throwError(CommandError.directoryNotFound("folder")))
  }

  func test_folderIsEmpty() throws {
    filesMock.folders = [
      "folder": []
    ]

    expect(try self.command.run(args: ["folder"])).toNot(throwError())
    expect(self.shellMock.echoMessages.first).to(equal("No snippets found in folder"))
  }

  func test_folder_oneSnippet() throws {
    filesMock.folders = [
      "folder": [
        "snippet.codesnippet"
      ]
    ]
    snippetDecoderMock.snippetToReturn = .init(title: "title")

    try command.run(args: ["folder"])
    expect(self.shellMock.echoMessages.first).to(equal("snippet.codesnippet (title)"))
  }
}
