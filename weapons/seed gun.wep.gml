#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprSeedGun.png", 5, 4);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "SEED GUN";
#define weapon_text return "TERRAFORM";
#define weapon_type return 3; // Bolt
#define weapon_cost return 2;
#define weapon_load return 24;
#define weapon_area return 8; // 4-1
#define weapon_swap return sndSwapBow;

#define weapon_fire(_wep)

	 // Projectile:
	with(obj_create(x, y, "Seed")){
		creator = other;
		team = other.team;
		
		direction = other.gunangle + (other.accuracy * orandom(4));
		image_angle = direction;
		speed = 16;
	}
	
	 // Sounds:
	sound_play_pitchvol(sndUltraCrossbow, random_range(2.5, 2.7), 0.7);
	audio_sound_set_track_position(sound_play_pitchvol(sndSeekerPistol, 0.9, 0.5), 0.185);
	audio_sound_set_track_position(sound_play_pitch(sndSnowmanBreak, random_range(0.9, 1.1)), 0.2);
	audio_sound_pitch(sound_play_gun(sndPlantFire, 0, 0.3), random_range(0.7, 0.9));
	
	 // Game Feel:
	weapon_post(8, 5, 3);
	motion_add(gunangle + 180, 3);
	sleep(17);
	
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);