extension Method : CodeEmitterRenderable {
  private func renderParams() -> [CodeEmitterCommand] {
    guard parameters.count > 0 else {
      return []
    }

    guard parameters.count > 1 else {
      return parameters.first!.render()
    }
    
    var commands = [CodeEmitterCommand]()
    let params_minus_last = parameters.prefix(parameters.count - 1)
    for param in params_minus_last {
      commands.append(contentsOf: param.render())
      commands.append(.Emit(symbol: .Comma))
      commands.append(.Space)
    }

    commands.append(contentsOf: parameters.last!.render())

    return commands
  }
  
  public func render() -> [CodeEmitterCommand] {
    // func $name($parameters) -> $returnType
    var commands = [CodeEmitterCommand]()

    commands.append(.Emit(symbol: .Literal(string: "func")))
    commands.append(.Space)
    commands.append(.Emit(symbol: .Literal(string: name)))
    commands.append(.Emit(symbol: .Literal(string:"(")))
    commands.append(contentsOf: renderParams())
    commands.append(.Emit(symbol: .Literal(string:")")))
    commands.append(.Space)
    commands.append(.Emit(symbol: .FunctionResult))
    commands.append(.Space) 
    commands.append(contentsOf: returnType.render())
    commands.append(.Space)
    commands.append(.Emit(symbol: .ScopeOpen))
    commands.append(.PushIndentation)
    commands.append(.Newline)
    // TODO: render other statements here
    commands.append(.PopIndentation)
    commands.append(.Newline)
    commands.append(.Emit(symbol: .ScopeClose))
    commands.append(.Newline)

    return commands
  }
}
