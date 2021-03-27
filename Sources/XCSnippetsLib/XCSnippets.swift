import Foundation

public class XCSnippets {

  public init() {}

  public func run(_ args: [String]) throws {
    let command = try CommandFactory().make(args)
    try command.run()
  }
}
