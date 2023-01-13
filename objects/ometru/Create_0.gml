/// @description 

depth = -10000.00;

global.pausable = false;

toggle_mute = function () 
{ 
	global.mute = !global.mute;
	menu[index].txt = global.mute ? "Muted" : "Mute";
}

render_leaderboard = function()
{
	
}

change_menu = function()
{
	log(menu, global.input)
	menu = pages[menu[index].close]
	index = 0;
	timer = seconds(0.1);
	go = false;
	exit;
}

start = function()
{
	log(global.input, index)
	generate.init();	
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
		new item("Leaderboard", render_leaderboard, 1),
		new item("Options", change_menu, 1),
		new item("Exit", game_end, 0)
	],
	
	[
		new item(global.mute ? "Muted" : "Mute", toggle_mute, 1),
		new item("Back", change_menu, 0)
	]
]

menu = pages[0];

index = 0;
interp = VW_WIDTH + 32;
h = VW_HEIGHT * (5 / 8);
buff = 32;
goal = 0;
spd = 4;

timer = seconds(0.1);
go = true;

channel_changespeed = animcurve_get_channel(cMenu, "main");

render = function ()
{
	var input = global.input;
	var dir = (input[3][inp.press] - input[2][inp.press]);
	var commit = (input[0][inp.press] || input[1][inp.press]);
	
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
