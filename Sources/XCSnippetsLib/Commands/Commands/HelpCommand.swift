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
      "  \($0.name) \($0.arguments):  \($0.description)"
    }
    .joined(separator: "\n")

    print("\n\(result)\n")
  }
}
