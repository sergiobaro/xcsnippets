import Foundation

struct CopyCommand: Command {

  static var name = "copy"
  static var arguments = "<destination> --replace|-r"
  static var description = "copies snippets found in xcode default location to <destination>"

  private let files: Files
  private let shell: Shell
  private let snippetDecoder: CodeSnippetDecoder

  init(files: Files, shell: Shell, snippetDecoder: CodeSnippetDecoder) {
    self.files = files
    self.shell = shell
    self.snippetDecoder = snippetDecoder
  }

  func run(args: [String]) throws {
    guard let destinationPath = args.first else {
      throw CommandError.missingArgument("destinationPath")
    }

    let replace = args.contains("--replace") || args.contains("-r")

    let sourcePath = files.homeFolder.appendingPathComponent(Constants.snippetsDefaultPath)

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
        shell.echo("Copying \"\(snippet) (\(snippetCode.title))\"")
      } else {
        shell.echo("Copying \"\(snippet)\"")
      }

      if replace {
        try files.delete(snippetDestinationPath)
      }

      do {
        try files.copy(fromPath: snippetSourcePath, toPath: snippetDestinationPath)
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
