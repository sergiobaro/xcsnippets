import Foundation
@testable import XCSnippetsLib

extension CodeSnippet {

  init(title: String) {
    self.init(
      prefix: "",
      scopes: [],
      contents: "",
      identifier: "",
      language: "",
      summary: "",
      title: title,
      isUser: true,
      version: 2
    )
  }
}
