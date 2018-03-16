/// @description Insert description here
// You can write your code in this editor

sprite_index = sYelp1;

win_tick = max(win_tick - 1, 0);

if (!played_sound) {
	audio_stop_sound(sMusic);
	audio_play_sound(sVictory, 1, false);
	played_sound = true;
}

if (win_tick <= 0) {
	game_restart();	
}