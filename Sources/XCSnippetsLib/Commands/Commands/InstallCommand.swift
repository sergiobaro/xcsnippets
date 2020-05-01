import Foundation

struct InstallCommand: Command {

  static var name = "install"
  static var arguments = "<source>"
  static var description = "installs snippets found in <source> to xcode default location"

  let sourcePath: String

  init(args: [String]) throws {
    if args.isEmpty {
      throw CommandError.missingArgument("sourcePath")
    }
    guard let sourcePath = args.first else {
      throw CommandError.missingArgument("sourcePath")
    }

    self.sourcePath = sourcePath
  }

  func run() {

  }
}
