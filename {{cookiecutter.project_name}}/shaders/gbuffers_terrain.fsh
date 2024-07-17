#version {{cookiecutter.glsl_version}}{% if cookiecutter.glsl_version|int >= 150 %} compatibility{% endif %}

in VertexData {
    vec4 tint;
    vec2 texcoord;
    vec2 lmcoord;
} vIn;

uniform sampler2D texture;
uniform sampler2D lightmap;

#include "/util/space.glsl"

layout(location = 0) out vec4 fragColor;

void main() {
    vec4 color = texture(texture, vIn.texcoord) * vIn.tint;
    if (color.a < 0.5) {
        discard;
    }
    color.rgb *= texture(lightmap, vIn.lmcoord).rgb;
    fragColor = color;
}