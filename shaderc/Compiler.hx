package shaderc;

import cpp.UInt32;
import haxe.ds.ReadOnlyArray;
import shaderc.errors.*;

/**
	A shader compiler.

	Creating a compiler has substantial resource costs, so it is recommended to keep one object around for all tasks.
**/
@:build(shaderc.CompilerBuilder.build())
@:headerInclude('shaderc/shaderc.h')
@:headerClassCode('
	shaderc_compiler_t native;
')
class Compiler {
	/** The version of the SPIR-V which will be produced. **/
	public static var spirvVersion(get, never):{major:Int, minor:Int, revision:Int};

	static function get_spirvVersion():{major:Int, minor:Int, revision:Int} {
		var version:UInt32 = 0;
		var revision:UInt32 = 0;

		untyped __cpp__('shaderc_get_spv_version(&version, &revision)');

		return {
			major: (version >> 16) & 0xFF,
			minor: (version >> 8) & 0xFF,
			revision: revision,
		};
	}

	/**
		Parses the version and profile from a given string containing both version and profile, like: '450core'.

		@param text The text to parse.

		@return The version and profile, or `null` if the string cannot be parsed.
	**/
	public static function parseVersionProfile(text:String):Null<{version:Int, profile:Profile}> {
		var version = 0;
		var profile = Profile.None;

		untyped __cpp__('
			if (!shaderc_parse_version_profile(text, &version, (shaderc_profile*)&profile)) {
				return null();
			}
		');

		return {
			version: version,
			profile: profile,
		};
	}

	/**
		Create a compiler that can be used to compile modules.

		This has substantial resource costs, so it is recommended to keep one object around for all tasks.

		Concurrent use on **different** objects needs no synchronization,
		concurrent invocation of these functions on the **same** object requires synchronization.

		You need to release the object with `ShaderCompiler.release` when you are done using it.
		Using the object after that will throw a `UseAfterReleaseException` exception.

		@throws InitializationErrorException If there was an error initializing the compiler.
	**/
	public function new() {
		untyped __cpp__('{0}->native = shaderc_compiler_initialize()', this);

		if (untyped __cpp__('{0}->native == nullptr', this)) {
			throw new InitializationErrorException();
		}
	}

	/**
		Compile a SPIR-V assembly text into a SPIR-V binary.

		May be safely called from multiple threads without explicit synchronization.

		@param source The source of the shader, if `Options.sourceLanguage` isn't set it will be treated as GLSL..
		@param options Optional, if set then the compilation is modified by any options present that affects assembly.

		@throws CompilationFailureException If there was failure in allocating the compiler object.
		@throws UseAfterReleaseException If the object was released.
	**/
	public function assemble(source:String, ?options:Options):Result<ReadOnlyArray<UInt32>> {
		validate();

		if (options == null) {
			options = {};
		}

		final _options = options.toNative();

		untyped __cpp__('
			shaderc_compile_options_t native_options = (shaderc_compile_options_t)((void*)_options);
			shaderc_compilation_result_t result = shaderc_assemble_into_spv(native, source, source.length, native_options);
			shaderc_compile_options_release(native_options);
		');

		if (untyped __cpp__('result == nullptr')) {
			throw new CompilationFailureException(this);
		}

		return Result.createBinary(untyped __cpp__('result'));
	}

	/**
		Compile a shader into a SPIR-V binary.

		May be safely called from multiple threads without explicit synchronization.

		@param source The source of the shader, if `Options.sourceLanguage` isn't set it will be treated as GLSL.
		@param kind The shader kind. If the shader kind is not set to a specified kind, but  `Kind.InferFromSource`, the compiler will try to deduce the shader kind from the source string and a failure in deducing will generate an error. Currently only #pragma annotation is supported. If the shader kind is set to one of the default shader kinds, the compiler will fall back to the default shader kind in case it failed to deduce the shader kind from source string.
		@param filename Used as a tag to identify the source string in cases like emitting error messages. It doesn't have to be a 'file name'.
		@param entryPoint Defines the name of the entry point.
		@param options Optional, if set then the compilation is modified by any options present.

		@throws CompilationFailureException If there was failure in allocating the compiler object.
		@throws UseAfterReleaseException If the object was released.
	**/
	public function compile(source:String, kind:Kind, filename:String, entryPoint:String, ?options:Options):Result<ReadOnlyArray<UInt32>> {
		validate();

		if (options == null) {
			options = {};
		}

		final _options = options.toNative();

		untyped __cpp__('
			shaderc_compile_options_t native_options = (shaderc_compile_options_t)((void*)_options);
			shaderc_compilation_result_t result = shaderc_compile_into_spv(native, source, source.length, (shaderc_shader_kind)kind, filename, entryPoint, native_options);
			shaderc_compile_options_release(native_options);
		');

		if (untyped __cpp__('result == nullptr')) {
			throw new CompilationFailureException(this);
		}

		return Result.createBinary(untyped __cpp__('result'));
	}

	/**
		Compiles a shader into SPIR-V assembly text.

		The SPIR-V assembly syntax is as defined by the SPIRV-Tools open source project.

		May be safely called from multiple threads without explicit synchronization.

		@param source The source of the shader, if `Options.sourceLanguage` isn't set it will be treated as GLSL.
		@param kind The shader kind. If the shader kind is not set to a specified kind, but  `Kind.InferFromSource`, the compiler will try to deduce the shader kind from the source string and a failure in deducing will generate an error. Currently only #pragma annotation is supported. If the shader kind is set to one of the default shader kinds, the compiler will fall back to the default shader kind in case it failed to deduce the shader kind from source string.
		@param filename Used as a tag to identify the source string in cases like emitting error messages. It doesn't have to be a 'file name'.
		@param entryPoint Defines the name of the entry point.
		@param options Optional, if set then the compilation is modified by any options present.

		@throws CompilationFailureException If there was failure in allocating the compiler object.
		@throws UseAfterReleaseException If the object was released.
	**/
	public function compileIntoAssembly(source:String, kind:Kind, filename:String, entryPoint:String, ?options:Options):Result<String> {
		validate();

		if (options == null) {
			options = {};
		}

		final _options = options.toNative();

		untyped __cpp__('
			shaderc_compile_options_t native_options = (shaderc_compile_options_t)((void*)_options);
			shaderc_compilation_result_t result = shaderc_compile_into_spv_assembly(native, source, source.length, (shaderc_shader_kind)kind, filename, entryPoint, native_options);
			shaderc_compile_options_release(native_options);
		');

		if (untyped __cpp__('result == nullptr')) {
			throw new CompilationFailureException(this);
		}

		return Result.createText(untyped __cpp__('result'));
	}

	/**
		Compiles a shader into preprocessed source code.

		May be safely called from multiple threads without explicit synchronization.

		@param source The source of the shader, if `Options.sourceLanguage` isn't set it will be treated as GLSL.
		@param filename Used as a tag to identify the source string in cases like emitting error messages. It doesn't have to be a 'file name'.
		@param entryPoint Defines the name of the entry point.
		@param options Optional, if set then the compilation is modified by any options present.

		@throws CompilationFailureException If there was failure in allocating the compiler object.
		@throws UseAfterReleaseException If the object was released.
	**/
	public function preprocess(source:String, filename:String, entryPoint:String, ?options:Options):Result<String> {
		validate();

		if (options == null) {
			options = {};
		}

		final _options = options.toNative();

		untyped __cpp__('
			shaderc_compile_options_t native_options = (shaderc_compile_options_t)((void*)_options);
			shaderc_compilation_result_t result = shaderc_compile_into_preprocessed_text(native, source, source.length, shaderc_vertex_shader, filename, entryPoint, native_options);
			shaderc_compile_options_release(native_options);
		');

		if (untyped __cpp__('result == nullptr')) {
			throw new CompilationFailureException(this);
		}

		return Result.createText(untyped __cpp__('result'));
	}

	/**
		Releases the resources held by the compiler.

		Using the object after that will throw a `UseAfterReleaseException` exception.

		@throws UseAfterReleaseException If the object was released.
	**/
	public function release():Void {
		validate();
		untyped __cpp__('shaderc_compiler_release(native)');
	}

	function validate():Void {
		if (untyped __cpp__('native == nullptr')) {
			throw new UseAfterReleaseException(this);
		}
	}
}
