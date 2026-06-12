#version 120

#include "/lib/common.glsl"

uniform sampler2D colortex0;
uniform float viewWidth;
uniform float viewHeight;
uniform int frameCounter;

varying vec2 texcoord;

void main() {
    vec2 uv = texcoord;
    vec2 center = uv - 0.5;
    float vignette = smoothstep(0.88, 0.18, length(center));

    vec2 aberr = center * CHROMATIC_ABERRATION / vec2(viewWidth, viewHeight) * 2.0;
    vec3 color;
    color.r = texture2D(colortex0, uv + aberr).r;
    color.g = texture2D(colortex0, uv).g;
    color.b = texture2D(colortex0, uv - aberr).b;

    color = tonemap(color);
    color *= mix(1.0 - VIGNETTE_STRENGTH, 1.0, vignette);

    float grain = hash12(uv * vec2(viewWidth, viewHeight) + float(frameCounter)) - 0.5;
    color += grain * GRAIN_STRENGTH * (0.55 + HORROR_INTENSITY * 0.45);
    color = saturate(color);

    gl_FragColor = vec4(color, 1.0);
}
