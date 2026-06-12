#ifndef OBSIDIAN_COMMON_GLSL
#define OBSIDIAN_COMMON_GLSL

#include "/lib/settings.glsl"

float saturate(float v) { return clamp(v, 0.0, 1.0); }
vec2 saturate(vec2 v) { return clamp(v, 0.0, 1.0); }
vec3 saturate(vec3 v) { return clamp(v, 0.0, 1.0); }

float hash12(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

float luma(vec3 c) { return dot(c, vec3(0.2126, 0.7152, 0.0722)); }

vec3 gradeHorror(vec3 color, float nightFactor) {
    float lum = luma(color);
    vec3 cold = vec3(lum) + (color - vec3(lum)) * (1.0 - NIGHT_DESATURATION * nightFactor);
    cold *= vec3(0.82, 0.92, 1.08);
    vec3 bruised = vec3(cold.r * 0.88 + cold.b * 0.05, cold.g * 0.92, cold.b * 1.12);
    return mix(color, bruised, COLOR_GRADING_STRENGTH * HORROR_INTENSITY);
}

vec3 applyFog(vec3 color, float depth, float skyFactor, vec3 fogColor) {
    float density = FOG_DENSITY * (VOLUMETRIC_FOG ? 1.0 : 0.35);
    float heightFog = mix(1.0, 1.55, FOG_HEIGHT);
    float fogAmount = 1.0 - exp(-depth * density * 0.018 * heightFog);
    fogAmount = saturate(fogAmount + skyFactor * 0.10 * HORROR_INTENSITY);
    return mix(color, fogColor, fogAmount);
}

vec3 tonemap(vec3 c) {
    c *= TONEMAP_EXPOSURE;
    if (TONE_PROFILE == 0) {
        c = c / (1.0 + c);
    } else if (TONE_PROFILE == 1) {
        c = max(vec3(0.0), c - 0.004);
        c = (c * (6.2 * c + 0.5)) / (c * (6.2 * c + 1.7) + 0.06);
    } else {
        c = (c * (2.51 * c + 0.03)) / (c * (2.43 * c + 0.59) + 0.14);
    }
    return saturate(c);
}

vec3 torchColor(float flicker) {
    vec3 flame = vec3(1.0, 0.46, 0.16) * TORCH_WARMTH;
    return flame * mix(0.92, 1.12, flicker);
}

float fakeDetail(vec2 uv, float scale) {
    float a = hash12(floor(uv * scale));
    float b = hash12(floor(uv * scale * 2.0 + 17.0));
    return (a * 0.65 + b * 0.35) * 2.0 - 1.0;
}

#endif
