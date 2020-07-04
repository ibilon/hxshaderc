package shaderc;

import cpp.Pointer;
import cpp.UInt32;
import haxe.ds.ReadOnlyArray;

@:allow(shaderc)
@:headerInclude('shaderc/shaderc.h')
class Result<T> {
	/**
		[Internal] This releases the `shaderc_compilation_result_t`.
	**/
	static function createBinary(ptr:Pointer<cpp.Void>):Result<ReadOnlyArray<UInt32>> {
		throw "TODO";

		var data = [];
		var warnings = [];

		// TODO how to split warnings?
		untyped __cpp__('
			shaderc_compilation_result_t result = (shaderc_compilation_result_t)((void*)ptr);

			const char *native_data = shaderc_result_get_bytes(result);
			for (unsigned int i = 0; i < shaderc_result_get_length(result); ++i) {
				data->push(native_data[i]);
			}

			const char *native_warnings = shaderc_result_get_error_message(result);
			warnings->push(native_warnings);

			shaderc_result_release(result);
		');

		return new Result(data, warnings);
	}

	/**
		[Internal] This releases the `shaderc_compilation_result_t`.
	**/
	static function createText(ptr:Pointer<cpp.Void>):Result<String> {
		throw "TODO";
	}

	public var data(default, null):T;

	public var warnings(default, null):ReadOnlyArray<String>;

	/*
		function get_data32():Array<UInt32> {
			var d = new Array<UInt32>();

			for (i in 0...Std.int(_data.length / 4)) {
				d.push((_data[i * 4] << 24) | (_data[i * 4 + 1] << 16) | (_data[i * 4 + 2] << 8) | _data[i * 4 + 3]);
			}

			return d;
		}
	 */
	function new(data:T, warnings:Array<String>) {
		this.data = data;
		this.warnings = warnings;
	}
}
