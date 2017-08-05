public class StdCodeEmitterSymbolRenderer : CodeEmitterSymbolRenderer {
  public func render(_ symbol:CodeEmitterSymbol) -> String {
    switch(symbol) {
      case .ScopeOpen           : return "{"
      case .ScopeClose          : return "}"
      case .Comma               : return ","
      case .FunctionResult      : return "->"
      case .Space               : return " "
      case .Newline             : return "\n"
      case .Colon               : return ":"
      case .Literal(let string) : return string
    }
  }
}
