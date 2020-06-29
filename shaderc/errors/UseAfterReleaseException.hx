package shaderc.errors;

@:allow(shaderc)
class UseAfterReleaseException extends Exception {
	public var compiler:ShaderCompiler;

	function new(compiler:ShaderCompiler) {
		this.compiler = compiler;
		super("Use after release");
	}
}
