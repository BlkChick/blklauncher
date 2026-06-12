#version 120

#include "/lib/common.glsl"

uniform sampler2D texture;

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec4 glcolor;
varying float distanceFade;
varying float wave;

/* DRAWBUFFERS:0 */

void main() {
    vec4 base = texture2D(texture, texcoord + vec2(wave) * 0.006) * glcolor;
    vec3 deep = vec3(0.015, 0.030, 0.045) * (1.0 + HORROR_INTENSITY);
    vec3 reflected = vec3(0.22, 0.30, 0.42) * MOONLIGHT_STRENGTH * float(REFLECTION_QUALITY) / 3.0;
    vec3 color = mix(base.rgb, deep, WATER_DARKNESS) + reflected * lmcoord.y;
    color = applyFog(color, distanceFade * WATER_FOG, 0.0, deep);
    gl_FragData[0] = vec4(color, base.a * mix(0.55, 0.82, WATER_DARKNESS));
}
