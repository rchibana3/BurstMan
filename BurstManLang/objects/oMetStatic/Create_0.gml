/// @description Insert description here
// You can write your code in this editor

hsp = 0;
vsp = 0;
grv = 0.35;
walksp = 5;
sprite_index = sMet;
image_index = 0;
image_speed = 0;
image_xscale = -image_xscale;
hp = 5;



SITTING_TICK_MAX = 50;
EMERGING_TICK_MAX = 60;
SHOOTING_TICK_MAX = 30;
MOVING_TICK_MAX = 8;
MOVING_ITERATIONS = 3;

MAX_COLLISION_TICK = 8;
collision_tick = MAX_COLLISION_TICK;

is_sitting = true;
sitting_tick = random(SITTING_TICK_MAX);

is_emerging = false;
emerging_tick = 0;

is_shooting = false;
shooting_tick = 0;

is_moving = false;
moving_tick = 0;
moving_iteration = MOVING_ITERATIONS;



shooting_anim = 0;
firingdelay = 0;

audio_play_sound(sMusic, 1, true);