/// @description 

depth = -10000.00;

oCamera.x = VW_WIDTH;
oCamera.y = 0;
oCamera.state = camera_state.lock;

oKons.hasControl = false;
oKons.visible = false;

global.pausable = false;

global.stage = 0;

toggleMute = function () 
{ 
	global.mute = !global.mute;
	menu[index].txt = global.mute ? "Muted" : "Mute";
}

renderLeaderboard = function()
{
	
}

changeMenu = function()
{
	menu = pages[menu[index].close]
	index = 0;
	timer = seconds(0.1);
	go = false;
	exit;
}

start = function()
{
	oCamera.colour_state = colour_states.toBlack;
	instance_create_depth(x, y, depth, oGenerator);
	//generate.init();	
}

/**
	@param {String} text 
	@param {Function} func 
	@param {Real} destroy 
*/

item = function (text, func, destroy) constructor { txt = text; fun = func; close = destroy} 


pages =
[
	[
		new item("Play", start, 0),
		//new item("Leaderboard", renderLeaderboard, 1),
		new item("Options", changeMenu, 1),
		new item("Exit", game_end, 0)
	],
	
	[
		new item(global.mute ? "Muted" : "Mute", toggleMute, 1),
		new item("Back", changeMenu, 0)
	],
	
	[
		new item("Konsnat", changeMenu, 0),
	]
]

menu = pages[2];

index = 0;
interp = VW_WIDTH + 32;
h = VW_HEIGHT * (5 / 8);
buff = 32;
goal = 0;
spd = 4;

timer = seconds(0.1);
go = true;

render = function ()
{
	var input = global.input;
	var dir = (input[3][INPUTTYPE.PRESS] - input[2][INPUTTYPE.PRESS]);
	var commit = (input[0][INPUTTYPE.PRESS] || input[1][INPUTTYPE.PRESS]);
	
	go = true;
	
	index = clamp(index + dir, 0, array_length(menu) - 1);
	
	timer = max(timer - 1, 0);
	
	if(commit && timer == 0)
	{
		menu[index].fun();
		
		if(menu[index].close == 0 && go)
		{
			instance_destroy();	
		}
	}
	
	draw_set_colour(cc_white);
	
	draw_set_text(cc_white, fa_center, fa_middle);
	
	var str = (index == 0) ? "" : "<";
	str += menu[index].txt;
	str += (index == array_length(menu) - 1) ? "" : ">";
	
	draw_text(320 / 2, 180 - 16, str);
	
	draw_set_colour(c_white);
}
