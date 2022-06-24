#pragma once
#include "Shader.h"

#include <vector>
#include <assimp/Importer.hpp>
#include <assimp/scene.h>
#include <assimp/postprocess.h>

#include "Mesh.h"
class Model
{
public:
	Model(std::string path) { loadModel(path); }
	~Model();

	void Draw(Shader& shader);
	std::vector<Mesh> Meshes;
	std::vector<Texture> textures_loaded;
private:
	// model data
	std::string directory;

	void loadModel(std::string& path);
	void processNode(aiNode* node, const aiScene* scene);
	Mesh processMesh(aiMesh* mesh, const aiScene* scene);

	std::vector<Texture> loadMaterialTextures(aiMaterial* mat, aiTextureType type, std::string typeName);
	unsigned int TextureFromFile(const char* texName, std::string directory);
};