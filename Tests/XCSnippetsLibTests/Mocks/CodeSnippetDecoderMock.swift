@testable import XCSnippetsLib

class CodeSnippetDecoderMock: CodeSnippetDecoder {

  var snippetToReturn: CodeSnippet?

  func decodePath(_ path: String) throws -> CodeSnippet? {
    snippetToReturn
  }
}
