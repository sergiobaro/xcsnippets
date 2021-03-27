import Foundation

struct VersionCommand: Command {

  static var name = "version"
  static var arguments = ""
  static var description = "displays current version"

  private let shell: Shell

  init(files: Files, shell: Shell, snippetDecoder: CodeSnippetDecoder) {
    self.shell = shell
  }

  func run(args: [String]) {
    shell.echo(Constants.version)
  }
}
