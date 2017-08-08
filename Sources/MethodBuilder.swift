
public class MethodBuilder : Builder {
  public typealias BuiltType = Method
  private var returnType = Type(type: Void.self)
  private var parameters = [ParamDecl]()
  private var name : String!
  private var initializer = false
  private var statements : [String] = []

  public func setReturnType(_ type:Any.Type) -> MethodBuilder {
    returnType = Type.builder().setType(type).build()
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

  public func addStatement(_ stmt:String) -> MethodBuilder {
    statements.append(stmt)
    return self
  }

  public func build() -> BuiltType {
    return Method(returnType:returnType, 
                  parameters:parameters,
                  name:name, 
                  initializer:initializer,
		  statements:statements)
  }
}

extension Method {
  public static func builder() -> MethodBuilder {
    return MethodBuilder()
  }
}

