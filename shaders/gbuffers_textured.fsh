#version 120

#include "/lib/common.glsl"

uniform sampler2D texture;

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec4 glcolor;
varying float distanceFade;

/* DRAWBUFFERS:0 */

void main() {
    vec4 base = texture2D(texture, texcoord) * glcolor;
    if (base.a < 0.1) discard;
    float sky = saturate(lmcoord.y);
    vec3 color = base.rgb * (vec3(MIN_LIGHT) + vec3(0.85) * sky + vec3(1.0, 0.48, 0.18) * lmcoord.x * TORCH_WARMTH);
    color = gradeHorror(color, 1.0 - sky);
    color = applyFog(color, distanceFade, 0.0, vec3(0.025, 0.033, 0.047));
    gl_FragData[0] = vec4(color, base.a);
}
