import Foundation

struct CodeSnippetPlist: Codable {
  let prefix: String
  let scopes: [String]
  let contents: String
  let identifier: String
  let language: String
  let summary: String
  let title: String
  let isUser: Bool
  let version: Int

  enum CodingKeys: String, CodingKey {
    case prefix = "IDECodeSnippetCompletionPrefix"
    case scopes = "IDECodeSnippetCompletionScopes"
    case contents = "IDECodeSnippetContents"
    case identifier = "IDECodeSnippetIdentifier"
    case language = "IDECodeSnippetLanguage"
    case summary = "IDECodeSnippetSummary"
    case title = "IDECodeSnippetTitle"
    case isUser = "IDECodeSnippetUserSnippet"
    case version = "IDECodeSnippetVersion"
  }
}
