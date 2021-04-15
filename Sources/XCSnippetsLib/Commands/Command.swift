import Foundation

enum CommandError: LocalizedError {

  case missingArgument(_ argument: String)
  case directoryNotFound(_ directory: String)
  case fileNotFound(_ file: String)
  case formatNotSupported(_ format: String)
  case snippetAlreadyExists(_ command: Command, _ snippet: String)

  var errorDescription: String? {
    switch self {
    case let .missingArgument(argument):
      return "Missing argument <\(argument)>"
    case let .directoryNotFound(directory):
      return "Directoty not found \"\(directory)\""
    case let .fileNotFound(file):
      return "File not found \"\(file)\""
    case let .formatNotSupported(format):
      return "Format \"\(format)\" not supported"
    case let .snippetAlreadyExists(command, snippet):
      let commandName = type(of: command).commandName
      return "Can not \(commandName) file \(snippet) because it already exists. Use --replace or -r to overwrite."
    }
  }
}

protocol Command {

  static var commandName: String { get }
  static var commandArguments: String { get }
  static var commandDescription: String { get }

  init(files: Files, shell: Shell, snippetDecoder: CodeSnippetDecoder)

  func run(args: [String]) throws
}
