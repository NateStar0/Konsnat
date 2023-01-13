/// @description - Clean up the particle system

global.weather = weather.clear;

part_emitter_destroy(particle_sys_rain, particle_emmiter);
part_system_destroy(particle_sys_rain);
part_type_destroy(particle_rain);
