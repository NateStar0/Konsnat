/// @description 

for(var i = 0; i < keyCount; i++)
{
	global.input[i][0] = keyboard_check_pressed(keys[i])
	global.input[i][1] = keyboard_check(keys[i])
}

oKons.hp -= keyboard_check_pressed(ord("O"))
