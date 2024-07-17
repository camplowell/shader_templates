#version {{cookiecutter.glsl_version}}{% if cookiecutter.glsl_version|int >= 150 %} compatibility{% endif %}

out VertexData {
    vec4 tint;
    vec2 texcoord;
    vec2 lmcoord;
} vOut;

#define projectionMatrix gl_ProjectionMatrix
#include "util/space.glsl"

void main() {
    gl_Position = ftransform();
    vOut.texcoord = model_texcoord();
    vOut.lmcoord = model_lmcoord();
    vOut.tint = gl_Color;
}