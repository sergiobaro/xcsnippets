import Foundation

struct InstallCommand: Command {

  static var name = "install"
  static var arguments = "<source> --replace|-r"
  static var description = "installs snippets found in <source> to xcode default location"

  let sourcePath: String
  let replace: Bool

  init(args: [String]) throws {
    if args.isEmpty {
      throw CommandError.missingArgument("sourcePath")
    }
    guard let sourcePath = args.first else {
      throw CommandError.missingArgument("sourcePath")
    }

    self.sourcePath = sourcePath
    self.replace = args.contains("--replace") || args.contains("-r")
  }

  func run() throws {
    let fm = FileManager.default
    let destinationPath = fm.homeDirectoryForCurrentUser.path + Constants.snippetsDefaultPath

    guard fm.directoryExists(atPath: destinationPath) else {
      throw CommandError.directoryNotFound(destinationPath)
    }
    guard fm.directoryExists(atPath: sourcePath) else {
      throw CommandError.directoryNotFound(sourcePath)
    }

    let snippets = try fm.contentsOfDirectory(atPath: sourcePath).filter {
      $0.pathExtension == Constants.codeSnippetExtension
    }

    try snippets.forEach { snippet in
      let snippetSourcePath = sourcePath.appendingPathComponent(snippet)
      let snippetDestinationPath = destinationPath.appendingPathComponent(snippet)
      print("Installing \"\(snippet)\"")

      if replace {
        try fm.removeItem(atPath: snippetDestinationPath)
      }
      
      do {
        try fm.copyItem(atPath: snippetSourcePath, toPath: snippetDestinationPath)
      } catch {
        if error.code == NSFileWriteFileExistsError {
          print("Can not install file \(snippet) because it already exists. Use --replace or -r to overwrite.")
        } else {
          throw error
        }
      }
    }
  }

}