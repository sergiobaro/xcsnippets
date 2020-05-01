import Foundation

extension FileManager {

  func directoryExists(atPath path: String) -> Bool {
    var isDirectory = ObjCBool(false)
    fileExists(atPath: path, isDirectory: &isDirectory)

    return isDirectory.boolValue
  }
}
