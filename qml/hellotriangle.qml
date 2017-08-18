import QtQuick 2.9

import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "Components"

Scene0 {
	Entity {
		id: root

		RenderSettings0 {}

		Entity {
			// The object to render: on a 2D surface
			id: plane

			GeometryRenderer {
				/*
					Construct vertices, setup primitive settings -> Vertex Shaders
				*/

				id: geometry
				geometry: Geometry {
					/*
						Provide vertices
						Children are Attribute, the vertex shader attribute bindings
						Refer: qthelp://org.qt-project.qt3d.570/qt3d/qt3drender-qgeometry.html
							attributes is list property, either
								attributes: Attribute {
								}
							or
								Attribute {
								}
							works.

					*/

					Attribute {
						/*
							The attribute
							Refer: qthelp://org.qt-project.qt3d.570/qt3d/qt3drender-qattribute.html
						*/

						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 3
						name: "position" // Auto picked up as boundingPositionAttribute
						buffer: Buffer {
							/*
								The vertex buffer
								Refer: qthelp://org.qt-project.qt3d.570/qt3d/qt3drender-qbuffer.html
							*/

							type: Buffer.VertexBuffer
							data: new Float32Array([
								-0.5, -0.5, 0.0, // Left
								 0.5, -0.5, 0.0, // Right
								 0.0,  0.5, 0.0, // Top
							]) // Need a C++ array, Javascript Float32Array helps
						}
					}
				}
			}

			Material {
				/*
					Setup shades, ie materials of objects
				*/

				id: material
				effect: Effect {
					/*
						Link shader and uniforms
						Neither techniques or parameters can be directly attached
					*/

					techniques: Technique {
						/*
							Technique = GL API, shader, renderpass filter/router
						*/

						graphicsApiFilter {
							profile: GraphicsInfo.profile === GraphicsInfo.CoreProfile ?
								GraphicsApiFilter.CoreProfile : GraphicsApiFilter.NoProfile;
						}

						renderPasses: RenderPass {
							/*
								How to render in each pass, setup uniforms and create GL context states
								Refer: qthelp://org.qt-project.qt3d.570/qt3d/qt3drender-qrenderpass.html#renderStates
							*/

							shaderProgram: ShaderProgram {
								/*
									Here stores our shaders
									Using loadSource() to load shaders from local(will remote be possible?)
									Notice that URI should be completed
								*/

								vertexShaderCode: loadSource(Resources.shader("hellotriangle.vert"))
								fragmentShaderCode: loadSource(Resources.shader("hellotriangle.frag"))
							}
						}
					}
				}
			}

			components: [geometry, material] // The object combines with geometry and material
		}
	}
}
