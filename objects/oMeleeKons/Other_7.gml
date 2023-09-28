/// @description 

if(instance_exists(pEnemy))
{
	with(instance_place(x, y, pEnemy))
	{
		hp -= 1;	
		
		hsp = knockback * sign(x - other.x);
	}
}

instance_destroy();
