import Foundation

extension String {
  var pathExtension: String {
    (self as NSString).pathExtension
  }

  func appendingPathComponent(_ path: String) -> String {
    (self as NSString).appendingPathComponent(path)
  }
}
