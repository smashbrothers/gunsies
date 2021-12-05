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
		with(instance_create(x, y, Shell)){
			direction = other.gunangle + (other.right * 90) + orandom(30);
			speed	  = 3 + random(2);
		}
	}

#define weapon_fire(_wep)
    var l = 4, 
        d = gunangle + (accuracy * orandom(4));
        
     // Projectile:
    with(obj_create(x, y, "PiercerBullet")){
        move_contact_solid(d, l);
        
        creator = other;
        team    = other.team;
        image_angle = d;
        direction   = d;
        speed       = 16;
    }
                    
     // Game Feel:
    weapon_post(6, 4, 6);
    
     // Sounds:
    sound_play(sndPistol);
    
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