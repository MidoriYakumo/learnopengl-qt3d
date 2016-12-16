Colors
======

I decided to introduce the render types in Qt3D which helps us to create 3D scenes after we had learned all these base concepts. The most important one is, the Camera. In the aspect of render, Qt3D has helped on how to render objects in the scene to our screen, or say the transformations, camera projecton, viewport, to generate what we really wanted: the mvp matrix. By setting up with Qt3D Camera and Qt3D Transform, you can use the mvp uniform in your shaders directly:

> gl_Position = mvp * vec4(position, 1.);

These changes are:

1.	use Qt3D Camera instead of “OurCamera” -> use name viewMatrix and projectionMatrix in shaders
2.	setup CameraSelector in RenderSettings and bind the Camera from Qt3D (**MUST HAVE**, or lead to crash)
3.	use Qt3D Transfrom -> use name modelMatrix in shaders
4.	use Qt3D Mesh -> use name vertexPosition, vertexColor, vertexTexCoord ... (and the layout position?) in shaders

See [colors_scene.qml](../qml/colors_scene.qml) for details.
