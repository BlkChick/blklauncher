#version 120

#include "/lib/common.glsl"

uniform int worldTime;
uniform float rainStrength;

varying vec4 glcolor;
varying vec3 viewDir;

/* DRAWBUFFERS:0 */

void main() {
    float dayCycle = abs(float(worldTime) - 6000.0) / 12000.0;
    float night = saturate(dayCycle);
    float horizon = pow(1.0 - saturate(abs(viewDir.y)), 2.0);
    vec3 day = vec3(0.42, 0.58, 0.78) * (1.0 - HORROR_INTENSITY * 0.35);
    vec3 midnight = vec3(0.006, 0.012, 0.024) + vec3(0.02, 0.03, 0.055) * MOONLIGHT_STRENGTH;
    vec3 color = mix(day, midnight, night) * glcolor.rgb;
    color = mix(color, vec3(0.018, 0.025, 0.035), horizon * FOG_DENSITY);
    color = mix(color, vec3(0.020, 0.024, 0.032), rainStrength * 0.75);
    color = gradeHorror(color, night);
    gl_FragData[0] = vec4(color, glcolor.a);
}
