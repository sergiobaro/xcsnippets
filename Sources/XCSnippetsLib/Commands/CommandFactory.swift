import Foundation

class CommandFactory {

  func make(_ args: [String]) throws -> Command {
    guard let commandName = args.first else {
      return try HelpCommand(args: [])
    }

    for command in Constants.commands {
      if commandName == command.name {
        let commandArgs = Array(args.dropFirst())
        return try command.init(args: commandArgs)
      }
    }

    throw CommandFactoryError.unsupportedCommand(commandName)
  }
}
