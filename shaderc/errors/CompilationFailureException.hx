package shaderc.errors;

/**
	An error occurred during compilation.
**/
@:allow(shaderc)
class CompilationFailureException extends Exception {
	/** The compiler that failed the compilation. **/
	public var compiler:Compiler;

	function new(compiler:Compiler) {
		this.compiler = compiler;
		super("An error occurred during compilation");
	}
}
