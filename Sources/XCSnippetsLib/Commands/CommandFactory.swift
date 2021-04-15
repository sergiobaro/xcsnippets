import Foundation

class CommandFactory {

  private let files: Files
  private let shell: Shell
  private let snippetDecoder: CodeSnippetDecoder

  init(files: Files, shell: Shell, snippetDecoder: CodeSnippetDecoder) {
    self.files = files
    self.shell = shell
    self.snippetDecoder = snippetDecoder
  }

  func make(name: String?) throws -> Command {
    guard let name = name, !name.isEmpty else {
      return HelpCommand(files: files, shell: shell, snippetDecoder: snippetDecoder)
    }
    guard let command = findCommand(name: name) else {
      throw CommandFactoryError.unsupportedCommand(name)
    }

    return command
  }

  private func findCommand(name: String) -> Command? {
    Constants.commands
      .first { $0.commandName == name }
      .map { $0.init(files: files, shell: shell, snippetDecoder: snippetDecoder) }
  }
}
