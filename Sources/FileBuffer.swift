import Foundation

public struct FileOutputBuffer : OutputBuffer {
  private let filePath : URL
  private var buffer : String
 
  init(path:String) {
    filePath = URL(fileURLWithPath: path)
    buffer = ""
  }

  init(urlPath:URL) {
    filePath = urlPath
    buffer = ""
  }

  public mutating func append(_ string:String) {
    buffer += string
  }

  public mutating func write() throws {
    try buffer.write(to: filePath, atomically: true, encoding: .utf8)
    buffer = ""
  }
}
