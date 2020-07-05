package shaderc.errors;

/**
	An error occurred during compilation.
**/
@:allow(shaderc)
class CompilationFailureException extends Exception {
	/** The compiler that failed the compilation. **/
	public var compiler(default, null):Compiler;

	/** The error reason. **/
	public var reason(default, null):CompilationFailureReason;

	function new(compiler:Compiler, reason:CompilationFailureReason) {
		this.compiler = compiler;
		this.reason = reason;
		super("An error occurred during compilation");
	}

	override function toString():String {
		return switch (reason) {
			case CompilationError(_, message), InternalError(message), InvalidStage(message), InvalidAssembly(message), NullResultObject(message),
				ValidationError(message), TransformationError(message), ConfigurationError(message):
				'${this.message}\n$message';
		}
	}
}

/**
	Compilation failure reason.

	Each enumerant holds its error message.
**/
enum CompilationFailureReason {
	CompilationError(number:Int, message:String);
	InternalError(message:String);
	InvalidStage(message:String);
	InvalidAssembly(message:String);
	NullResultObject(message:String);
	ValidationError(message:String);
	TransformationError(message:String);
	ConfigurationError(message:String);
}
