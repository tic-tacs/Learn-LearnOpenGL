#version 330 core

layout (location = 0) in vec3 aPosition;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexCoord;

out vec3 Normal;
out vec3 FragPos;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;
void main()
{
	FragPos = vec3(model * vec4(aPosition, 1.0)); // get fragment position in world space for lighting calculations
	Normal = mat3(transpose(inverse(model))) * aNormal; // get normals in clip space 

	gl_Position = projection * view * model * vec4(aPosition, 1.0);
}