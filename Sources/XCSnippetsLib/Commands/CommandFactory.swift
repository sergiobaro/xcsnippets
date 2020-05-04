import Foundation

class CommandFactory {

  private let allCommands: [Command.Type] = [
    CopyCommand.self,
    InstallCommand.self,
    ListCommand.self,
    VersionCommand.self,
    HelpCommand.self
  ]

  func make(_ args: [String]) throws -> Command {
    guard let commandString = args.first else {
      return HelpCommand(commands: allCommands)
    }

    let commandArguments = Array(args.dropFirst())
    if commandString == CopyCommand.name {
      return try CopyCommand(args: commandArguments)
    }
    if commandString == InstallCommand.name {
      return try InstallCommand(args: commandArguments)
    }
    if commandString == ListCommand.name {
      return ListCommand()
    }
    if commandString == VersionCommand.name {
      return VersionCommand()
    }
    if commandString == HelpCommand.name {
      return HelpCommand(commands: allCommands)
    }

    throw CommandFactoryError.unsupportedCommand(commandString)
  }
}
