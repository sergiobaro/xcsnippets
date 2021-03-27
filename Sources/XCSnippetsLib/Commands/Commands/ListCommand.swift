import Foundation

struct ListCommand: Command {

  static var name = "list"
  static var arguments = "<folder>"
  static var description = "lists snippets in folder or installed folders"

  private let files: Files
  private let shell: Shell
  private let snippetDecoder: CodeSnippetDecoder

  init(files: Files, shell: Shell, snippetDecoder: CodeSnippetDecoder) {
    self.files = files
    self.shell = shell
    self.snippetDecoder = snippetDecoder
  }

  func run(args: [String]) throws {
    let folder = args.first ?? files.homeFolder.appendingPathComponent(Constants.snippetsDefaultPath)

    guard files.exists(folder) else {
      throw CommandError.directoryNotFound(folder)
    }

    let snippets = try files.contents(folder).filter {
      return $0.pathExtension == Constants.codeSnippetExtension
    }

    if snippets.isEmpty {
      shell.echo("No snippets found in \(folder)")
      return
    }

    try snippets.forEach { snippet in
      let snippetPath = folder.appendingPathComponent(snippet)
      guard let codeSnippet = try snippetDecoder.decodePath(snippetPath) else {
        shell.echo("\(snippet) (error decoding)")
        return
      }
      shell.echo("\(snippet) (\(codeSnippet.title))")
    }
  }
}
