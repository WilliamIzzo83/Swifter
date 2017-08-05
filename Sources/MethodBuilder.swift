
public class MethodBuilder : Builder {
  public typealias BuiltType = Method
  private var returnType = Type(type: Void.self)
  private var parameters = [ParamDecl]()
  private var name : String!
  private var initializer = false

  public func setReturnType(_ type:Type) -> MethodBuilder {
    returnType = type
    return self
  }

  public func setParameters(_ parameters:[ParamDecl]) -> MethodBuilder {
    self.parameters = parameters
    return self
  }

  public func setName(_ name:String) -> MethodBuilder {
    self.name = name
    return self
  }

  public func setIsInitializer(_ isInitializer:Bool) -> MethodBuilder {
    initializer = isInitializer
    return self
  }

  public func build() -> BuiltType {
    return Method(returnType:returnType, 
                  parameters:parameters,
                  name:name, 
                  initializer:initializer)
  }
}

extension Method {
  public static func builder() -> MethodBuilder {
    return MethodBuilder()
  }
}

