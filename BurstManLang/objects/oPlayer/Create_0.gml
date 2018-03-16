/// @description Insert description here
// You can write your code in this editor

hsp = 0;
vsp = 0;
grv = 0.35;
walksp = 5;
sprite_index = sPlayerJ;
shooting_anim = 0;
firingdelay = 0;
hitdelay = 0;

global.hp = 6;
global.dying = false;

death_tick = 60;
audio_play_sound(sMusic, 1, true);