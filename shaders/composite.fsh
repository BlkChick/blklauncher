#version 120

#include "/lib/common.glsl"

uniform sampler2D colortex0;
uniform sampler2D depthtex0;
uniform float viewWidth;
uniform float viewHeight;
uniform float rainStrength;
uniform int worldTime;

varying vec2 texcoord;

/* DRAWBUFFERS:0 */

float sampleAO(vec2 uv, float depth) {
    if (!SSAO_ENABLED) return 1.0;
    vec2 px = vec2(1.0 / viewWidth, 1.0 / viewHeight) * SSAO_RADIUS * 2.0;
    float ao = 0.0;
    ao += step(depth + 0.0015, texture2D(depthtex0, uv + vec2( px.x, 0.0)).r);
    ao += step(depth + 0.0015, texture2D(depthtex0, uv + vec2(-px.x, 0.0)).r);
    ao += step(depth + 0.0015, texture2D(depthtex0, uv + vec2(0.0,  px.y)).r);
    ao += step(depth + 0.0015, texture2D(depthtex0, uv + vec2(0.0, -px.y)).r);
    ao = 1.0 - (ao * 0.25) * SSAO_STRENGTH;
    return saturate(ao);
}

void main() {
    vec3 color = texture2D(colortex0, texcoord).rgb;
    float depth = texture2D(depthtex0, texcoord).r;
    color *= sampleAO(texcoord, depth);

    if (BLOOM_ENABLED) {
        vec2 px = vec2(1.0 / viewWidth, 1.0 / viewHeight);
        vec3 bloom = vec3(0.0);
        bloom += texture2D(colortex0, texcoord + px * vec2( 2.0, 0.0)).rgb;
        bloom += texture2D(colortex0, texcoord + px * vec2(-2.0, 0.0)).rgb;
        bloom += texture2D(colortex0, texcoord + px * vec2(0.0,  2.0)).rgb;
        bloom += texture2D(colortex0, texcoord + px * vec2(0.0, -2.0)).rgb;
        bloom *= 0.25;
        float mask = smoothstep(0.48, 1.0, luma(bloom));
        color += bloom * mask * BLOOM_STRENGTH;
    }

    float rainPulse = rainStrength * (0.92 + 0.08 * sin(float(worldTime) * 0.08));
    color *= mix(1.0, vec3(0.78, 0.84, 0.94), rainPulse * HORROR_INTENSITY);
    gl_FragData[0] = vec4(color, 1.0);
}
