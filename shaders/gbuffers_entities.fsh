#version 120

#include "/lib/common.glsl"

uniform sampler2D texture;
uniform int worldTime;

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec4 glcolor;
varying vec3 worldNormal;
varying float distanceFade;

/* DRAWBUFFERS:0 */

void main() {
    vec4 base = texture2D(texture, texcoord) * glcolor;
    if (base.a < 0.1) discard;

    float block = saturate(lmcoord.x);
    float sky = saturate(lmcoord.y);
    float rim = pow(1.0 - saturate(abs(worldNormal.z)), 2.2) * ENTITY_RIM_LIGHT;
    float flicker = TORCH_FLICKER ? hash12(vec2(float(worldTime) * 0.05, texcoord.y * 23.0)) : 0.5;
    vec3 light = vec3(MIN_LIGHT) + vec3(0.30, 0.36, 0.48) * sky * MOONLIGHT_STRENGTH + torchColor(flicker) * block * block;
    vec3 color = base.rgb * light + vec3(0.24, 0.32, 0.46) * rim * HORROR_INTENSITY;
    color = gradeHorror(color, 1.0 - sky);
    color = applyFog(color, distanceFade, 0.0, vec3(0.025, 0.033, 0.047));
    gl_FragData[0] = vec4(color, base.a);
}
