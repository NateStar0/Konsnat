/// @description Init menu when anykey

if(keyboard_check_pressed(vk_anykey))
{
	instance_create_layer(x, y, layer, oMetru)

	instance_destroy();
}
