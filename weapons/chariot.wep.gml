#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprChariot.png", 4, 4);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "CHARIOT";
#define weapon_text return "";
#define weapon_type return 1; // Bullet
#define weapon_cost return 3;
#define weapon_load return 9;
#define weapon_area return -1;
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
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);