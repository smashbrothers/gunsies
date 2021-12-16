#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprAnchorLauncher.png", 6, 7);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "ANCHOR LAUNCHER";
#define weapon_text return "";
#define weapon_type return 3; // Bolt
#define weapon_cost return 3;
#define weapon_load return 24;
#define weapon_area return 10; // 5-2
#define weapon_auto return true;
#define weapon_swap return sndSwapBow;

#define weapon_fire(_wep)
	
	 // Projectile:
	with(obj_create(x, y, "Anchor")){
		creator = other;
		team = other.team;
		
		direction = other.gunangle + (other.accuracy * orandom(12));
		image_angle = direction;
		speed = 8;
	}
	
	 // Game Feel:
	weapon_post(20, 15, 25);
	motion_add(gunangle + 180, 4);
	
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);