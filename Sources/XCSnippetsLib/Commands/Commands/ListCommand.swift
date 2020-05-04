
import Foundation

struct ListCommand: Command {

  static var name = "list"
  static var arguments = ""
  static var description = "lists installed snippets"

  func run() throws {
    let fm = FileManager.default
    let sourcePath = fm.homeDirectoryForCurrentUser.path + Constants.snippetsDefaultPath

    guard fm.directoryExists(atPath: sourcePath) else {
      throw CommandError.directoryNotFound(sourcePath)
    }

    let snippets = try fm.contentsOfDirectory(atPath: sourcePath).filter {
      $0.pathExtension == Constants.codeSnippetExtension
    }

    snippets.forEach { snippet in
      print(snippet)
    }
  }
  
}
