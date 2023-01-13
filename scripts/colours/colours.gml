
/*
	All colours are ripped from GOLD GB, an awesome palette! + Pure black and white
	
	Link: https://lospec.com/palette-list/gold-gb
*/

#macro cc_black $000000 // 0, 0, 0 (000000)
#macro cc_brown $1b0b21 // 33, 11, 27 (210b1b)
#macro cc_dark $2c224d // 77, 34, 44 (4d222c)
#macro cc_fair $4c659d // 157, 101, 76 (9d654c)
#macro cc_light $51abcf // 207, 171, 81 (cfab51)
#macro cc_white $FFFFFF // 255, 255, 255 (FFFFFF)

global.coloursValues = [[0, 0, 0], [33, 11, 27], [77, 34, 44], [157, 101, 76], [207, 171, 81], [255, 255, 255] ];

global.ccArr = [cc_black, cc_brown, cc_dark, cc_fair, cc_light, cc_white];
global.colourMap = [0, 1, 2, 3, 4, 5];

function colours()
{
	oInit.shHandleColourReplacementBlack = shader_get_uniform(shDefault, "colourReplacementBlack");
	oInit.shHandleColourReplacementDarkest = shader_get_uniform(shDefault, "colourReplacementDarkest");
	oInit.shHandleColourReplacementDarker = shader_get_uniform(shDefault, "colourReplacementDarker");
	oInit.shHandleColourReplacementBrighter = shader_get_uniform(shDefault, "colourReplacementBrighter");
	oInit.shHandleColourReplacementBrighest = shader_get_uniform(shDefault, "colourReplacementBrighest");
	oInit.shHandleColourReplacementWhite = shader_get_uniform(shDefault, "colourReplacementWhite");

	oInit.shHandleColourBlack = shader_get_uniform(shDefault, "colourBlack");
	oInit.shHandleColourDarkest = shader_get_uniform(shDefault, "colourDarkest");
	oInit.shHandleColourDarker = shader_get_uniform(shDefault, "colourDarker");
	oInit.shHandleColourBrighter = shader_get_uniform(shDefault, "colourBrighter");
	oInit.shHandleColourBrighest = shader_get_uniform(shDefault, "colourBrighest");
	oInit.shHandleColourWhite = shader_get_uniform(shDefault, "colourWhite");
}

function predraw_colour()
{
	shader_set_uniform_f(oInit.shHandleColourReplacementBlack, global.coloursValues[global.colourMap[0]][0] / 255, global.coloursValues[global.colourMap[0]][1] / 255, global.coloursValues[global.colourMap[0]][2] / 255, 1);
	shader_set_uniform_f(oInit.shHandleColourReplacementDarkest, global.coloursValues[global.colourMap[1]][0] / 255, global.coloursValues[global.colourMap[1]][1] / 255, global.coloursValues[global.colourMap[1]][2] / 255, 1);
	shader_set_uniform_f(oInit.shHandleColourReplacementDarker, global.coloursValues[global.colourMap[2]][0] / 255, global.coloursValues[global.colourMap[2]][1] / 255, global.coloursValues[global.colourMap[2]][2] / 255, 1);
	shader_set_uniform_f(oInit.shHandleColourReplacementBrighter, global.coloursValues[global.colourMap[3]][0] / 255, global.coloursValues[global.colourMap[3]][1] / 255, global.coloursValues[global.colourMap[3]][2] / 255, 1);
	shader_set_uniform_f(oInit.shHandleColourReplacementBrighest, global.coloursValues[global.colourMap[4]][0] / 255, global.coloursValues[global.colourMap[4]][1] / 255, global.coloursValues[global.colourMap[4]][2] / 255, 1);
	shader_set_uniform_f(oInit.shHandleColourReplacementWhite, global.coloursValues[global.colourMap[5]][0] / 255, global.coloursValues[global.colourMap[5]][1] / 255, global.coloursValues[global.colourMap[5]][2] / 255, 1);
	
	shader_set_uniform_f(oInit.shHandleColourBlack, global.coloursValues[0][0] / 255, global.coloursValues[0][1] / 255, global.coloursValues[0][2] / 255, 1);
	shader_set_uniform_f(oInit.shHandleColourDarkest, global.coloursValues[1][0] / 255, global.coloursValues[1][1] / 255, global.coloursValues[1][2] / 255, 1);
	shader_set_uniform_f(oInit.shHandleColourDarker, global.coloursValues[2][0] / 255, global.coloursValues[2][1] / 255, global.coloursValues[2][2] / 255, 1);
	shader_set_uniform_f(oInit.shHandleColourBrighter, global.coloursValues[3][0] / 255, global.coloursValues[3][1] / 255, global.coloursValues[3][2] / 255, 1);
	shader_set_uniform_f(oInit.shHandleColourBrighest, global.coloursValues[4][0] / 255, global.coloursValues[4][1] / 255, global.coloursValues[4][2] / 255, 1);
	shader_set_uniform_f(oInit.shHandleColourWhite, global.coloursValues[5][0] / 255, global.coloursValues[5][1] / 255, global.coloursValues[5][2] / 255, 1);
}

/* 
	All colours are provided by lospec as apart of GradxKid's Sweetie 16 palette
	
	See: https://lospec.com/palette-list/sweetie-16
	
*/

/*

#macro cw_black $2c1c1a // 1a1c2c
#macro cw_purple $5d275d // 5d275d
#macro cw_red $533eb1 // b13e53
#macro cw_orange $577def // ef7d57

#macro cw_yellow $75cdff // ffcd75
#macro cw_lime $70f0a7 // a7f070
#macro cw_green $64b738 // 38b764
#macro cw_dkgreen $797125 // 257179

#macro cw_dkblue $6f3629 // 29366f
#macro cw_blue $c95d3b // 3b5dc9
#macro cw_skblue $f6a641 // 41a6f6
#macro cw_aqua $f7ef73 // 73eff7

#macro cw_white $f4f4f4 // f4f4f4
#macro cw_grey $c2b094 // 94b0c2
#macro cw_dkgrey $866c56 // 566c86
#macro cw_dkrgrey $573c33 // 333c57

global.cw_array = [cw_black, cw_purple, cw_red, cw_orange, cw_yellow, cw_lime, cw_green, cw_dkgreen, cw_dkblue, cw_blue, cw_skblue, cw_aqua, cw_white, cw_grey, cw_dkgrey, cw_dkrgrey]
*/
/**/