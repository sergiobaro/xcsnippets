import Foundation

extension Array {
  
  var second: Element? {
    guard self.indices.contains(1) else {
      return nil
    }

    return self[1]
  }
}
