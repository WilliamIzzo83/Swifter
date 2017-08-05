/**
 * Protocol defining an interface for builder objects
 */
public protocol Builder {
  /// Type being built by the builder
  associatedtype BuiltType
  /// Builds a type
  /// returns - an instance of BuiltType type
  func build() -> BuiltType
}
