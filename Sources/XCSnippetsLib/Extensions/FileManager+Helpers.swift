import Foundation

extension FileManager {

  func directoryExists(atPath path: String) -> Bool {
    var isDirectory = ObjCBool(false)
    fileExists(atPath: path, isDirectory: &isDirectory)

    return isDirectory.boolValue
  }

  func replaceItemAt(originalItemPath: String, withItemAtPath newItemPath: String) throws {
    let originalURL = URL(fileURLWithPath: originalItemPath)
    let newURL = URL(fileURLWithPath: newItemPath)

    try replaceItem(at: originalURL, withItemAt: newURL, backupItemName: nil, options: [], resultingItemURL: nil)
  }

  func copyItemAt(originalItemPath: String, withItemAtPath newItemPath: String, overwrite: Bool) throws {
    if overwrite {
      try replaceItemAt(originalItemPath: originalItemPath, withItemAtPath: newItemPath)
      return
    }

    try copyItem(atPath: originalItemPath, toPath: newItemPath)
  }
}
