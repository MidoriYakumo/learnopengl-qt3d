import Qt3D.Core 2.0
import Qt3D.Render 2.0

GeometryRenderer {
	id: geometry
	geometry: Geometry {
		boundingVolumePositionAttribute: position
		Attribute {
			id: position
			attributeType: Attribute.VertexAttribute
			vertexBaseType: Attribute.Float
			vertexSize: 3
			count: 3
			name: "position"
			buffer: Buffer {
				type: Buffer.VertexBuffer
				data: Float32Array([
					-0.5, -0.5, 0.0, // Left
					 0.5, -0.5, 0.0, // Right
					 0.0,  0.5, 0.0  // Top
				])
			}
		}
	}
}
