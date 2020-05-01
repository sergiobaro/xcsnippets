import Foundation

struct HelpCommand: Command {

  static var name = "help"
  static var arguments = ""
  static var description = "displays this text"

  private let commands: [Command.Type]

  init(commands: [Command.Type]) {
    self.commands = commands
  }

  func run() throws {
    let result = commands.map {
      let argumentsString = $0.arguments.isEmpty ? "" : " " + $0.arguments
      let usageString = "  \($0.name)\(argumentsString):".padding(toLength: 35, withPad: " ", startingAt: 0)
      return usageString + $0.description
    }
    .joined(separator: "\n")

    print("\n\(result)\n")
  }
}
