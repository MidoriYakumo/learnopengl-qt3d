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

shader-uniform
===

1. Uniform binding:

	![](img/shader-uniform.0.png)

shader-interpolated
===

1. Setup size, count, offset, stride for one vertex buffer with several attributes:

	![](img/shader-interpolated.0.png)

shader-exercise1
===

shader-exercise2
===

shader-exercise3
===
