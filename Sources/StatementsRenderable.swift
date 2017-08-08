class StatementsRenderable {
  static func renderStatements(_ statements:[String]) -> [CodeEmitterCommand] {
    guard statements.count > 0 else {
      return []
    }
  
    var commands = [CodeEmitterCommand]()
    
    guard statements.count > 1 else {
      commands.append(.Emit(symbol: .Literal(string: statements.first!)))
      return commands
    }
   
    let stmts_minus_last = statements.prefix(statements.count - 1)
  
    for stmt in stmts_minus_last {
      commands.append(.Emit(symbol: .Literal(string: stmt)))
      commands.append(.Newline)
    }
  
    let last_stmt = statements.last!
    commands.append(.Emit(symbol: .Literal(string: last_stmt)))
  
    return commands
  }
}
