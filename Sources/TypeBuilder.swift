/**
 * Builds a swift type
 */
public class TypeBuilder : Builder {
  public typealias BuiltType = Type
  private var type : Any.Type!

  /**
   * Sets the type
   */
  public func setType(_ type:Any.Type) -> TypeBuilder {
    self.type = type
    return self
  }

  /**
   * Builds the swift type
   */
  public func build() -> BuiltType {
    return Type(type:type)
  }  
}

extension Type {
  /**
   * Returns a swift type builder
   */
  public static func builder() -> TypeBuilder {
    return TypeBuilder()
  }
}
