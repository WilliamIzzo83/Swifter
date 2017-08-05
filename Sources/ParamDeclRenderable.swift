extension ParamDecl : CodeEmitterRenderable {
  public func render() -> [CodeEmitterCommand] {
    // identifier : type
    let commands : [CodeEmitterCommand] = [
      .Emit(symbol: .Literal(string: "\(identifier)")),
      CodeEmitterCommand.Space,
      .Emit(symbol: .Colon),
      CodeEmitterCommand.Space
    ] + type.render()
    return commands
  }
}
