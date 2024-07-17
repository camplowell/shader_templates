#version {{cookiecutter.glsl_version}}{% if cookiecutter.glsl_version|int >= 150 %} compatibility{% endif %}

in VertexData {
    vec4 color;
    vec2 lmcoord;
} vIn;

uniform sampler2D lightmap;
#include "/util/space.glsl"

layout(location = 0) out vec4 fragColor;

void main() {
    vec4 color = vIn.color;
    color.rgb *= texture(lightmap, vIn.lmcoord).rgb;

    fragColor = color;
}