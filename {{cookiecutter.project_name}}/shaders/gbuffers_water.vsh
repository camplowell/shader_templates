#version {{cookiecutter.glsl_version}}{% if cookiecutter.glsl_version|int >= 150 %} compatibility{% endif %}

out VertexData {
    vec4 tint;
    vec2 texcoord;
    vec2 lmcoord;
    {% if cookiecutter.dh_support %}
    vec3 viewPos;
    {% endif %}
} vOut;
{% if cookiecutter.dh_support %}
uniform float far;
uniform float dhNearPlane;
{% endif %}
#define projectionMatrix gl_ProjectionMatrix
#include "util/space.glsl"
{% if cookiecutter.dh_support %}#include "util/dh_clip.glsl"
{% endif %}
void main() {
    {% if cookiecutter.dh_support %}vOut.viewPos = model2view();
    
    gl_Position = view2clip(vOut.viewPos);
    {% else %}gl_Position = ftransform();
    {% endif %}vOut.texcoord = model_texcoord();
    vOut.lmcoord = model_lmcoord();
    vOut.tint = gl_Color;
}