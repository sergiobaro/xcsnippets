import Foundation

protocol CodeSnippetDecoder {

  func decodePath(_ path: String) throws -> CodeSnippet?
}

class CodeSnippetDecoderDefault: CodeSnippetDecoder {

  func decodePath(_ path: String) throws -> CodeSnippet? {
    guard let data = try String(contentsOfFile: path).data(using: .utf8) else {
      return nil
    }

    return try PropertyListDecoder().decode(CodeSnippet.self, from: data)
  }
}
