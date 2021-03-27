import Foundation

public class XCSnippets {

  public init() {}

  public func run(_ args: [String]) throws {
    let command = try CommandFactory(
      files: FilesDefault(),
      shell: ShellDefault(),
      snippetDecoder: CodeSnippetDecoderDefault()
    )
    .make(name: args.first)
    
    try command.run(args: Array(args.dropFirst()))
  }
}
