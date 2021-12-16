#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprPiercerSMG.png", 5, 3);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "PIERCER SMG";
#define weapon_text return "";
#define weapon_type return 1; // Bullet
#define weapon_cost return 1;
#define weapon_load return 3;
#define weapon_area return 7; // 3-3
#define weapon_swap return sndSwapMachinegun;
#define weapon_auto return true;

#define weapon_reloaded
	 // The Shells:
	with(obj_create(x, y, "PiercerShell")){
		direction = other.gunangle + (other.right * 90) + orandom(30);
		speed	  = 3 + random(2);
	}

#define weapon_fire(_wep)

     // Projectile:
    with(obj_create(x, y, "PiercerBullet")){
        
        creator = other;
        team    = other.team;
        direction   = other.gunangle + (other.accuracy * orandom(20));
        image_angle = direction;
        speed       = 16;
    }
                    
     // Game Feel:
    weapon_post(6, 4, 6);
    
     // Sounds:
    audio_sound_set_track_position(sound_play_pitchvol(sndGuitarHit7, random_range(0.7, 0.9), 0.8), 0.2);
    audio_sound_set_track_position(sound_play_pitchvol(sndNothing2Ball, random_range(0.8, 1), 0.4), 0.2);
    audio_sound_pitch(sound_play_gun(sndPistol, 0, 0.3), random_range(0.7, 0.9));
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);