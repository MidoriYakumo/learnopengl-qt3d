# Camera

This section is full of things about mathematics. We just need a QML type to handle camera calculations, there it is, the Camera QML type. But we can DIY fully because it is just math, aha?

Qt has covered what glm could provided for us: 

> vector, matrix, quaternion...

See those examples and documents to unleash your power. **(Hey, quaternion in QML sucks!)**

[camera_circle](../qml/camera_circle.qml)
===

[camera_keyboard](../qml/camera_keyboard.qml)
===
Remember FrameSwap? It's true type is FrameAction, the event between frames.
We should always adjust geometries and handle physics here.

![](img/camera_keyboard.0.png)

[camera\_keyboard\_dt](../qml/camera_keyboard_dt.qml)
===
FrameAction support dt internally, we just calculate FPS by this argument.

[camera_zoom](../qml/camera_zoom.qml)
===
Use MouseHandler the way you do to MouseArea, modifiers can be passed into mouse event, try to press Shift for accurate aiming.
Need zoom for touchscreen? You may need an outer PinchArea.

![](img/camera_zoom.0.png)

[camera_quaternion](../qml/camera_quaternion.qml)
===
Oh I can not invoke QQuaternion methods to do calculations now...

[camera-exercise1](../qml/camera-exercise1.qml)
===
You may enjoy the world you can not fly but infinite jump!

[camera-exercise2](../qml/camera-exercise2.qml)
===
