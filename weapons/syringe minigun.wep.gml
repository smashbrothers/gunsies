#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprSyringeMinigun.png", 7, 8);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "SYRINGE MINIGUN";
#define weapon_text return "A CLIP FULL OF SUGAR";
#define weapon_type return 3; // Bolt
#define weapon_cost return 1;
#define weapon_load return 9;
#define weapon_area return 13; // 7-1
#define weapon_swap return sndSwapBow;
#define weapon_auto return true;

#define weapon_fire(_wep)
	
	 // Projectiles:
	with(obj_create(x, y, "Syringe")){
		creator = other;
		team = other.team;
		direction = other.gunangle + (other.accuracy * orandom(9));
		image_angle = direction;
		speed = 18;
	}
	
	 // Game Feel:
	weapon_post(7, 3, 2);
	motion_add(gunangle + 180, 1.4);
	
	 // Sounds:
	audio_sound_set_track_position(sound_play_pitchvol(sndSeekerPistol, 0.9, 0.7), 0.185);
	audio_sound_gain(sound_play_pitchvol(sndCrystalJuggernaut, 1.7, 1.3), 0, 350);
	sound_play_pitchvol(sndCrownAppear, 1.2, 0.7);
	
	sound_play_pitchvol(sndSnowTankPreShoot, 0.8, 0.4);
	
	sound_play_gun(sndLuckyShotProc, 0.3, 0.6);
	
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