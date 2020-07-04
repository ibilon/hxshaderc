package shaderc.options;

/**
	Source language.
**/
enum abstract SourceLanguage(Int) {
	/** GLSL. **/
	var Glsl = 0;

	/** HLSL. **/
	var Hlsl = 1;
}
