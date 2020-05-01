import XCSnippetsLib

do {
  try XCSnippets().run(Array(CommandLine.arguments.dropFirst()))
} catch {
  print(error.localizedDescription)
}
