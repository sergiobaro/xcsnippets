import XCTest
import Yams
@testable import XCSnippetsLib

class CodeSnippetCodableTests: XCTestCase {
  private let codesnippet = """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>IDECodeSnippetCompletionPrefix</key>
      <string>mark</string>
      <key>IDECodeSnippetCompletionScopes</key>
      <array>
        <string>All</string>
      </array>
      <key>IDECodeSnippetContents</key>
      <string>// MARK: - mark</string>
      <key>IDECodeSnippetIdentifier</key>
      <string>C67BE7BF-805B-46E6-B527-3AEA47D88081</string>
      <key>IDECodeSnippetLanguage</key>
      <string>Xcode.SourceCodeLanguage.Swift</string>
      <key>IDECodeSnippetSummary</key>
      <string></string>
      <key>IDECodeSnippetTitle</key>
      <string>Assert Throws Error</string>
      <key>IDECodeSnippetUserSnippet</key>
      <true/>
      <key>IDECodeSnippetVersion</key>
      <integer>2</integer>
    </dict>
    </plist>
  """

  func test_decode_plist() throws {
    let data = codesnippet.data(using: .utf8)!
    let codesnippet = try PropertyListDecoder().decode(CodeSnippet.self, from: data)

    XCTAssertEqual(codesnippet.completionPrefix, "mark")
    XCTAssertEqual(codesnippet.completionScopes, ["All"])
    XCTAssertEqual(codesnippet.identifier, "C67BE7BF-805B-46E6-B527-3AEA47D88081")
    XCTAssertEqual(codesnippet.contents, "// MARK: - mark")
    XCTAssertEqual(codesnippet.language, "Xcode.SourceCodeLanguage.Swift")
    XCTAssertEqual(codesnippet.summary, "")
    XCTAssertEqual(codesnippet.title, "Assert Throws Error")
    XCTAssertTrue(codesnippet.isUser)
    XCTAssertEqual(codesnippet.version, 2)
  }

  func test_encode_yaml() throws {
    let codesnippet = CodeSnippet(
      completionPrefix: "prefix",
      completionScopes: ["All"],
      identifier: "id",
      contents: "content",
      language: "swift",
      summary: "",
      title: "snippet",
      isUser: true,
      version: 0
    )
    let _ = try YAMLEncoder().encode(codesnippet)
  }
}
