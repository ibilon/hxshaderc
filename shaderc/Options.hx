package shaderc;

import cpp.Pointer;
import shaderc.options.*;

/**
	Compilation options.

	To be created using a structure init:
	```haxe
	var options:CompilationOptions = {
		autoBindUniforms: false,
		// ...
	};
	```
**/
@:allow(shaderc)
@:headerInclude('shaderc/shaderc.h')
@:structInit
class Options {
	/**
		Optional, sets whether the compiler should automatically assign bindings to uniforms that aren't already explicitly bound in the shader source.

		Defaults to `false`.
	**/
	@:optional public var autoBindUniforms:Null<Bool>;

	/**
		Optional, sets whether the compiler should automatically assign locations to uniform variables that don't have explicit locations in the shader source.

		Defaults to `false`.
	**/
	@:optional public var autoMapLocations:Null<Bool>;

	/**
		Optional, sets the base binding number used for for a uniform resource type when automatically assigning bindings. For GLSL compilation, sets the lowest automatically assigned number. For HLSL compilation, the regsiter number assigned to the resource is added to this specified base.
	**/
	@:optional public var bindingBases:Null<Map<UniformKind, Int>>;

	/**
		Optional, like `Options.bindingBases`, but only takes effect when compiling a given shader stage. The stage is assumed to be one of `Kind.Vertex`, `Kind.Fragment`, `Kind.TessellationEvaluation`, `Kind.TesselationControl`, `Kind.Geometry`, or `Kind.Compute`.
	**/
	@:optional public var bindingBasesForStage:Null<Map<Kind, Map<UniformKind, Int>>>;

	/**
		Optional, forces the GLSL language version and profile to a given pair.

		The version number is the same as would appear in the #version annotation in the source.

		Version and profile specified here overrides the #version annotation in the source. Use profile: `Profile.None` for GLSL versions that do not define profiles, e.g. versions below 150.

		Default version is 110.
	**/
	@:optional public var forcedVersionProfile:Null<{version:Int, profile:Profile}>;

	/**
		Optional, sets the compiler mode to generate debug information in the output.

		Defaults to `false`.
	**/
	@:optional public var generateDebugInfo:Null<Bool>;

	/**
		HLSL specific options.

		These are ignored if the source language is GLSL.
	**/
	@:optional public var hlsl:Null<HlslOptions>;

	/**
		Whether the compiler should determine block member offsets using HLSL packing rules instead of standard GLSL rules.

		Defaults to `false`.

		Only affects GLSL compilation, HLSL rules are always used when compiling HLSL.
	**/
	@:optional public var hlslOffsets:Null<Bool>;

	// TODO @:optional public var includeCallbacks

	/**
		Optional, sets whether the compiler should invert position.Y output in vertex shader.

		Defaults to `false`.
	**/
	@:optional public var invertY:Null<Bool>;

	/**
		Optional, sets resources limit.
	**/
	@:optional public var limits:Null<Map<Limit, Int>>;

	/**
		Optional, adds predefined macros.

		If the value is `null`, it has the same effect as passing -Dname to the command-line compiler.
	**/
	@:optional public var macroDefinitions:Null<Map<String, Null<String>>>;

	/**
		Optional, sets whether the compiler generates code for max and min builtins which, if given a NaN operand, will return the other operand.

		Similarly, the clamp builtin will favour the non-NaN operands, as if clamp were implemented as a composition of max and min.

		Defaults to `false`.
	**/
	@:optional public var nanClamp:Null<Bool>;

	/**
		Optional, sets the compiler optimization level to the given level.

		Defaults to `OptimizationLevel.None`.
	**/
	@:optional public var optimizationLevel:Null<OptimizationLevel>;

	/**
		Optinal, sets the source language.

		Defaults to `SourceLanguage.Glsl`.
	**/
	@:optional public var sourceLanguage:Null<SourceLanguage>;

	/**
		Optional, sets the compiler mode to suppress warnings, overriding `Options.warningsAsError` mode.

		When both `Options.supressWarnings` and `Options.warningsAsError` are `true`, warning messages will be inhibited, and will not be emitted as error messages.

		Defaults to `false`.
	**/
	@:optional public var suppressWarnings:Null<Bool>;

	/**
		Optional, sets the target shader environment, affecting which warnings or errors will be issued.

		Defaults to `TargetEnvironment.Vulkan`.
	**/
	@:optional public var targetEnvironment:Null<TargetEnvironment>;

	/**
		Optional, sets the target SPIR-V version.

		The generated module will use this version of SPIR-V.
		Each target environment determines what versions of SPIR-V it can consume.

		Defaults to the highest version of SPIR-V 1.0 which is required to be supported by the target environment, e.g. default to SPIR-V 1.0 for Vulkan 1.0 and SPIR-V 1.3 for Vulkan 1.1.
	**/
	@:optional public var targetSpirvVersion:Null<SpirvVersion>;

	/**
		Optional, sets the compiler mode to treat all warnings as errors.

		Note `Options.supressWarnings` overrides this option, i.e. if both `Options.warningsAsError` and `Options.supressWarnings` are `true`, warnings will not be emitted as error messages.
	**/
	@:optional public var warningsAsErrors:Null<Bool>;

	/**
		Returns a deep clone of these options.

		Modifying either will not affect the other.
	**/
	public function clone():Options {
		return {
			autoBindUniforms: autoBindUniforms,
			autoMapLocations: autoMapLocations,
			bindingBases: bindingBases == null ? null : [for (kind => base in bindingBases) kind => base],
			bindingBasesForStage: bindingBasesForStage == null ? null : [
				for (stage => binding in bindingBasesForStage)
					for (kind => base in binding)
						stage => [kind => base]
			],
			forcedVersionProfile: forcedVersionProfile == null ? null : {
				version: forcedVersionProfile.version,
				profile: forcedVersionProfile.profile,
			},
			hlsl: hlsl == null ? null : {
				functionality1: hlsl.functionality1,
				ioMapping: hlsl.ioMapping,
				registerSetAndBinding: hlsl.registerSetAndBinding == null ? null : [
					for (register => descriptor in hlsl.registerSetAndBinding)
						register => {
							set: descriptor.set,
							binding: descriptor.binding
						}
				],
				registerSetAndBindingForStage: hlsl == null || hlsl.registerSetAndBindingForStage == null ? null : [
					for (kind => value in hlsl.registerSetAndBindingForStage)
						for (register => descriptor in value)
							kind => [
								register => {
									set: descriptor.set,
									binding: descriptor.binding,
								}
							]
				],
			},
			hlslOffsets: hlslOffsets,
			// TODO includeCallbacks
			invertY: invertY,
			limits: limits == null ? null : [for (limit => value in limits) limit => value],
			macroDefinitions: macroDefinitions == null ? null : [for (define => value in macroDefinitions) define => value],
			nanClamp: nanClamp,
			optimizationLevel: optimizationLevel,
			sourceLanguage: sourceLanguage,
			suppressWarnings: suppressWarnings,
			targetEnvironment: targetEnvironment,
			targetSpirvVersion: targetSpirvVersion,
			warningsAsErrors: warningsAsErrors,
		};
	}

	/**
		[Internal] You need to release the `shaderc_compile_options_t` after using it.
	**/
	function toNative():Pointer<cpp.Void> {
		untyped __cpp__('shaderc_compile_options_t options = shaderc_compile_options_initialize()');

		if (autoBindUniforms != null) {
			untyped __cpp__('shaderc_compile_options_set_auto_bind_uniforms(options, autoBindUniforms)');
		}

		if (autoMapLocations != null) {
			untyped __cpp__('shaderc_compile_options_set_auto_map_locations(options, autoMapLocations)');
		}

		if (bindingBases != null) {
			for (kind => base in bindingBases) {
				untyped __cpp__('shaderc_compile_options_set_binding_base(options, (shaderc_uniform_kind)kind, base)');
			}
		}

		if (bindingBasesForStage != null) {
			for (stage => binding in bindingBasesForStage) {
				for (kind => base in binding) {
					untyped __cpp__('shaderc_compile_options_set_binding_base_for_stage(options, (shaderc_shader_kind)kind, (shaderc_uniform_kind)kind, base)');
				}
			}
		}

		if (forcedVersionProfile != null) {
			final version = forcedVersionProfile.version;
			final profile = forcedVersionProfile.profile;
			untyped __cpp__('shaderc_compile_options_set_forced_version_profile(options, version, (shaderc_profile)((unsigned int)profile))');
		}

		if (generateDebugInfo != null && generateDebugInfo) {
			untyped __cpp__('shaderc_compile_options_set_generate_debug_info(options)');
		}

		if (hlsl != null && hlsl.functionality1 != null) {
			untyped __cpp__('shaderc_compile_options_set_hlsl_functionality1(options, {0})', hlsl.functionality1);
		}

		if (hlsl != null && hlsl.ioMapping != null) {
			untyped __cpp__('shaderc_compile_options_set_hlsl_io_mapping(options, {0})', hlsl.ioMapping);
		}

		if (hlsl != null && hlsl.registerSetAndBinding != null) {
			for (_register => descriptor in hlsl.registerSetAndBinding) {
				final set = descriptor.set;
				final binding = descriptor.binding;
				untyped __cpp__('shaderc_compile_options_set_hlsl_register_set_and_binding(options, _register, set, binding)');
			}
		}

		if (hlsl != null && hlsl.registerSetAndBindingForStage != null) {
			for (kind => value in hlsl.registerSetAndBindingForStage) {
				for (_register => descriptor in value) {
					final set = descriptor.set;
					final binding = descriptor.binding;
					untyped __cpp__('shaderc_compile_options_set_hlsl_register_set_and_binding_for_stage(options, (shaderc_shader_kind)kind, _register, set, binding)');
				}
			}
		}

		if (hlslOffsets != null) {
			untyped __cpp__('shaderc_compile_options_set_hlsl_offsets(options, hlslOffsets)');
		}

		// TODO includeCallbacks

		if (invertY != null) {
			untyped __cpp__('shaderc_compile_options_set_invert_y(options, invertY)');
		}

		if (limits != null) {
			for (limit => value in limits) {
				untyped __cpp__('shaderc_compile_options_set_limit(options, (shaderc_limit)limit, value)');
			}
		}

		if (macroDefinitions != null) {
			for (define => value in macroDefinitions) {
				if (value == null) {
					untyped __cpp__('shaderc_compile_options_add_macro_definition(options, define, define.length, nullptr, 0)');
				} else {
					untyped __cpp__('shaderc_compile_options_add_macro_definition(options, define, define.length, value, value.length)');
				}
			}
		}

		if (nanClamp != null) {
			untyped __cpp__('shaderc_compile_options_set_nan_clamp(options, nanClamp)');
		}

		if (optimizationLevel != null) {
			untyped __cpp__('shaderc_compile_options_set_optimization_level(options, (shaderc_optimization_level)((unsigned int)optimizationLevel))');
		}

		if (sourceLanguage != null) {
			untyped __cpp__('shaderc_compile_options_set_source_language(options, (shaderc_source_language)((unsigned int)sourceLanguage))');
		}

		if (suppressWarnings != null && suppressWarnings) {
			untyped __cpp__('shaderc_compile_options_set_suppress_warnings(options)');
		}

		if (targetEnvironment != null) {
			var version = 0;
			var env = switch (targetEnvironment) {
				case Vulkan(v):
					version = cast v;
					0;
				case OpenGL:
					1;
				case OpenGLCompat:
					2;
				case WebGPU:
					3;
			}

			untyped __cpp__('shaderc_compile_options_set_target_env(options, (shaderc_target_env)env, version)');
		}

		if (targetSpirvVersion != null) {
			untyped __cpp__('shaderc_compile_options_set_target_spirv(options, (shaderc_spirv_version)((unsigned int)targetSpirvVersion))');
		}

		if (warningsAsErrors != null && warningsAsErrors) {
			untyped __cpp__('shaderc_compile_options_set_warnings_as_errors(options)');
		}

		return untyped __cpp__('options');
	}
}
