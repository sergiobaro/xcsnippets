import Foundation

struct CopyCommand: Command {

  static var name = "copy"
  static var arguments = "<destination> --replace|-r"
  static var description = "copies snippets found in xcode default location to <destination>"

  private let destinationPath: String
  private let replace: Bool

  init(args: [String]) throws {
    if args.isEmpty {
      throw CommandError.missingArgument("destinationPath")
    }
    guard let destinationPath = args.first else {
      throw CommandError.missingArgument("destinationPath")
    }

    self.destinationPath = destinationPath
    self.replace = args.contains("--replace") || args.contains("-r")
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

      if replace {
        try fm.removeItem(atPath: snippetDestinationPath)
      }

      do {
        try fm.copyItem(atPath: snippetSourcePath, toPath: snippetDestinationPath)
      } catch {
        if error.code == NSFileWriteFileExistsError {
          print("Can not copy file \(snippet) because it already exists. Use --replace or -r to overwrite.")
        }
        else {
          throw error
        }
      }
    }
  }
}
