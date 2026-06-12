#version 120

#include "/lib/common.glsl"

uniform sampler2D texture;
uniform int worldTime;
uniform float rainStrength;
uniform float nightVision;

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec4 glcolor;
varying vec3 worldNormal;
varying float distanceFade;

/* DRAWBUFFERS:0 */

void main() {
    vec4 albedo = texture2D(texture, texcoord) * glcolor;
    if (albedo.a < 0.1) discard;

    float sun = saturate(lmcoord.y);
    float block = saturate(lmcoord.x);
    float night = saturate(1.0 - sun);
    float flicker = TORCH_FLICKER ? hash12(vec2(float(worldTime) * 0.037, texcoord.x * 41.0)) : 0.5;

    float ndl = saturate(dot(normalize(worldNormal), normalize(vec3(-0.25, 0.85, 0.34))) * 0.5 + 0.5);
    float shadowedSun = mix(0.14, 1.0, ndl) * sun * SHADOW_QUALITY;
    vec3 moon = vec3(0.28, 0.36, 0.52) * MOONLIGHT_STRENGTH * night;
    vec3 torch = torchColor(flicker) * block * block;
    vec3 ambient = vec3(MIN_LIGHT) + moon * 0.45 + vec3(0.04, 0.05, 0.065) * HORROR_INTENSITY;

    float detail = DETAIL_NORMALS ? fakeDetail(texcoord + albedo.rb, 96.0) * DETAIL_STRENGTH : 0.0;
    vec3 color = albedo.rgb * (ambient + shadowedSun * vec3(0.95, 0.90, 0.82) + torch);
    color *= 1.0 + detail * 0.075;
    color *= mix(1.0, 1.0 - WETNESS_DARKENING * 0.55, rainStrength);
    color = mix(color, vec3(luma(color)) * vec3(0.70, 0.82, 1.0), HORROR_INTENSITY * night * 0.20);
    color = gradeHorror(color, night);
    color = applyFog(color, distanceFade, 0.0, vec3(0.025, 0.033, 0.047));
    color = mix(color, albedo.rgb, nightVision * 0.65);

    gl_FragData[0] = vec4(color, albedo.a);
}
