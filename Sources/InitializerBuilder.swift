public class InitializerBuilder : Builder {
  public typealias BuiltType = Initializer
  private var parameters = [ParamDecl]()
  private var statements = [String]()

  public func setParameters(_ parameters:[ParamDecl]) -> InitializerBuilder {
    self.parameters = parameters
    return self
  }

  public func addStatement(_ stmt:String) -> InitializerBuilder {
    statements.append(stmt)
    return self
  }

  public func build() -> BuiltType {
    return Initializer(parameters:parameters,
                       statements:statements)
  }
}

extension Initializer {
  static func builder() -> InitializerBuilder {
    return InitializerBuilder()
  }
}
