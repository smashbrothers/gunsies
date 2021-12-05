#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprBouncerOverlord.png", 9, 8);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "MONARCH";
#define weapon_text return "";
#define weapon_type return 1; // Bullet
#define weapon_cost return 2;
#define weapon_load return 1;
#define weapon_area return -1;
#define weapon_auto return true;
#define weapon_swap return sndSwapMachinegun;

#define weapon_reloaded
	 // The Shells:
	repeat(weapon_get_cost(mod_current)){
		with(instance_create(x, y, Shell)){
			direction = other.gunangle + orandom(30) + 180;
			speed	  = 3 + random(2);
		}
	}

#define weapon_fire(_wep)
	
	weapon_post(12, 16, 8);
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);