/// @description Init

#macro GAMENAME "Konsnat"

show_debug_overlay(1)

global.stage = 0;

//		--- Colours ---

colours();

//		---	Display Management	---

global.pausable = false;

#macro WIN_WIDTH 960
#macro WIN_HEIGHT 540

#macro VW_WIDTH 320
#macro VW_HEIGHT 180

global.fullscreen = false;

window_set_size(WIN_WIDTH, WIN_HEIGHT);
display_set_gui_size(VW_WIDTH, VW_HEIGHT);

window_set_caption(GAMENAME);

//		--- Audio Management ---

global.mute = false;

//		--- Font management ---

font = font_add_sprite_ext(sFont, " !\"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^'_\{|}~abcdefghijklmnopqrstuvwxyz", false, false);
draw_set_font(font);

//		--- Input management ---

global.input = [];

keys = [ord("W"), ord("S"), ord("A"), ord("D"), ord("E"), ord("Q"), vk_escape, vk_tab];

enum INPUTTYPE
{
	PRESS, 
	HOLD,
	RELEASE
}

//		--- Misc ---

enum weather
{
	clear, 
	raining
}

global.weather = weather.clear;
global.rainoffset = 20 // Flowing to the right
global.raindir = 270 + global.rainoffset

//		--- Exit Init	---

room_goto_next();
