#define init
	var m = "../sprites/",
		p = m;
		
	p = m + "weapons/";
    global.sprWep = sprite_add_weapon(p + "sprSuperAcidBazooka.png", 10, 9);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "SUPER ACID BAZOOKA";
#define weapon_text return "STRONG HANDSHAKE";
#define weapon_type return 4; // Explosive
#define weapon_cost return 5;
#define weapon_load return 35;
#define weapon_area return -1;
#define weapon_swap return sndSwapExplosive;
#define weapon_burst return 2;
#define weapon_burst_time return 4;

#define weapon_fire(_wep)
	
	var n = (array_find_index(instances_matching(CustomObject, "name", "WeaponBurst"), other) >= 0) + 1,
		o = 24;
	
	for(var i = (n / -2); i <= (n / 2); i++){
		
		 // Projectile:
		with(mod_script_call("weapon", "acid bazooka", "AcidRocket_create", x, y)){
			creator = other;
			team = other.team;
			
			direction = other.gunangle + (other.accuracy * (i * o));
			image_angle = direction;
			speed = 2;
		}
	}
	
	 // Game Feel:
	weapon_post(24, 16, 48);
	motion_add(gunangle + 180, 4);
	sleep(40);
	
	sound_play_pitchvol(sndSuperBazooka, random_range(0.9, 1.1), 0.5);
	audio_sound_set_track_position(sound_play_pitchvol(sndSewerPipeBreak, random_range(0.7, 0.9), 0.4), 0.1);
	audio_sound_gain(sound_play_gun(sndNothingHurtHigh, 0.1, 0.5), 0.7, 0);
	
     // Burst:
    if(array_find_index(instances_matching(CustomObject, "name", "WeaponBurst"), other) < 0){
        with(obj_create(x, y, "WeaponBurst")){
            accuracy = other.accuracy;
            creator  = other;
            team     = other.team;
            spec     = other.specfiring;
            wep      = _wep;
            ammo     = weapon_burst() - 1;
            time_max = weapon_burst_time();
            time     = time_max;
        }
    }

    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);