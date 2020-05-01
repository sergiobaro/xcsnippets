import Foundation

struct CopyCommand: Command {

  static var name = "copy"
  static var arguments = "<destination>"
  static var description = "copies snippets found in xcode default location to <destination>"

  let destinationPath: String

  init(args: [String]) throws {
    if args.isEmpty {
      throw CommandError.missingArgument("destinationPath")
    }
    guard let destinationPath = args.first else {
      throw CommandError.missingArgument("destinationPath")
    }

    self.destinationPath = destinationPath
  }

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
      let snippetSourcePath = sourcePath.appendingPathComponent(snippet)
      let snippetDestinationPath = destinationPath.appendingPathComponent(snippet)
      print("Copying \"\(snippet)\"")
      try fm.copyItem(atPath: snippetSourcePath, toPath: snippetDestinationPath)
    }
  }
}
