/// @description 

if(place_meeting(x, y, oKons))
{
	oKons.hasControl ^= (global.input[4][INPUTTYPE.PRESS]);

	if(!oKons.hasControl)
	{
		if(global.input[0][INPUTTYPE.PRESS] && canUp) oKons.y -= VW_HEIGHT;
		if(global.input[1][INPUTTYPE.PRESS] && canDown) oKons.y += VW_HEIGHT;
	}
}

image_index = elevator;

