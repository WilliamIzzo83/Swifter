import XCTest
@testable import swifter

class swifterTests: XCTestCase {
    private func getEmitter(path:URL) -> FileEmitter {
      let executor = StdCodeEmitterCommandExecutor()
      let renderer = StdCodeEmitterSymbolRenderer()
      let buffer = FileOutputBuffer(urlPath: path)
      return FileEmitter(executor: executor,
                         renderer: renderer,
                         buffer: buffer)
    }

    private func startEmitterTest(path:URL, 
                                  renderable : CodeEmitterRenderable,
                                  test: (String) ->Void) {

      let emitter = getEmitter(path: path)
      try! emitter.emit(renderable)
      let buffer_contents = try! String(contentsOf: path, encoding: .utf8)
      // TODO: erase file
      test(buffer_contents)
    }
    
    func testStdCodeEmitterSymbolRenderer() {
      let renderer = StdCodeEmitterSymbolRenderer()
      
      XCTAssertEqual(renderer.render(.ScopeOpen), "{")
      XCTAssertEqual(renderer.render(.ScopeClose), "}")
      XCTAssertEqual(renderer.render(.Comma), ",")
      XCTAssertEqual(renderer.render(.FunctionResult), "->")
      XCTAssertEqual(renderer.render(.Space), " ")
      XCTAssertEqual(renderer.render(.Newline), "\n")
      XCTAssertEqual(renderer.render(.Colon), ":")
      XCTAssertEqual(renderer.render(.Literal(string:"ciao")), "ciao")

    }

    func testStdCodeEmitterCommandExecutor() {
      let executor = StdCodeEmitterCommandExecutor()
      let renderer = StdCodeEmitterSymbolRenderer()
      executor.push(.Emit(symbol:.ScopeOpen))
      executor.push(.Space)
      executor.push(.Emit(symbol:.Literal(string:"hello")))
      executor.push(.Space)
      executor.push(.Emit(symbol:.ScopeClose))

      var output = ""
      for symbol in executor.execute() {
        output.append(renderer.render(symbol))
      }

      XCTAssertEqual(output, "{ hello }")
    }
 
    func testStdCodeEmitterCommandExecutorIndentation() {
      let executor = StdCodeEmitterCommandExecutor()
      let renderer = StdCodeEmitterSymbolRenderer()

      executor.push(.Emit(symbol:.ScopeOpen))
      executor.push(.PushIndentation)
      executor.push(.Newline)  
      executor.push(.Emit(symbol:.Literal(string:"hello")))
      executor.push(.Emit(symbol:.Colon))
      executor.push(.Space)
      executor.push(.Emit(symbol:.ScopeOpen))
      executor.push(.PushIndentation)
      executor.push(.Newline)
      executor.push(.Emit(symbol:.Literal(string:"to")))
      executor.push(.Emit(symbol:.Colon))
      executor.push(.Space)
      executor.push(.Emit(symbol:.Literal(string:"world")))
      executor.push(.PopIndentation)
      executor.push(.Newline)
      executor.push(.Emit(symbol:.ScopeClose)) 
      executor.push(.PopIndentation)
      executor.push(.Newline)
      executor.push(.Emit(symbol:.ScopeClose))

      var output = ""
      for symbol in executor.execute() {
        output.append(renderer.render(symbol))
      }
      
      XCTAssertEqual(output, "{\n  hello: {\n    to: world\n  }\n}")
    }   
    
    func testFileOutputBuffer() {
      let path = URL(fileURLWithPath: "fileobuffer.test.out")
      var buffer = FileOutputBuffer(urlPath: path)
      buffer.append("{")
      buffer.append("\n  ")
      buffer.append("hello: ")
      buffer.append("{")
      buffer.append("\n    ")
      buffer.append("to: world")
      buffer.append("\n  ")
      buffer.append("}")
      buffer.append("\n")
      buffer.append("}") 
      try! buffer.write()
      let buffer_contents = try! String(contentsOf: path, encoding: .utf8)

      XCTAssertEqual(buffer_contents, 
        "{\n  hello: {\n    to: world\n  }\n}")
      // TODO: erase test file
   }
   
   
   func testStdTypeEmitter() {
     let path = URL(fileURLWithPath: "emitter.test.out")
     let type = Type.builder().setType(String.self).build()
 
     startEmitterTest(path: path, renderable: type) {
       XCTAssertEqual($0, "String")
     }
    
  }

  func testStdParamDeclEmitter() {
    let path = URL(fileURLWithPath: "emitter.test.out")

    let param_decl = ParamDecl.builder()
      .setType(Int.self)
      .setIdentifier("foo")
      .build()

    startEmitterTest(path: path, renderable: param_decl) {
      XCTAssertEqual($0, "foo : Int")
    }
  }
  
  func testStdZeroParamMethodEmitter() {
    let path = URL(fileURLWithPath: "method.0.test.out")
    let method = Method.builder()
     .setReturnType(Int.self)
     .setName("fooMethod")
     .build()

    startEmitterTest(path: path, renderable: method) {
      XCTAssertEqual($0, "func fooMethod() -> Int {\n  \n}\n")
    } 
  }

  func testStdOneParamMethodEmitter() {
    let path = URL(fileURLWithPath: "method.1.test.out")
    let method = Method.builder()
     .setReturnType(Int.self)
     .setName("fooMethod")
     .setParameters([
       ParamDecl.builder()
         .setType(Float.self)
         .setIdentifier("flt_p")
         .build()
     ])
     .build()

    startEmitterTest(path: path, renderable: method) {
      XCTAssertEqual($0, "func fooMethod(flt_p : Float) -> Int {\n  \n}\n")
    } 
  }

  func testStdTwoParamMethodEmitter() {
    let path = URL(fileURLWithPath: "method.2.test.out")
    let method = Method.builder()
     .setReturnType(Int.self)
     .setName("fooMethod")
     .setParameters([
       ParamDecl.builder()
         .setType(Float.self)
         .setIdentifier("flt_p")
         .build(),
       ParamDecl.builder()
         .setType(Int.self)
         .setIdentifier("int_p")
         .build()
     ])
     .build()

    startEmitterTest(path: path, renderable: method) {
      XCTAssertEqual($0, "func fooMethod(flt_p : Float, int_p : Int) -> Int {\n  \n}\n")
    } 
  }

  func testStdNParamMethodEmitter() {
    let path = URL(fileURLWithPath: "method.n.test.out")
    let method = Method.builder()
     .setReturnType(Int.self)
     .setName("fooMethod")
     .setParameters([
       ParamDecl.builder()
         .setType(Float.self)
         .setIdentifier("flt_p")
         .build(),
       ParamDecl.builder()
         .setType(Int.self)
         .setIdentifier("int_p")
         .build(),
       ParamDecl.builder()
         .setType(Double.self)
         .setIdentifier("dbl_p")
         .build(),
       ParamDecl.builder()
         .setType(String.self)
         .setIdentifier("str_p")
         .build()
     ])
     .build()

    startEmitterTest(path: path, renderable: method) {
      XCTAssertEqual($0, 
       "func fooMethod(flt_p : Float, int_p : Int, dbl_p : Double, str_p : String) -> Int {\n  \n}\n")
    } 
  } 
}
