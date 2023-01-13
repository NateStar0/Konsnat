/// @description - Move the rain view

//Stop the rain
part_emitter_destroy(particle_sys_rain, particle_emmiter);

//Emmiters
particle_emmiter = part_emitter_create(particle_sys_rain);

area = 
{
	x1 : camera_get_view_x(cam) - WIN_WIDTH,
	y1 : camera_get_view_y(cam) - 32,
	x2 : camera_get_view_x(cam) + camera_get_view_width(cam) + WIN_WIDTH,
	y2 : camera_get_view_y(cam)
}

part_emitter_region(particle_sys_rain, particle_emmiter, area.x1, area.x2, area.y1, area.y2, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(particle_sys_rain, particle_emmiter, particle_rain, 5)

//Timer
alarm[0] = seconds(0.2);
