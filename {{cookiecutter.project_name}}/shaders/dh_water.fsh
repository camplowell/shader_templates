#version {{cookiecutter.glsl_version}}{% if cookiecutter.glsl_version|int >= 150 %} compatibility{% endif %}

in VertexData {
    vec4 color;
    vec2 lmcoord;
    vec3 viewPos;
} vIn;

uniform sampler2D lightmap;
uniform sampler2D depthtex1;

uniform float far;
uniform float dhNearPlane;

#include "/util/space.glsl"
#include "/util/dh_clip.glsl"

layout(location = 0) out vec4 fragColor;

void main() {
    if (
        texelFetch(depthtex1, ivec2(gl_FragCoord.xy), 0).x != 1.0
        || DH_BLEND_START > -vIn.viewPos.z
    ) {
        discard;
    }
    vec4 color = vIn.color;
    color.rgb *= texture(lightmap, vIn.lmcoord).rgb;
    fragColor = color;
}