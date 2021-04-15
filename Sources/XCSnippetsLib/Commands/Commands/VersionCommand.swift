import Foundation

struct VersionCommand: Command {

  static var commandName = "version"
  static var commandArguments = ""
  static var commandDescription = "displays current version"

  private let shell: Shell

  init(files: Files, shell: Shell, snippetDecoder: CodeSnippetDecoder) {
    self.shell = shell
  }

  func run(args: [String]) {
    shell.echo(Constants.version)
  }
}
