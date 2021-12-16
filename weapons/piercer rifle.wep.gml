#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprPiercerRifle.png", 4, 4);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "PIERCER RIFLE";
#define weapon_text return "";
#define weapon_type return 1; // Bullet
#define weapon_cost return 2;
#define weapon_load return 9;
#define weapon_area return 7; // 3-3
#define weapon_swap return sndSwapMachinegun;

#define weapon_reloaded
	 // The Shells:
	repeat(3){
		with(obj_create(x, y, "PiercerShell")){
			direction = other.gunangle + (other.right * 90) + orandom(30);
			speed	  = 3 + random(2);
		}
	}

#define weapon_fire(_wep)
        
     // Projectile:
    with(obj_create(x, y, "PiercerBullet")){
        
        creator = other;
        team    = other.team;
        direction   = other.gunangle + (other.accuracy * orandom(4));
        image_angle = direction;
        speed       = 16;
    }
                    
     // Game Feel:
    weapon_post(6, 4, 6);
    sleep(30);
    
     // Sounds:
    // sound_play_pitch(sndBouncerSmg, 1.2)
    // sound_play_pitchvol(sndSmartgun, 2, 0.4);
    // sound_play_pitchvol(sndTurretFire, 0.9, 0.7);
    // sound_play_pitch(sndPistol, 0.8)
    // audio_sound_set_track_position(sound_play_pitch(sndPlasmaHit, random_range(0.4, 0.5)), 0.18);
    // audio_sound_set_track_position(sound_play_pitchvol(sndGunGun, random_range(0.9, 1.1), 0.6), 0.2);
    audio_sound_set_track_position(sound_play_pitchvol(sndGuitarHit7, random_range(0.7, 0.9), 0.8), 0.2);
    audio_sound_set_track_position(sound_play_pitchvol(sndNothing2Ball, random_range(0.8, 1), 0.4), 0.2);
    audio_sound_pitch(sound_play_gun(sndPistol, 0, 0.3), random_range(0.7, 0.9));
    
     // Burst:
    if(array_find_index(instances_matching(CustomObject, "name", "WeaponBurst"), other) < 0){
        with(obj_create(x, y, "WeaponBurst")){
            accuracy = other.accuracy;
            creator  = other;
            team     = other.team;
            spec     = other.specfiring;
            wep      = _wep;
            ammo     = 2;
            time_max = 2;
            time     = time_max;
        }
    }
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);