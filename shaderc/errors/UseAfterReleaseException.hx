package shaderc.errors;

/**
	The compiler was used after being released.

	A `Compiler` object was used after `Compiler.release` was called.
**/
@:allow(shaderc)
class UseAfterReleaseException extends Exception {
	/** The compiler that was incorrectly used. **/
	public var compiler(default, null):Compiler;

	function new(compiler:Compiler) {
		this.compiler = compiler;
		super("The compiler was used after being released");
	}
}
