/// @description 

shader_set(shTexturise);
texture_set_stage(index, texture);
shader_set_uniform_f(unisize, size)
shader_set_uniform_f(uniuvx, texture_uv[0]);
shader_set_uniform_f(uniuvy, texture_uv[1]);

draw_self();

shader_set(shDefault);
