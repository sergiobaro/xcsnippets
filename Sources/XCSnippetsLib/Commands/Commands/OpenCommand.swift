import Foundation

struct OpenCommand: Command {

  static var commandName = "open"
  static var commandArguments = ""
  static var commandDescription = "opens default snippets folder"

  private let files: Files
  private let shell: Shell

  init(files: Files, shell: Shell, snippetDecoder: CodeSnippetDecoder) {
    self.files = files
    self.shell = shell
  }

  func run(args: [String]) throws {
    let folder = files.homeFolder.appendingPathComponent(Constants.snippetsDefaultPath)
    shell.run("open \(folder)")
  }
}
