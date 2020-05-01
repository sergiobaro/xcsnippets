import Foundation
import Yams

struct TranslateCommand: Command {

  static var name = "translate"
  static var arguments = "<file> <destination>"
  static var description = "transforms a <file> from plist to yaml or the other way around and writes it to <destination>"

  private let filePath: String
  private let destinationPath: String

  init(args: [String]) throws {
    guard let filePath = args.first else {
      throw CommandError.missingArgument("file")
    }
    guard let destinationPath = args.second else {
      throw CommandError.missingArgument("destinationPath")
    }

    self.filePath = filePath
    self.destinationPath = destinationPath
  }

  func run() throws {
    let fm = FileManager.default
    guard filePath.pathExtension == Constants.codeSnippetExtension else {
      throw CommandError.formatNotSupported(filePath.pathExtension)
    }
    guard fm.fileExists(atPath: filePath) else {
      throw CommandError.fileNotFound(filePath)
    }
    guard fm.directoryExists(atPath: destinationPath) else {
      throw CommandError.directoryNotFound(destinationPath)
    }

    let file = filePath.lastPathComponent.deletingPathExtension
    
    let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
    let snippet = try PropertyListDecoder().decode(CodeSnippet.self, from: data)
    let yaml = try YAMLEncoder().encode(snippet)

    let destination = destinationPath.appendingPathComponent(file + "." + Constants.yamlCodeSnippetExtension)
    print("Writing to \(destination)")
    try yaml.write(toFile: destination, atomically: true, encoding: .utf8)
  }
}

struct CodeSnippet: Codable {
  let completionPrefix: String
  let completionScopes: [String]
  let identifier: String
  let contents: String
  let language: String
  let summary: String
  let title: String
  let isUser: Bool
  let version: Int

  enum CodingKeys: String, CodingKey {
    case identifier = "IDECodeSnippetIdentifier"
    case completionPrefix = "IDECodeSnippetCompletionPrefix"
    case completionScopes = "IDECodeSnippetCompletionScopes"
    case contents = "IDECodeSnippetContents"
    case language = "IDECodeSnippetLanguage"
    case summary = "IDECodeSnippetSummary"
    case title = "IDECodeSnippetTitle"
    case isUser = "IDECodeSnippetUserSnippet"
    case version = "IDECodeSnippetVersion"
  }
}
