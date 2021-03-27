import Foundation

struct InstallCommand: Command {

  static var name = "install"
  static var arguments = "<source> --replace|-r"
  static var description = "installs snippets found in <source> to xcode default location"

  private let files: Files
  private let shell: Shell
  private let snippetDecoder: CodeSnippetDecoder

  init(files: Files, shell: Shell, snippetDecoder: CodeSnippetDecoder) {
    self.files = files
    self.shell = shell
    self.snippetDecoder = snippetDecoder
  }

  func run(args: [String]) throws {
    guard let sourcePath = args.first else {
      throw CommandError.missingArgument("sourcePath")
    }

    let replace = args.contains("--replace") || args.contains("-r")

    let destinationPath = files.homeFolder.appendingPathComponent(Constants.snippetsDefaultPath)
    
    if !files.exists(destinationPath) {
      try files.createFolder(destinationPath)
    }

    guard files.exists(sourcePath) else {
      throw CommandError.directoryNotFound(sourcePath)
    }
    
    let snippets = try files.contents(sourcePath).filter {
      $0.pathExtension == Constants.codeSnippetExtension
    }

    try snippets.forEach { snippet in
      let snippetSourcePath = sourcePath.appendingPathComponent(snippet)
      let snippetDestinationPath = destinationPath.appendingPathComponent(snippet)

      if let snippetCode = try? snippetDecoder.decodePath(snippetSourcePath) {
        shell.echo("Installing \"\(snippet) (\(snippetCode.title))\"")
      } else {
        shell.echo("Installing \"\(snippet)\"")
      }

      if replace {
        try files.delete(snippetDestinationPath)
      }
      
      do {
        try files.copy(from: snippetSourcePath, to: snippetDestinationPath)
      } catch {
        if error.code == NSFileWriteFileExistsError {
          shell.echoError(CommandError.snippetAlreadyExists(snippet))
        } else {
          throw error
        }
      }
    }
  }

}
