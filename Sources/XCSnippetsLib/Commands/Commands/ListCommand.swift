
import Foundation

struct ListCommand: Command {

  static var name = "list"
  static var arguments = ""
  static var description = "lists installed snippets"

  init(args: [String]) throws {}

  func run() throws {
    let fm = FileManager.default
    let sourcePath = fm.homeDirectoryForCurrentUser.path + Constants.snippetsDefaultPath

    guard fm.directoryExists(atPath: sourcePath) else {
      throw CommandError.directoryNotFound(sourcePath)
    }

    let snippets = try fm.contentsOfDirectory(atPath: sourcePath).filter {
      $0.pathExtension == Constants.codeSnippetExtension
    }

    try snippets.forEach { snippet in
      let snippetPath = sourcePath.appendingPathComponent(snippet)
      guard let data = try String(contentsOfFile: snippetPath).data(using: .utf8) else {
        print(snippet)
        return
      }

      let codeSnippet = try PropertyListDecoder().decode(CodeSnippetPlist.self, from: data)
      print("\(snippet) (\(codeSnippet.title))")
    }
  }
  
}
