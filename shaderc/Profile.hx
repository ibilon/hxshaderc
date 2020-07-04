package shaderc;

/**
	GLSL profile.
**/
enum abstract Profile(Int) {
	/** If no profile was specified. **/
	var None = 0;

	/** Core profile: this does not contain deprecated functionality. **/
	var Core = 1;

	/** Compatibility profile: this contains deprecated functionality, but is not guaranteed to be available. **/
	var Compatibility = 2;

	/** OpenGL ES (OpenGL for Embedded Systems). **/
	var Es = 3;
}
