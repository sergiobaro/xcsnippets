import Foundation

struct Constants {

  static let version = "0.1.0"
  static let snippetsDefaultPath = "/Library/Developer/Xcode/UserData/CodeSnippets/"
  static let codeSnippetExtension = "codesnippet"

  static var commands: [Command.Type] = [
    CopyCommand.self,
    InstallCommand.self,
    ListCommand.self,
    VersionCommand.self,
    HelpCommand.self
  ]
}
