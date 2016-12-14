import Qt3D.Core 2.0
import Qt3D.Render 2.0

GeometryRenderer {
	id: mesh

	property matrix4x4 matrix: Qt.matrix4x4()
	property bool fixNormal: true

	geometry: Geometry {
		boundingVolumePositionAttribute: vertexPosition

		Attribute {
			id: vertexPosition
			attributeType: Attribute.VertexAttribute
			vertexBaseType: Attribute.Float
			vertexSize: 3
			count: 36
			byteOffset: 0
			byteStride: 4 * 6
			name: defaultPositionAttributeName()
			buffer: vertexBuffer
		}

		Attribute {
			id: vertexNormal
			attributeType: Attribute.VertexAttribute
			vertexBaseType: Attribute.Float
			vertexSize: 3
			count: 36
			byteOffset: 4 * 3
			byteStride: 4 * 6
			name: defaultNormalAttributeName()
			buffer: vertexBuffer
		}
	}

	Buffer {
		id: vertexBuffer
		type: Buffer.VertexBuffer
		data: {
			var buffer = new Float32Array([
				-0.5, -0.5, -0.5,  0.0,  0.0, -1.0,
				-0.5,  0.5, -0.5,  0.0,  0.0, -1.0,
				 0.5,  0.5, -0.5,  0.0,  0.0, -1.0,
				 0.5,  0.5, -0.5,  0.0,  0.0, -1.0,
				 0.5, -0.5, -0.5,  0.0,  0.0, -1.0,
				-0.5, -0.5, -0.5,  0.0,  0.0, -1.0,

				-0.5, -0.5,  0.5,  0.0,  0.0,  1.0,
				 0.5, -0.5,  0.5,  0.0,  0.0,  1.0,
				 0.5,  0.5,  0.5,  0.0,  0.0,  1.0,
				 0.5,  0.5,  0.5,  0.0,  0.0,  1.0,
				-0.5,  0.5,  0.5,  0.0,  0.0,  1.0,
				-0.5, -0.5,  0.5,  0.0,  0.0,  1.0,

				-0.5,  0.5,  0.5, -1.0,  0.0,  0.0,
				-0.5,  0.5, -0.5, -1.0,  0.0,  0.0,
				-0.5, -0.5, -0.5, -1.0,  0.0,  0.0,
				-0.5, -0.5, -0.5, -1.0,  0.0,  0.0,
				-0.5, -0.5,  0.5, -1.0,  0.0,  0.0,
				-0.5,  0.5,  0.5, -1.0,  0.0,  0.0,

				 0.5,  0.5,  0.5,  1.0,  0.0,  0.0,
				 0.5, -0.5,  0.5,  1.0,  0.0,  0.0,
				 0.5, -0.5, -0.5,  1.0,  0.0,  0.0,
				 0.5, -0.5, -0.5,  1.0,  0.0,  0.0,
				 0.5,  0.5, -0.5,  1.0,  0.0,  0.0,
				 0.5,  0.5,  0.5,  1.0,  0.0,  0.0,

				-0.5, -0.5, -0.5,  0.0, -1.0,  0.0,
				 0.5, -0.5, -0.5,  0.0, -1.0,  0.0,
				 0.5, -0.5,  0.5,  0.0, -1.0,  0.0,
				 0.5, -0.5,  0.5,  0.0, -1.0,  0.0,
				-0.5, -0.5,  0.5,  0.0, -1.0,  0.0,
				-0.5, -0.5, -0.5,  0.0, -1.0,  0.0,

				-0.5,  0.5, -0.5,  0.0,  1.0,  0.0,
				-0.5,  0.5,  0.5,  0.0,  1.0,  0.0,
				 0.5,  0.5,  0.5,  0.0,  1.0,  0.0,
				 0.5,  0.5,  0.5,  0.0,  1.0,  0.0,
				 0.5,  0.5, -0.5,  0.0,  1.0,  0.0,
				-0.5,  0.5, -0.5,  0.0,  1.0,  0.0
			]);

			var i, idx, iStart, p;

			for (i=0;i<36;i++) {
				idx = i*6;

				p = Qt.vector3d(buffer[idx+0], buffer[idx+1], buffer[idx+2]);
				p = mesh.matrix.times(p);
				buffer[idx+0] = p.x;
				buffer[idx+1] = p.y;
				buffer[idx+2] = p.z;
			}

			if (!mesh.fixNormal) {
				for (i=0;i<36;i++) {
					idx = i*6;

					p = Qt.vector3d(buffer[idx+3], buffer[idx+4], buffer[idx+5]);
					p = mesh.matrix.times(p);
					buffer[idx+3] = p.x;
					buffer[idx+4] = p.y;
					buffer[idx+5] = p.z;
				}
			} else {
				for (i=0;i<36;i++) {
					idx = i*6;

					p = Qt.vector3d(buffer[idx+3], buffer[idx+4], buffer[idx+5]);
					p = mesh.matrix.inverted().transposed().times(p);
					buffer[idx+3] = p.x;
					buffer[idx+4] = p.y;
					buffer[idx+5] = p.z;
				}
			}

			return buffer;
		}
	}
}
