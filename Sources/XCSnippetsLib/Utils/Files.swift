import Foundation

protocol Files {

  var currentFolder: String { get }
  var homeFolder: String { get }

  func exists(_ path: String) -> Bool
  func contents(_ path: String) throws -> [String]
  func isDirectory(_ path: String) -> Bool
  func subfolders(_ path: String) throws -> [String]
  func changeCurrentFolder(_ path: String)

  func delete(_ path: String) throws
  func createFolder(_ path: String) throws
  func copy(from: String, to: String) throws
}

class FilesDefault: Files {

  var currentFolder: String { fileManager.currentDirectoryPath }
  var homeFolder: String { fileManager.homeDirectoryForCurrentUser.path }

  private let fileManager = FileManager.default

  func exists(_ path: String) -> Bool {
    fileManager.fileExists(atPath: path)
  }

  func contents(_ path: String) throws -> [String] {
    try fileManager.contentsOfDirectory(atPath: path)
  }

  func isDirectory(_ path: String) -> Bool {
    var isDirectory: ObjCBool = false
    guard fileManager.fileExists(atPath: path, isDirectory: &isDirectory) else {
      return false
    }
    return isDirectory.boolValue
  }

  func subfolders(_ path: String) throws -> [String] {
    try fileManager.contentsOfDirectory(atPath: path)
      .filter { isDirectory($0) }
  }

  func changeCurrentFolder(_ path: String) {
    fileManager.changeCurrentDirectoryPath(path)
  }

  func delete(_ path: String) throws {
    try fileManager.removeItem(atPath: path)
  }

  func createFolder(_ path: String) throws {
    try fileManager.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
  }

  func copy(from: String, to: String) throws {
    try fileManager.copyItem(atPath: from, toPath: to)
  }
}
