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
  case fileNotFound(String)
  case formatNotSupported(String)

  var errorDescription: String? {
    switch self {
    case let .missingArgument(argument):
      return "Missing argument <\(argument)>"
    case let .directoryNotFound(dir):
      return "Directoty not found \"\(dir)\""
    case let .fileNotFound(file):
      return "File not found \"\(file)\""
    case let .formatNotSupported(format):
      return "Format \"\(format)\" not supported"
    }
  }
}
