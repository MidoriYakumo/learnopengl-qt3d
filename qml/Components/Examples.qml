import QtQuick 2.7

ListModel {
	ListElement { text: "Hello Window"					; source: "hellowindow"}
	ListElement { text: "Hello Triangle"				; source: "hellotriangle"}
	ListElement { text: "Hello Triangle 2 Wireframe"	; source: "hellotriangle2"}
	ListElement { text: "Shaders Uniform"				; source: "shadersuniform"}
	ListElement { text: "Shaders Interpolated"			; source: "shadersinterpolated"}
	ListElement { text: "Texture"						; source: "texture"}
	ListElement { text: "Textures Combined"				; source: "textures_combined"}
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
	ListElement { text: "Stencil Testing"					; source: "stencil_testing"}
	ListElement { text: "Discard Blend"					; source: "blending_discard"}
	ListElement { text: "Alpha Blend"					; source: "blending_alpha"}
	ListElement { text: "Framebuffer"					; source: "framebuffer"}
	ListElement { text: "Skybox"					; source: "cubemaps_skybox"}
	ListElement { text: "Simple Glass"					; source: "cubemaps_glasscube"}
	ListElement { text: "Glass Texture"					; source: "cubemaps_final"}
	ListElement { text: "Geometry Shader"					; source: "geometry_shader"}
	ListElement { text: "Instancing"					; source: "instancing"}
	ListElement { text: "Lighting Blinn-Phong"					; source: "light_blinnphong"}

	ListElement { text: "TEST/BASE"					; source: "test_base"}
	ListElement { text: "TEST/GLSL"					; source: "test_glsl"}
	ListElement { text: "TEST/BIGMODEL"			; source: "test_bigmodel"}
	ListElement { text: "TEST/INSTANCED"			; source: "test_instanced"}
	ListElement { text: "TEST/PLASMA"			; source: "test_plasma"}
	ListElement { text: "Exit"; }
}

