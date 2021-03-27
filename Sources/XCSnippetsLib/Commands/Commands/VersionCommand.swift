import Foundation

struct VersionCommand: Command {

  static var name = "version"
  static var arguments = ""
  static var description = "displays current version"

  init(args: [String]) {}

  func run() {
    print(Constants.version)
  }
}
