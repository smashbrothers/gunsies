#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprNemesis.png", 10, 4);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "NEMESIS";
#define weapon_text return "RUNNING HELL";
#define weapon_type return 1; // Bullet
#define weapon_cost return 3;
#define weapon_load return 5;
#define weapon_area return 10; // 5-2
#define weapon_swap return sndSwapMachinegun;

#define weapon_reloaded
	 // The Shells:
	with(instance_create(x, y, Shell)){
		direction = other.gunangle + (other.right * 90) + orandom(30);
		speed	  = 3 + random(2);
	}

#define weapon_fire(_wep)
	if("gunsies_nemesis_back" not in self){
		gunsies_nemesis_back = false;
	}
        
    if(gunsies_nemesis_back){
	    
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
	    sound_play(sndRogueRifle);
    }
    else{
    	
	     // Projectile:
	    var l = 5,
	    	o = accuracy * orandom(3);
	    	
	    for(var i = -90; i <= 90; i += 180){
		    var d = gunangle + i + o;
		    
		    with(instance_create(x, y, Bullet1)){
		        move_contact_solid(d, l);
		        
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
	    sound_play(sndPistol);
    }
    
    gunsies_nemesis_back = !gunsies_nemesis_back;
    
     // Burst:
    if(array_find_index(instances_matching(CustomObject, "name", "WeaponBurst"), other) < 0){
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
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);