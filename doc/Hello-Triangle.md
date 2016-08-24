# Hello Triangle

Any Qt3D renderable Entity is assembled with three parts:

> vertices, transforms, shaders

in qml code:

```qml
Entity {

	GeometryRenderer {
		id: geometry
	}

	Transform {
		id: transform
	}

	Material {
		id: material
	}

	components: [geometry, transform, material]
}
```

There is no z-order or render order for unassembled entities, thus any following style works:

```qml
GeometryRenderer {
	id: geometry
}

Transform {
	id: transform
}

Material {
	id: material
}

Entity {
	components: [geometry, transform, material]
}
```

```qml

Transform {
	id: transform
}

Material {
	id: material
}

Entity {

	GeometryRenderer {
		id: geometry
	}

	components: [geometry, transform, material]
}
```

Flow
---
```
GeometryRenderer <- Geometry <- Attribute <- Buffer <- vertices
      |                             |          |           |
      V                             ------------------------
Transform  ------------------------------------>    |
      |                                             |
      V                                             V
Material -> Effect -> Technique -> RenderPass -> ShaderProgram
```

hellotriangle
===

1. Use ShaderProgram to link shader program flow:

	![](img/hellotriangle.0.png)

2. Use Attribute to bind VBO

	![](img/hellotriangle.1.png)

3. Entity.components assmbles vertices and shader programs, RenderPass set the render flow (using default settings)

	![](img/hellotriangle.2.png)

hellotriangle2
===

1. Corresponding...:

	![](img/hellotriangle2.0.png)

hello-triangle-exercise1
===

hello-triangle-exercise2
===
You can generate 2 different geometry, bind two entities with them and the same material

hello-triangle-exercise3
===
loadSource returns QByteArray, you need toString() and then manipulate the string in javascript
