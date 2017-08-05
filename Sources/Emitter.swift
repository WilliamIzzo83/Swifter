public enum CodeEmitterSymbol {
  case ScopeOpen
  case ScopeClose
  case Comma
  case FunctionResult
  case Space
  case Newline
  case Colon
  case Literal(string:String)
}

public enum CodeEmitterCommand {
  case Emit(symbol:CodeEmitterSymbol)
  case PushIndentation
  case PopIndentation
  case Space
  case Newline
}

public protocol CodeEmitterSymbolRenderer {
  func render(_ symbol:CodeEmitterSymbol) -> String
}

public protocol CodeEmitterCommandReceiver {
  mutating func push(_ command:CodeEmitterCommand)
}

public protocol CodeEmitterCommandExecutor : CodeEmitterCommandReceiver {
  func execute() -> [CodeEmitterSymbol]
}

public protocol OutputBuffer {
  mutating func append(_ string:String)
  mutating func write() throws
}

public protocol CodeEmitterRenderable {
  func render() -> [CodeEmitterCommand]
}

public class CodeEmitter<E: CodeEmitterCommandExecutor, 
R: CodeEmitterSymbolRenderer, O: OutputBuffer> {

  private var commands = [CodeEmitterCommand]()
  private var executor : E
  private var renderer : R
  private var buffer : O

  public init(executor: E, 
       renderer: R,
       buffer: O) {
    self.executor = executor
    self.renderer = renderer
    self.buffer = buffer
  }

  public func emit(_ renderable:CodeEmitterRenderable) throws {
    for command in renderable.render() {
      executor.push(command)
    }

    let symbols = executor.execute()

    for sym in symbols {
      let string = renderer.render(sym)
      buffer.append(string)
    }

    try buffer.write()
  }
}
