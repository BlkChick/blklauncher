#version 120

varying vec4 glcolor;
varying vec3 viewDir;

void main() {
    gl_Position = ftransform();
    glcolor = gl_Color;
    viewDir = normalize((gl_ModelViewMatrix * gl_Vertex).xyz);
}
