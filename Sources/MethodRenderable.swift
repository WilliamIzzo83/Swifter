extension Method : CodeEmitterRenderable {
  private func renderParams() -> [CodeEmitterCommand] {
    return ParamsListRenderable.renderParametersList(parameters)
  }
  
  private func renderStatements() -> [CodeEmitterCommand] {
    return StatementsRenderable.renderStatements(statements)
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
    commands.append(contentsOf: renderStatements())
    commands.append(.PopIndentation)
    commands.append(.Newline)
    commands.append(.Emit(symbol: .ScopeClose))
    commands.append(.Newline)

    return commands
  }
}
