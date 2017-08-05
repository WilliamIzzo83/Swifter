public class StdCodeEmitterCommandExecutor : CodeEmitterCommandExecutor {
  private var commands = [CodeEmitterCommand]()
  
  public func push(_ command:CodeEmitterCommand) {
    commands.append(command)
  }

  public func execute() -> [CodeEmitterSymbol] {
    var symbols = [CodeEmitterSymbol]()
    var indentation = 0
    
    while true {
      guard commands.first != nil else {
        break // we're done
      }
      let command = commands.removeFirst()
      
      switch command {
        case .Emit(let symbol) : 
          let output = emitSymbol(symbol)
          symbols.append(contentsOf: output)
        case .PushIndentation : 
          indentation = pushIndentation(indentation)
        case .PopIndentation : 
          indentation = popIndentation(indentation) 
        case .Space :
          let out = emitSpace()
          symbols.append(contentsOf: out)
        case .Newline : 
          let out = emitNewline(indentation)
          symbols.append(contentsOf: out)
      }   
    } 
    return symbols
  }

  private func emitSymbol(_ symbol:CodeEmitterSymbol) -> [CodeEmitterSymbol] {
    return [symbol] 
  }
  
  private func pushIndentation(_ current: Int) -> Int {
    return current + 1
  }

  private func popIndentation(_ current: Int) -> Int {
    return max(0, current - 1)
  }

  private func emitSpace() -> [CodeEmitterSymbol] {
    return [CodeEmitterSymbol.Space]
  } 
  
  private func emitNewline(_ indentation:Int) -> [CodeEmitterSymbol] {
    guard indentation > 0 else {
      return [CodeEmitterSymbol.Newline] 
    }

    return [CodeEmitterSymbol.Newline] + emitIndentation(indentation)
  }

  private func emitIndentation(_ currentIndentation: Int) 
  -> [CodeEmitterSymbol] { 
    return Array(repeating: CodeEmitterSymbol.Space, 
                 count: currentIndentation * 2)
  }
}
