import Foundation
@testable import XCSnippetsLib

class FilesMock: Files {

  var folders = [String: [String]]()

  var currentFolder = ""
  var homeFolder = ""

  func exists(_ path: String) -> Bool {
    folders.keys.contains(path)
  }

  func contents(_ path: String) throws -> [String] {
    folders[path] ?? []
  }

  func isDirectory(_ path: String) -> Bool {
    false
  }

  func subfolders(_ path: String) throws -> [String] {
    []
  }

  func changeCurrentFolder(_ path: String) {
    // empty
  }

  var deleteCalled = false
  var deletePath: String?
  func delete(_ path: String) throws {
    deleteCalled = true
    deletePath = path
  }

  func createFolder(_ path: String) throws {
    // empty
  }

  func copy(from: String, to: String) throws {
    // empty
  }
}
