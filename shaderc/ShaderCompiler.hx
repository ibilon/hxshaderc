package shaderc;

@:build(shaderc.ShaderCompilerBuilder.build())
@:headerInclude('shaderc/shaderc.h')
@:headerClassCode('
	shaderc_compiler_t native;
')
class ShaderCompiler {
	public function new() {
		untyped __cpp__('{0}->native = shaderc_compiler_initialize()', this);
	}

	public function release():Void {
		untyped __cpp__('shaderc_compiler_release(native)');
	}
}
