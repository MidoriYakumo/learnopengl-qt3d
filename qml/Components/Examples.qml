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
	ListElement { text: "Coordinate Systems"			; source: "coordinate_systems"}
	ListElement { text: "Coordinate Systems MultiObj"	; source: "coordinate_systems_multiple_objects"}
	ListElement { text: "Camera/Orbit"					; source: "camera_circle"}
	ListElement { text: "Camera/WASD"					; source: "camera_keyboard"}
	ListElement { text: "Camera/FPS"					; source: "camera_zoom"}
	ListElement { text: "Color"							; source: "colors_scene"}
	ListElement { text: "Basic Lighting Phong-Diffuse"	; source: "basic_lighting_diffuse"}
	ListElement { text: "Basic Lighting Phong/Gouraud"	; source: "basic_lighting_specular"}
	ListElement { text: "Material"						; source: "materials"}
	ListElement { text: "Diffuse Specular Map"			; source: "lighting_maps_specular"}
	ListElement { text: "Diffuse Specular Emission Map"	; source: "lighting_maps_emission"}
	ListElement { text: "Directional Light"				; source: "light_casters_directional"}
	ListElement { text: "Spot Light(hard)"				; source: "light_casters_spotlight_hard"}
	ListElement { text: "Multiple Lights"				; source: "multiple_lightsx"}
	ListElement { text: "Import Models"					; source: "model"}
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

