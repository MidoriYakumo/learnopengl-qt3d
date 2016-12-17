Basic Lighting
==============

[basic_lighting_diffuse](../qml/basic_lighting_diffuse.qml)
-----------------------------------------------------------

Type NonUniformScaledCuboidMesh0 displays how normal fixing affect the shading result,
by calculation in Javascript.

> Tips:
>
> -	Qt3D uniform modelNormalMatrix = mat3(transpose(inverse(modelMatrix))) * normalMatrix
> -	Qt3D uniform modelViewNormal = mat3(transpose(inverse(view * model)))
> - Internal uniforms can be found at: Src/qt3d/src/render/backend/renderview.cpp:137

```c++
	RenderView::StandardUniformsPFuncsHash RenderView::initializeStandardUniformSetters()
{
    RenderView::StandardUniformsPFuncsHash setters;

    setters.insert(StringToInt::lookupId(QLatin1String("modelMatrix")), &RenderView::modelMatrix);
    setters.insert(StringToInt::lookupId(QLatin1String("viewMatrix")), &RenderView::viewMatrix);
    setters.insert(StringToInt::lookupId(QLatin1String("projectionMatrix")), &RenderView::projectionMatrix);
    setters.insert(StringToInt::lookupId(QLatin1String("modelView")), &RenderView::modelViewMatrix);
    setters.insert(StringToInt::lookupId(QLatin1String("modelViewProjection")), &RenderView::modelViewProjectionMatrix);
    setters.insert(StringToInt::lookupId(QLatin1String("mvp")), &RenderView::modelViewProjectionMatrix);
    setters.insert(StringToInt::lookupId(QLatin1String("inverseModelMatrix")), &RenderView::inverseModelMatrix);
    setters.insert(StringToInt::lookupId(QLatin1String("inverseViewMatrix")), &RenderView::inverseViewMatrix);
    setters.insert(StringToInt::lookupId(QLatin1String("inverseProjectionMatrix")), &RenderView::inverseProjectionMatrix);
    setters.insert(StringToInt::lookupId(QLatin1String("inverseModelView")), &RenderView::inverseModelViewMatrix);
    setters.insert(StringToInt::lookupId(QLatin1String("inverseModelViewProjection")), &RenderView::inverseModelViewProjectionMatrix);
    setters.insert(StringToInt::lookupId(QLatin1String("modelNormalMatrix")), &RenderView::modelNormalMatrix);
    setters.insert(StringToInt::lookupId(QLatin1String("modelViewNormal")), &RenderView::modelViewNormalMatrix);
    setters.insert(StringToInt::lookupId(QLatin1String("viewportMatrix")), &RenderView::viewportMatrix);
    setters.insert(StringToInt::lookupId(QLatin1String("inverseViewportMatrix")), &RenderView::inverseViewportMatrix);
    setters.insert(StringToInt::lookupId(QLatin1String("time")), &RenderView::time);
    setters.insert(StringToInt::lookupId(QLatin1String("eyePosition")), &RenderView::eyePosition);

    return setters;
}
```

[basic_lighting_specular](../qml/basic_lighting_specular.qml)
-------------------------------------------------------------

[basic_lighting-exercise1](../qml/basic_lighting-exercise1.qml)
---------------------------------------------------------------

[basic_lighting-exercise2](../qml/basic_lighting-exercise2.qml)
---------------------------------------------------------------

[basic_lighting-exercise3](../qml/basic_lighting-exercise3.qml)
---------------------------------------------------------------
