/// @description 

currentWave = 0;

enemyWeightings = 
[
	[3, oEnemyDistance],
	[1, oEnemyBasic],
];

enemies = [];

countdown = seconds(oKons.hp);

base = [0, 1, 2, 3, 4, 5];
num = sprite_get_number(sMenuTrainChunk);

avg = (GUI_BOTTOMOFFSET_TOP + GUI_BOTTOMOFFSET_BOTTOM) / 2;
