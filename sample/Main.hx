package sample;

import shaderc.*;

class Main {
	static function main() {
		trace(ShaderCompiler.spirvVersion);
		trace(ShaderCompiler.parseVersionProfile("450core").profile == Core);
		trace(ShaderCompiler.parseVersionProfile("320").profile == None);
		trace(ShaderCompiler.parseVersionProfile("error") == null);

		var compiler = new ShaderCompiler();
		compiler.release();
	}
}
