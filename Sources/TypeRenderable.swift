extension Type : CodeEmitterRenderable {
  public func render() -> [CodeEmitterCommand] {
    return [.Emit(symbol: .Literal(string:"\(type)"))]
  }
}
