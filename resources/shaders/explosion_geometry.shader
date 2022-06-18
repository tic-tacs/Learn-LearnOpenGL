#version 330 core
layout (triangles) in;
layout (triangle_strip, max_vertices = 3) out; 

in VS_OUT {
    vec2 texCoords;
}gs_in[];

uniform float time;
out vec2 TexCoords;

vec3 GetNormal() // view space prior to clip space the ndc
{
    vec3 a = vec3(gl_in[0].gl_Position) - vec3(gl_in[1].gl_Position);
    vec3 b = vec3(gl_in[2].gl_Position) - vec3(gl_in[1].gl_Position);
    return normalize(cross(a, b));
}

vec4 Explode(vec4 position, vec3 normal)
{
    float magnitude = 0.0;
    vec3 direction = normal * ((sin(time) + 1) / 2.0f) * magnitude;
    return position + vec4(direction, 0.0); 
}

void main()
{
    // entire triangle surface normal
    vec3 normal = GetNormal();

    gl_Position = Explode(gl_in[0].gl_Position, normal);
    TexCoords = gs_in[0].texCoords;
    EmitVertex();

    gl_Position = Explode(gl_in[1].gl_Position, normal);
    TexCoords = gs_in[1].texCoords;
    EmitVertex();

    gl_Position = Explode(gl_in[2].gl_Position, normal);
    TexCoords = gs_in[2].texCoords;
    EmitVertex();
    EndPrimitive();
}