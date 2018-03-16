/// @description Insert description here
// You can write your code in this editor

collision_tick = max(0, collision_tick - 1);
if (collision_tick <= 0) {
	global.hp--;
	collision_tick = MAX_COLLISION_TICK;
	audio_play_sound(sHit, 1, false);	
}
