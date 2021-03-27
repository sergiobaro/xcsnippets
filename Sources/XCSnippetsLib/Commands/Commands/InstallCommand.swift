import Foundation

struct InstallCommand: Command {

  static var name = "install"
  static var arguments = "<source> --replace|-r"
  static var description = "installs snippets found in <source> to xcode default location"

  private let files: Files
  private let shell: Shell

  init(files: Files, shell: Shell, snippetDecoder: CodeSnippetDecoder) {
    self.files = files
    self.shell = shell
  }

  func run(args: [String]) throws {
    if args.isEmpty {
      throw CommandError.missingArgument("sourcePath")
    }
    guard let sourcePath = args.first else {
      throw CommandError.missingArgument("sourcePath")
    }

    let replace = args.contains("--replace") || args.contains("-r")

    let fm = FileManager.default
    let destinationPath = fm.homeDirectoryForCurrentUser.path + Constants.snippetsDefaultPath
    
    if !fm.directoryExists(atPath: destinationPath) {
      try fm.createDirectory(atPath: destinationPath)
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
