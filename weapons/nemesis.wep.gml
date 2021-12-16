#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprNemesis.png", 10, 4);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "NEMESIS";
#define weapon_text return "RUNNING HELL";
#define weapon_type return 1; // Bullet
#define weapon_cost return 2;
#define weapon_load return 5;
#define weapon_area return 10; // 5-2
#define weapon_swap return sndSwapMachinegun;

#define weapon_reloaded
	 // The Shells:
	repeat(2){
		with(instance_create(x, y, Shell)){
			direction = other.gunangle + (other.right * 90) + orandom(30);
			speed	  = 3 + random(2);
		}	
	}
	with(obj_create(x, y, "WarpShell")){
		direction = other.gunangle + (other.right * 90) + orandom(30);
		speed	  = 3 + random(2);
	}

#define weapon_fire(_wep)
    if(array_find_index(instances_matching(CustomObject, "name", "WeaponBurst"), other) < 0){
    	
	     // Projectile:
	    var l = 5,
	    	o = accuracy * orandom(3);
	    	
	    for(var i = -90; i <= 90; i += 180){
		    var d = gunangle + i + o;
		    
		    with(instance_create(x + lengthdir_x(l, d), y + lengthdir_y(l, d), Bullet1)){
		        creator = other;
		        team    = other.team;
		        
		        direction   = other.gunangle + o;
		        image_angle = direction;
		        speed       = 16;
		    }
	    }

	     // Game Feel:
	    weapon_post(6, 4, 6);
	    
	     // Sounds:
	    audio_sound_gain(sound_play_pitchvol(sndHeavyMachinegun, random_range(0.9, 1.1), 0.6), 0, 550);
	     
	    sound_play_gun(sndMachinegun, 0.3, 0.3);
	    
	     // Burst:
        with(obj_create(x, y, "WeaponBurst")){
            accuracy = other.accuracy;
            creator  = other;
            team     = other.team;
            spec     = other.specfiring;
            wep      = _wep;
            ammo     = 1;
            time_max = 4;
            time     = time_max;
        }
    }
    else{
    	
		 // Projectile:
	    with(obj_create(x, y, "WarpBullet")){
	        creator = other;
	        team    = other.team;
	        
	        direction   = other.gunangle + (other.accuracy * orandom(5)) + 180;
	        image_angle = direction;
	        speed       = 12;
	        
	        move_contact_solid(direction, speed);
	    }
	    
	     // Game Feel:
	    weapon_post(-4, -4, 6);
	    
	     // Sounds:
	    audio_sound_set_track_position(sound_play_pitchvol(sndPortalStrikeFireButt, random_range(1.1, 1.3), 2), 1.05);
	    
	    sound_play_pitchvol(sndMachinegun, random_range(1.3, 1.5), 0.6);
	    
	    var _snd = sound_play_gun(sndRogueRifle, 0, 0.3);
	    audio_sound_pitch(_snd, random_range(0.8, 1));
	    audio_sound_gain(_snd, 0, 300);
    }
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);