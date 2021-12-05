#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprWarpRifle.png", 4, 4);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "WARP RIFLE";
#define weapon_text return "CONTINUUM";
#define weapon_type return 1; // Bullet
#define weapon_cost return 2;
#define weapon_load return 8;
#define weapon_area return 7; // 3-3
#define weapon_swap 
	audio_sound_set_track_position(sound_play_hit(sndHorrorPortal, 0.3), 1.2);
	return sndSwapMachinegun;

#define weapon_reloaded
	 // The Shells:
	repeat(weapon_get_cost(mod_current)){
		with(instance_create(x, y, Shell)){
			direction = other.gunangle + (other.right * 90) + orandom(30);
			speed	  = 3 + random(2);
		}
	}

#define weapon_fire(_wep)
    var l = 4, 
        d = gunangle + (accuracy * orandom(4));
        
     // Projectile:
    with(obj_create(x, y, "WarpBullet")){
        move_contact_solid(d, l);
        
        creator = other;
        team    = other.team;
        image_angle = d;
        direction   = d;
        speed       = 12;
    }
                    
     // Game Feel:
    weapon_post(6, 4, 6);
    
     // Sounds:
    sound_play(sndPistol);
    // sound_set_track_position(sound_play(sndRogueRifle), 0);
    
     // Burst:
    if(array_find_index(instances_matching(CustomObject, "name", "WeaponBurst"), other) < 0){
        with(obj_create(x, y, "WeaponBurst")){
            accuracy = other.accuracy;
            creator  = other;
            team     = other.team;
            spec     = other.specfiring;
            wep      = _wep;
            ammo     = 1;
            time_max = 3;
            time     = time_max;
        }
    }
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);