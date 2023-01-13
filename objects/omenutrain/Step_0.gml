/// @description 

if(x == xstart)
{
	spd = 0;
	
	timer = max(0, timer - 1);
	
	if(!timer)
	{
		spd = spdGoing;	
		timer = seconds(irandom_range(6, 15));
	}
}

x += spd;

if(x <= VW_WIDTH - 100)
{
	x += VW_WIDTH * 2
}
