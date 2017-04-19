pragma Singleton

import QtQuick 2.7

ListModel {
	ListElement { text: "Hello Window"					; source: "hellowindow"}
//	ListElement { text: "Hello Window 2"				; source: "hellowindow2"}
	ListElement { text: "Hello Triangle"				; source: "hellotriangle"}
	ListElement { text: "Hello Triangle 2 Wireframe"	; source: "hellotriangle2"}
//	ListElement { text: "Hello Triangle X1"				; source: "hello-triangle-exercise1"}
//	ListElement { text: "Hello Triangle X2"				; source: "hello-triangle-exercise2"}
//	ListElement { text: "Hello Triangle X3"				; source: "hello-triangle-exercise3"}
	ListElement { text: "Shaders Uniform"				; source: "shaders-uniform"}
	ListElement { text: "Shaders Interpolated"			; source: "shaders-interpolated"}
//	ListElement { text: "Shaders X1"					; source: "shaders-exercise1"}
//	ListElement { text: "Shaders X2"					; source: "shaders-exercise2"}
//	ListElement { text: "Shaders X3"					; source: "shaders-exercise3"}
//	ListElement { text: "Textures"						; source: "textures"}
	ListElement { text: "Textures 2"					; source: "textures2"}
	ListElement { text: "Textures Combined"				; source: "textures_combined"}
//	ListElement { text: "Textures X1"					; source: "textures-exercise1"}
//	ListElement { text: "Textures X2"					; source: "textures-exercise2"}
//	ListElement { text: "Textures X3"					; source: "textures-exercise3"}
//	ListElement { text: "Textures X4"					; source: "textures-exercise4"}
	ListElement { text: "Transformations"				; source: "transformations"}
//	ListElement { text: "Transformations X1"			; source: "transformations-exercise1"}
//	ListElement { text: "Transformations X2"			; source: "transformations-exercise2"}
	ListElement { text: "Coordinate Systems"			; source: "coordinate_systems"}
	ListElement { text: "Coordinate With Depth"			; source: "coordinate_systems_with_depth"}
	ListElement { text: "Coordinate Systems MultiObj"	; source: "coordinate_systems_multiple_objects"}
//	ListElement { text: "Coordinate Systems X1"			; source: "coordinate_systems-exercise1"}
//	ListElement { text: "Coordinate Systems X2"			; source: "coordinate_systems-exercise2"}
//	ListElement { text: "Coordinate Systems X3"			; source: "coordinate_systems-exercise3"}
	ListElement { text: "Camera The Orbit"				; source: "camera_circle"}
//	ListElement { text: "Camera The Keyboard"			; source: "camera_keyboard"}
	ListElement { text: "Camera The Keyboard With dt"	; source: "camera_keyboard_dt"}
	ListElement { text: "Camera FPS-Style"				; source: "camera_zoom"}
//	ListElement { text: "Camera X1"						; source: "camera-exercise1"}
//	ListElement { text: "Camera X2"						; source: "camera-exercise2"}
	ListElement { text: "Colors"						; source: "colors_scene"}
	ListElement { text: "Basic Lighting Phong-Diffuse"	; source: "basic_lighting_diffuse"}
	ListElement { text: "Basic Lighting Phong/Gouraud"	; source: "basic_lighting_specular"}
//	ListElement { text: "Basic Lighting X1"				; source: "basic_lighting-exercise1"}
//	ListElement { text: "Basic Lighting X2"				; source: "basic_lighting-exercise2"}
//	ListElement { text: "Basic Lighting X3"				; source: "basic_lighting-exercise3"}
	ListElement { text: "Materials"						; source: "materials"}
//	ListElement { text: "Diffuse Map"					; source: "lighting_maps_diffuse"}
	ListElement { text: "Diffuse Specular Map"			; source: "lighting_maps_specular"}
//	ListElement { text: "Lighting maps X1"				; source: "lighting_maps-exercise1"}
//	ListElement { text: "Lighting maps X2"				; source: "lighting_maps-exercise2"}
//	ListElement { text: "Lighting maps X3"				; source: "lighting_maps-exercise3"}
//	ListElement { text: "Lighting maps X4"				; source: "lighting_maps-exercise4"}
	ListElement { text: "Directional Light"				; source: "light_casters_directional"}
//	ListElement { text: "Point Light"					; source: "light_casters_point"}
	ListElement { text: "Spot Light"					; source: "light_casters_spotlight_soft"}
	ListElement { text: "Multiple Lights"				; source: "multiple_lights"}
	ListElement { text: "Import Models"					; source: "model"}
	ListElement { text: "Depth Testing"					; source: "depth_testing"}
	ListElement { text: "Stencil Testing"				; source: "stencil_testing"}
	ListElement { text: "Discard Blend"					; source: "blending_discard"}
	ListElement { text: "Alpha Blend"					; source: "blending_alpha"}
	ListElement { text: "Framebuffer"					; source: "framebuffer"}
	ListElement { text: "Skybox"						; source: "cubemaps_skybox"}
	ListElement { text: "Simple Glass"					; source: "cubemaps_glasscube"}
	ListElement { text: "Glass Texture"					; source: "cubemaps_final"}
	ListElement { text: "Geometry Shader"				; source: "geometry_shader"}
	ListElement { text: "Instancing"					; source: "instancing"}
	ListElement { text: "Lighting Blinn-Phong"			; source: "light_blinnphong"}

	ListElement { text: "TEST/BASE"						; source: "test_base"}
	ListElement { text: "TEST/GLSL"						; source: "test_glsl"}
	ListElement { text: "TEST/BIGMODEL"					; source: "test_bigmodel"}
	ListElement { text: "TEST/INSTANCED"				; source: "test_instanced"}
	ListElement { text: "TEST/PLASMA"					; source: "test_plasma"}
	ListElement { text: "Exit"; }
	
	Component.onCompleted: console.log("In total %1 samples.".arg(count-1))
}

