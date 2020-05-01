import Foundation

struct CopyCommand: Command {

  static var name = "copy"
  static var arguments = "<destination>"
  static var description = "copies snippets found in xcode default location to <destination>"

  let destinationPath: String

  init(args: [String]) throws {
    if args.isEmpty {
      throw CommandError.missingArgument("destinationPath")
    }
    guard let destinationPath = args.first else {
      throw CommandError.missingArgument("destinationPath")
    }

    self.destinationPath = destinationPath
  }

  func run() {

  }
}
