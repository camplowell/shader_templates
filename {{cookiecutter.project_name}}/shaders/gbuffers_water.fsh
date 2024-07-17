#version {{cookiecutter.glsl_version}}{% if cookiecutter.glsl_version|int >= 150 %} compatibility{% endif %}

in VertexData {
    vec4 tint;
    vec2 texcoord;
    vec2 lmcoord;
    {% if cookiecutter.dh_support %}
    vec3 viewPos;
    {% endif %}
} vIn;

uniform sampler2D texture;
uniform sampler2D lightmap;
{% if cookiecutter.dh_support %}
uniform sampler2D depthtex1;

uniform float far;
uniform float dhNearPlane;
#include "/util/space.glsl"
#include "/util/dh_clip.glsl"
{% endif %}
layout(location = 0) out vec4 fragColor;

void main() {
    {% if cookiecutter.dh_support %}if (
        texelFetch(depthtex1, ivec2(gl_FragCoord.xy), 0).x == 1.0
        && DH_BLEND_START < -vIn.viewPos.z
    ) {
        discard;
    }{% endif %}
    vec4 color = texture(texture, vIn.texcoord) * vIn.tint;
    color.rgb *= texture(lightmap, vIn.lmcoord).rgb;
    fragColor = color;
}