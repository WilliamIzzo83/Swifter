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

public enum IvarQualifier {
  case `public`
  case `private`
  case `const`
  case `var`
}

public struct IvarDecl : TypeDecl {
  public let type : Type
  public let identifier : String
  public let qualifiers : [IvarQualifier]
}

public struct Method {
  public let returnType : Type
  public let parameters : [ParamDecl]
  public let name : String 
  public let statements : [String]
}

public struct Initializer {
  public let parameters : [ParamDecl]
  public let statements : [String]
}

public enum ObjectType {
  case `class`
  case `struct`
}

public protocol Object {
  var type : ObjectType { get }
  var name : String { get }
  var initializer : Initializer { get }
  var methods : [Method] { get }
  var ivars : [IvarDecl] { get }
}
