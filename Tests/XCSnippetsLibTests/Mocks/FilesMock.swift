import Foundation
@testable import XCSnippetsLib

class FilesMock: Files {

  var structure = [String: Any]()

  var currentFolder = ""
  var homeFolder = ""

  func exists(_ path: String) -> Bool {
    structure.keys.contains(path)
  }

  func contents(_ path: String) throws -> [String] {
    (structure[path] as? [String]) ?? []
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
  func delete(_ path: String) throws {
    deleteCalled = true
  }

  func createFolder(_ path: String) throws {
    // empty
  }
}
