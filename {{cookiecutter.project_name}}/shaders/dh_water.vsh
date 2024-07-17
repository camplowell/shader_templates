#version {{cookiecutter.glsl_version}}{% if cookiecutter.glsl_version|int >= 150 %} compatibility{% endif %}

out VertexData {
    vec4 color;
    vec2 lmcoord;
    vec3 viewPos;
} vOut;

uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 dhProjection;
uniform vec3 cameraPosition;

#define projectionMatrix gl_ProjectionMatrix
#include "util/space.glsl"

void main() {
    vOut.viewPos = model2view();

    gl_Position = view2clip(vOut.viewPos);
    vOut.color = gl_Color;
    vOut.lmcoord = model_lmcoord();
}