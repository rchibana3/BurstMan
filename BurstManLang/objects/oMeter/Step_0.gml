/// @description Insert description here
// You can write your code in this editor

image_index = max(0, global.hp - 1);

if (global.dying)
{
	death_tick = death_tick-1;
	if (death_tick <=0) game_restart();	
}
	