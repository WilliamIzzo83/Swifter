class ParamsListRenderable {
  static func renderParametersList(_ parameters:[ParamDecl]) -> [CodeEmitterCommand] {
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
}
