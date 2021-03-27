import XCTest
import Nimble
@testable import XCSnippetsLib

class ListCommandTests: XCTestCase {

  private let filesMock = FilesMock()
  private let shellMock = ShellMock()
  private let snippetDecoderMock = CodeSnippetDecoderMock()
  private lazy var command = ListCommand(files: filesMock, shell: shellMock, snippetDecoder: snippetDecoderMock)

  func test_noFolder_shouldThrowError() throws {
    expect(try self.command.run(args: ["folder"])).to(throwError(CommandError.directoryNotFound("folder")))
  }

  func test_emptyFolder() throws {
    filesMock.structure = [
      "folder": []
    ]

    expect(try self.command.run(args: ["folder"])).toNot(throwError())
    expect(self.shellMock.echoMessages.first).to(equal("No snippets found in folder"))
  }

  func test_folder() throws {
    filesMock.structure = [
      "folder": [
        "snippet.codesnippet"
      ]
    ]
    snippetDecoderMock.snippetToReturn = .init(prefix: "", scopes: [], contents: "", identifier: "", language: "", summary: "", title: "title", isUser: true, version: 2)

    try command.run(args: ["folder"])
    expect(self.shellMock.echoMessages.first).to(equal("snippet.codesnippet (title)"))
  }
}
