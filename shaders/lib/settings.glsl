#ifndef OBSIDIAN_SETTINGS_GLSL
#define OBSIDIAN_SETTINGS_GLSL

//==================== Profile controlled options ====================
const int shadowMapResolution = 2048; // [512 1024 2048 3072 4096 8192]
const int SHADOW_MAP_SIZE = shadowMapResolution;
const float SHADOW_QUALITY = 0.75; // [0.35 0.55 0.75 0.90 1.00]
const float SHADOW_SOFTNESS = 1.60; // [0.50 1.00 1.60 2.40 3.20]
const bool SSAO_ENABLED = true; // [false true]
const float SSAO_STRENGTH = 0.85; // [0.00 0.35 0.60 0.85 1.10 1.35]
const float SSAO_RADIUS = 1.40; // [0.50 0.90 1.40 2.00 2.80]
const bool VOLUMETRIC_FOG = true; // [false true]
const bool BLOOM_ENABLED = true; // [false true]
const int REFLECTION_QUALITY = 1; // [0 1 2 3]
const int TONE_PROFILE = 1; // [0 1 2]

//==================== Horror atmosphere ====================
const float HORROR_INTENSITY = 0.65; // [0.00 0.25 0.45 0.65 0.78 0.90 1.00]
const float FOG_DENSITY = 0.42; // [0.00 0.15 0.28 0.42 0.58 0.75 1.00]
const float FOG_HEIGHT = 0.35; // [0.00 0.20 0.35 0.55 0.80 1.00]
const float MOONLIGHT_STRENGTH = 0.55; // [0.15 0.30 0.55 0.75 1.00]
const float NIGHT_DESATURATION = 0.62; // [0.00 0.30 0.62 0.80 1.00]

//==================== Lighting and materials ====================
const float TORCH_WARMTH = 1.18; // [0.70 0.90 1.00 1.18 1.35 1.55]
const bool TORCH_FLICKER = true; // [false true]
const float MIN_LIGHT = 0.018; // [0.000 0.010 0.018 0.030 0.050]
const bool DETAIL_NORMALS = true; // [false true]
const float DETAIL_STRENGTH = 0.48; // [0.00 0.20 0.48 0.75 1.00]
const float PARALLAX_DEPTH = 0.035; // [0.000 0.015 0.035 0.060 0.090]
const float WETNESS_DARKENING = 0.38; // [0.00 0.18 0.38 0.60 0.85]
const float ENTITY_RIM_LIGHT = 0.24; // [0.00 0.12 0.24 0.40 0.60]
const bool HAND_LIGHT_FIX = true; // [false true]

//==================== Post processing ====================
const float TONEMAP_EXPOSURE = 0.92; // [0.55 0.70 0.92 1.10 1.35]
const float BLOOM_STRENGTH = 0.22; // [0.00 0.10 0.22 0.36 0.55]
const float VIGNETTE_STRENGTH = 0.46; // [0.00 0.20 0.46 0.65 0.85]
const float GRAIN_STRENGTH = 0.16; // [0.00 0.06 0.10 0.16 0.20 0.24 0.28]
const float CHROMATIC_ABERRATION = 0.35; // [0.00 0.15 0.35 0.55 0.80]
const float COLOR_GRADING_STRENGTH = 0.72; // [0.00 0.35 0.72 0.90 1.00]

//==================== Water ====================
const float WATER_DARKNESS = 0.60; // [0.15 0.35 0.60 0.80 1.00]
const float WATER_FOG = 0.62; // [0.00 0.25 0.62 0.82 1.00]
const float WATER_WAVE_STRENGTH = 0.42; // [0.00 0.20 0.42 0.70 1.00]

#endif
