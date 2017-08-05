public class ParamDeclBuilder : Builder {
  public typealias BuiltType = ParamDecl
  private var identifier : String!
  private var type : Type!

  public func setIdentifier(_ identifier:String) -> ParamDeclBuilder {
    self.identifier = identifier 
    return self
  }

  public func setType(_ type:Type) -> ParamDeclBuilder {
    self.type = type
    return self
  }

  public func build() -> BuiltType {
    return ParamDecl(type: type, identifier: identifier)
  }
}

extension ParamDecl {
  public static func builder() -> ParamDeclBuilder {
    return ParamDeclBuilder()
  }
}
