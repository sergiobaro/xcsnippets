import Foundation

struct HelpCommand: Command {

  static var commandName = "help"
  static var commandArguments = ""
  static var commandDescription = "displays this text"

  private let shell: Shell

  init(files: Files, shell: Shell, snippetDecoder: CodeSnippetDecoder) {
    self.shell = shell
  }

  func run(args: [String]) throws {
    let result = Constants.commands.map {
      let argumentsString = $0.commandArguments.isEmpty ? "" : " " + $0.commandArguments
      let usageString = "  \($0.commandName)\(argumentsString):".padding(toLength: 35, withPad: " ", startingAt: 0)
      return usageString + $0.commandDescription
    }
    .joined(separator: "\n")

    shell.echo("\n\(result)\n")
  }
}
