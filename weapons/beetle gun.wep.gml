#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprBeetleGun.png", 4, 4);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "BEETLE GUN";
#define weapon_text return "CLOCKWORK WINGS";
#define weapon_type return 3; // Bolt
#define weapon_cost return 2;
#define weapon_load return 24;
#define weapon_area return 10; // 5-2
#define weapon_swap return sndSwapBow;

#define weapon_fire(_wep)
	
	 // Projectiles:
	for(var i = -1; i <= 1; i++){
		with(obj_create(x, y, "Beetle")){
			creator = other;
			team = other.team;
			
			direction = other.gunangle + (other.accuracy * (orandom(5) + (40 * i)));
			image_angle = direction;
			speed = 6;
			
			move_contact_solid(direction, speed);
		}
	}
	
	 // Game Feel:
	weapon_post(9, 5, 7);
	
	 // Sounds:
	var _snd = sound_play_pitchvol(sndSodaMachineBreak, random_range(0.7, 0.9), 1.2);
	audio_sound_set_track_position(_snd, 0.1);
	audio_sound_gain(_snd, 0, 650);
	
	var _snd = sound_play_pitchvol(sndNothingHurtMid, random_range(0.9, 1.1), 0.8);
	audio_sound_set_track_position(_snd, 0.1);
	audio_sound_gain(_snd, 0, 400);
	
	audio_sound_set_track_position(sound_play_gun(sndSeekerShotgun, 0.3, 0.3), 0.2);
	
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);