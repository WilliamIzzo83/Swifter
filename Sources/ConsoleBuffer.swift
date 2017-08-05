public struct ConsoleBuffer : OutputBuffer {
  private var buffer = ""

  public mutating func append(_ string:String) {
    buffer += string
  } 

  public mutating func write() throws {
    print(buffer)
    buffer = ""
  }
}

