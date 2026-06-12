#version 120

#include "/lib/common.glsl"

uniform sampler2D texture;

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec4 glcolor;

/* DRAWBUFFERS:0 */

void main() {
    vec4 base = texture2D(texture, texcoord) * glcolor;
    if (base.a < 0.1) discard;
    float handBoost = HAND_LIGHT_FIX ? 0.18 : 0.0;
    vec3 light = vec3(MIN_LIGHT + handBoost) + vec3(0.85) * lmcoord.y + vec3(1.0, 0.48, 0.18) * lmcoord.x * TORCH_WARMTH;
    vec3 color = gradeHorror(base.rgb * light, 1.0 - lmcoord.y);
    gl_FragData[0] = vec4(color, base.a);
}
