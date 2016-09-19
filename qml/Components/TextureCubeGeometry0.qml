import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "."

GeometryRenderer {
	id: geometry
	geometry: Geometry {
		boundingVolumePositionAttribute: position

		Attribute {
			id: position
			attributeType: Attribute.VertexAttribute
			vertexBaseType: Attribute.Float
			vertexSize: 3
			count: 36
			byteOffset: 0
			byteStride: 4 * 5
			name: "position"
			buffer: vertexBuffer
		}

		Attribute {
			attributeType: Attribute.VertexAttribute
			vertexBaseType: Attribute.Float
			vertexSize: 2
			count: 36
			byteOffset: 4 * 3
			byteStride: 4 * 5
			name: "texCoord"
			buffer: vertexBuffer
		}
	}

	Buffer {
		id: vertexBuffer
		type: Buffer.VertexBuffer
		data: Float32Array([
		  -0.5, -0.5, -0.5,  0.0, 0.0,
		   0.5, -0.5, -0.5,  1.0, 0.0,
		   0.5,  0.5, -0.5,  1.0, 1.0,
		   0.5,  0.5, -0.5,  1.0, 1.0,
		  -0.5,  0.5, -0.5,  0.0, 1.0,
		  -0.5, -0.5, -0.5,  0.0, 0.0,

		  -0.5, -0.5,  0.5,  0.0, 0.0,
		   0.5, -0.5,  0.5,  1.0, 0.0,
		   0.5,  0.5,  0.5,  1.0, 1.0,
		   0.5,  0.5,  0.5,  1.0, 1.0,
		  -0.5,  0.5,  0.5,  0.0, 1.0,
		  -0.5, -0.5,  0.5,  0.0, 0.0,

		  -0.5,  0.5,  0.5,  1.0, 0.0,
		  -0.5,  0.5, -0.5,  1.0, 1.0,
		  -0.5, -0.5, -0.5,  0.0, 1.0,
		  -0.5, -0.5, -0.5,  0.0, 1.0,
		  -0.5, -0.5,  0.5,  0.0, 0.0,
		  -0.5,  0.5,  0.5,  1.0, 0.0,

		   0.5,  0.5,  0.5,  1.0, 0.0,
		   0.5,  0.5, -0.5,  1.0, 1.0,
		   0.5, -0.5, -0.5,  0.0, 1.0,
		   0.5, -0.5, -0.5,  0.0, 1.0,
		   0.5, -0.5,  0.5,  0.0, 0.0,
		   0.5,  0.5,  0.5,  1.0, 0.0,

		  -0.5, -0.5, -0.5,  0.0, 1.0,
		   0.5, -0.5, -0.5,  1.0, 1.0,
		   0.5, -0.5,  0.5,  1.0, 0.0,
		   0.5, -0.5,  0.5,  1.0, 0.0,
		  -0.5, -0.5,  0.5,  0.0, 0.0,
		  -0.5, -0.5, -0.5,  0.0, 1.0,

		  -0.5,  0.5, -0.5,  0.0, 1.0,
		   0.5,  0.5, -0.5,  1.0, 1.0,
		   0.5,  0.5,  0.5,  1.0, 0.0,
		   0.5,  0.5,  0.5,  1.0, 0.0,
		  -0.5,  0.5,  0.5,  0.0, 0.0,
		  -0.5,  0.5, -0.5,  0.0, 1.0
		])
	}
}
