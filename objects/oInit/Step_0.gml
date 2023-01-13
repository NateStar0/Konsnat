/// @description Run global code

for(var i = 0; i < array_length(keys); i++)
{
	global.input[i] = [keyboard_check_pressed(keys[i]), keyboard_check(keys[i]), keyboard_check_released(keys[i])];
}

global.raindir = 270 + global.rainoffset

global.rainoffset += (mouse_wheel_up() - mouse_wheel_down())

if(keyboard_check_pressed(ord("P")))
{
	room_restart();
}

if(keyboard_check_pressed(ord("R")))
{
	wfc(sWFCTest2, 8, 8)
}
