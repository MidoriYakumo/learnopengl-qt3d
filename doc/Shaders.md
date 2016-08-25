# Shaders

In Effect, parameters are the binding between uniform variables and QML properties, in single item list, brackets can be ignored:

```qml
parameters: Parameter {
	name: "uniform"
	value: item.value
}
```

```qml
parameters: [
	Parameter {},
	Parameter {},
	Parameter {}
}
```

[shader-uniform](../qml/shader-uniform.qml)
===

1. Uniform binding:

	![](img/shader-uniform.0.png)

[shader-interpolated](../qml/shader-interpolated.qml)
===

1. Setup size, count, offset, stride for one vertex buffer with several attributes:

	![](img/shader-interpolated.0.png)

[shader-exercise1](../qml/shader-exercise1.qml)
===

[shader-exercise2](../qml/shader-exercise2.qml)
===

[shader-exercise3](../qml/shader-exercise3.qml)
===
