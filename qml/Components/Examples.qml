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

	ListElement { text: "TEST"	; source: "test"}
	ListElement { text: "Exit"; }
}

