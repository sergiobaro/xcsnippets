import Foundation

extension String {
  var pathExtension: String {
    (self as NSString).pathExtension
  }

  var deletingPathExtension: String {
    (self as NSString).deletingPathExtension
  }

  var lastPathComponent: String {
    (self as NSString).lastPathComponent
  }

  func appendingPathComponent(_ path: String) -> String {
    (self as NSString).appendingPathComponent(path)
  }
}
