import Foundation

struct VersionCommand: Command {

  static var name = "version"
  static var arguments = ""
  static var description = "displays current version"

  func run() throws {
    print(Constants.version)
  }
}
