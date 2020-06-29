package shaderc;

import cpp.Pointer;
import shaderc.options.*;

@:headerInclude('shaderc/shaderc.h')
@:structInit
class CompilationOptions {
	@:optional public var autoBindUniforms:Null<Bool>;

	@:optional public var autoMapLocations:Null<Bool>;

	@:optional public var bindingBases:Null<Map<UniformKind, UInt>>;

	@:optional public var bindingBasesForStage:Null<Map<ShaderKind, Map<UniformKind, UInt>>>;

	@:optional public var forcedVersionProfile:Null<{version:Int, profile:Profile}>;

	@:optional public var generateDebugInfo:Null<Bool>;

	@:optional public var hlsl:Null<HlslOptions>;

	// TODO @:optional public var includeCallbacks
	@:optional public var invertY:Null<Bool>;

	@:optional public var limits:Null<Map<Limit, Int>>;

	@:optional public var macroDefinitions:Null<Map<String, Null<String>>>;

	@:optional public var nanClamp:Null<Bool>;

	@:optional public var optimizationLevel:Null<OptimizationLevel>;

	@:optional public var sourceLanguage:Null<SourceLanguage>;

	@:optional public var suppressWarnings:Null<Bool>;

	@:optional public var targetEnvironment:Null<TargetEnvironment>;

	@:optional public var targetSpirvVersion:Null<SpirvVersion>;

	@:optional public var warningsAsErrors:Null<Bool>;

	public function clone():CompilationOptions {
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
				offsets: hlsl.offsets,
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
		You need to release the shaderc_compile_options_t after using it.
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

		if (hlsl != null && hlsl.offsets != null) {
			untyped __cpp__('shaderc_compile_options_set_hlsl_offsets(options, {0})', hlsl.offsets);
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
