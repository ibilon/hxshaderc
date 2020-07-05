# hxshaderc

![Build Status](https://github.com/ibilon/hxshaderc/workflows/Main/badge.svg)

API Documentation: <https://ibilon.github.io/hxshaderc/>

hxshaderc is a haxe/hxcpp wrapper around shaderc, a compiler for GLSL/HLSL to SPIR-V. This is not the C api.

The library is [null safe](https://haxe.org/manual/cr-null-safety.html) and compatible [cppia](https://haxe.org/manual/target-cppia.html), see `cppia_host.hxml` and `sample.hxml` on how to use cppia.

* Shader compilation
* [**Planned**] Include callbacks
* [**Planned**] Windows/MacOS support

## Building

hxshaderc requires building shaderc, see <https://github.com/google/shaderc#tools-youll-need> for the required dependencies.

## Usage

Make sure to clone this repository with `--recursive`, or download the submodule with `git submodule update --init`.

A small example is available in `sample/`:

* Compile the cppia host with `haxe cppia_host.hxml`, this only to be rebuilt if you change/update the hxglfw library
* Compile the sample with `haxe sample.hxml`
* Run it with `./build/cppia_host/CppiaHost-debug build/sample.cppia`.

## License

This library is [Apache-2.0 licensed](https://github.com/ibilon/hxshaderc/blob/LICENSE.md), the statically linked shaderc is [Apache-2.0 licensed](https://github.com/google/shaderc/blob/main/LICENSE).
