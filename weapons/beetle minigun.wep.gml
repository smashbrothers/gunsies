#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprBeetleMinigun.png", 5, 7);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "BEETLE MINIGUN";
#define weapon_text return "BUZZING BRASS";
#define weapon_type return 3; // Bolt
#define weapon_cost return 1;
#define weapon_load return 9;
#define weapon_area return 14; // 7-2
#define weapon_swap return sndSwapBow;
#define weapon_auto return true;

#define weapon_fire(_wep)
	
	 // Projectiles:
	with(obj_create(x, y, "Beetle")){
		creator = other;
		team = other.team;
		
		direction = other.gunangle + (other.accuracy * orandom(40));
		image_angle = direction;
		speed = 6;
		
		move_contact_solid(direction, speed);
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
	
     // Burst:
    if(array_find_index(instances_matching(CustomObject, "name", "WeaponBurst"), other) < 0){
        with(obj_create(x, y, "WeaponBurst")){
            accuracy = other.accuracy;
            creator  = other;
            team     = other.team;
            spec     = other.specfiring;
            wep      = _wep;
            ammo     = 2;
            time_max = 3;
            time     = time_max;
        }
    }
	
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);