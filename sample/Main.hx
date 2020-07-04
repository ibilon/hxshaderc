package sample;

import shaderc.*;

class Main {
	static function main() {
		trace(Compiler.spirvVersion);
		trace(Compiler.parseVersionProfile("450core").profile == Core);
		trace(Compiler.parseVersionProfile("320").profile == None);
		trace(Compiler.parseVersionProfile("error") == null);

		var compiler = new Compiler();
		compiler.release();
	}
}
