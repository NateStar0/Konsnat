/// @description 

with(instance_place(x, y, oKons))
{
	hp -= 1;	
	hsp = 1 * sign(x - other.x);
}

instance_destroy();
