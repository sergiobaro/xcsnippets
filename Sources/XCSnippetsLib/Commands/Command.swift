import Foundation

protocol Command {

  static var name: String { get }
  static var arguments: String { get }
  static var description: String { get }

  func run() throws
}

enum CommandError: LocalizedError {
  case missingArgument(String)
  case directoryNotFound(String)

  var errorDescription: String? {
    switch self {
    case let .missingArgument(argument):
      return "Missing argument <\(argument)>"
    case let .directoryNotFound(dir):
      return "Directoty not found \"\(dir)\""
    }
  }
}
