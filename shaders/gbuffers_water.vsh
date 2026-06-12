#version 120

#include "/lib/settings.glsl"

uniform int worldTime;

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec4 glcolor;
varying float distanceFade;
varying float wave;

void main() {
    vec4 pos = gl_Vertex;
    float t = float(worldTime) * 0.025;
    wave = sin(pos.x * 0.21 + t) * cos(pos.z * 0.17 - t * 1.3) * WATER_WAVE_STRENGTH;
    pos.y += wave * 0.045;
    gl_Position = gl_ModelViewProjectionMatrix * pos;
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    glcolor = gl_Color;
    distanceFade = length((gl_ModelViewMatrix * pos).xyz);
}
