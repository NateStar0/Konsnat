/// @description - Set the weather 

//Set the global
global.weather = weather.raining;

//General system
particle_sys_rain = part_system_create();

cam = view_camera[0];

//Particle
particle_rain = part_type_create();
part_type_shape(particle_rain, pt_shape_line);
part_type_size(particle_rain, 0.07, 0.14, 0, 0);
part_type_color_mix(particle_rain, cc_white, cc_white);
part_type_alpha2(particle_rain, 1, 1);
part_type_gravity(particle_rain, 0.1, global.raindir);
part_type_speed(particle_rain, 1.3, 1.3, 0, 0);
part_type_direction(particle_rain, global.raindir, global.raindir, 0, 0.1);
part_type_orientation(particle_rain, global.raindir, global.raindir, 0, 0, 0);

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
part_emitter_stream(particle_sys_rain, particle_emmiter, particle_rain, 20)

//Timer
alarm[0] = seconds(0.5);
