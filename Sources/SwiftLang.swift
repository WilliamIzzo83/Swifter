public struct Type {
  public let type : Any.Type
}

public protocol TypeDecl {
  var type : Type { get }
  var identifier : String { get }
}

public struct ParamDecl : TypeDecl {
  public let type : Type
  public let identifier : String
}

public struct Method {
  public let returnType : Type
  public let parameters : [ParamDecl]
  public let name : String
  public let initializer : Bool
  public let statements : [String]
}


