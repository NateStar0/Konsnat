/// @description 

index = shader_get_sampler_index(shTexturise, "replacement_texture");
texture = sprite_get_texture(sNahoo_textest, 0);
bbtexture_uv = sprite_get_uvs(sNahoo_textest, 0);
size = sprite_get_width(sNahoo_textest);
unisize = shader_get_uniform(shTexturise, "size")
uniuvx = shader_get_uniform(shTexturise, "uv_x");
uniuvy = shader_get_uniform(shTexturise, "uv_y");


texture_uv = array_create(4, 0);
array_copy(texture_uv, 0, bbtexture_uv, 0, 4);

log(texture_uv, "AAAAAA")


