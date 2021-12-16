#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprWarpSMG.png", 1, 3);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "WARP SMG";
#define weapon_text return "APPLIED STRING THEORY";
#define weapon_type return 1; // Bullet
#define weapon_cost return 1;
#define weapon_load return 3;
#define weapon_area return 7; // 3-3
#define weapon_swap return sndSwapMachinegun;
#define weapon_auto return true;

#define weapon_reloaded
	 // The Shells:
	with(obj_create(x, y, "WarpShell")){
		direction = other.gunangle + (other.right * 90) + orandom(30);
		speed	  = 3 + random(2);
	}

#define weapon_fire(_wep)

     // Projectile:
    with(obj_create(x, y, "WarpBullet")){
        creator = other;
        team    = other.team;
        direction   = other.gunangle + (other.accuracy * orandom(16));
        image_angle = direction;
        speed       = 12;
    }
                    
     // Game Feel:
    weapon_post(6, 4, 6);
    
     // Sounds:
    audio_sound_set_track_position(sound_play_pitchvol(sndPortalStrikeFireButt, random_range(1.1, 1.3), 2), 1.05);
    
    sound_play_pitchvol(sndMachinegun, random_range(1.3, 1.5), 0.6);
    
    var _snd = sound_play_gun(sndRogueRifle, 0, 0.3);
    audio_sound_pitch(_snd, random_range(0.8, 1));
    audio_sound_gain(_snd, 0, 300);
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);