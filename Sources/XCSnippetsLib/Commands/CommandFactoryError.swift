import Foundation

enum CommandFactoryError: LocalizedError {
  case unsupportedCommand(String)

  var errorDescription: String? {
    switch self {
    case let .unsupportedCommand(command):
      return "Command \(command) not supported"
    }
  }
}

extension CommandFactoryError: Equatable {

  static func == (lhs: CommandFactoryError, rhs: CommandFactoryError) -> Bool {
    switch (lhs, rhs) {
      case let (.unsupportedCommand(a), .unsupportedCommand(b)): return a == b
    }
  }
}
