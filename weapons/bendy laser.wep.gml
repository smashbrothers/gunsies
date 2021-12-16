#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprBendyLaser.png", 4, 5);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "XENON GUN";
#define weapon_text return "";
#define weapon_type return 5; // Energy
#define weapon_cost return 2;
#define weapon_load return 5;
#define weapon_area return -1;
#define weapon_auto return true;
#define weapon_swap return sndSwapEnergy;

#define weapon_fire(_wep)
	var _skill = skill_get(mut_laser_brain);
	
	 // 
	if(!is_object(wep)){
		wep = {"wep" : wep};
	}
	if(!lq_exists(wep, "inst")){
		wep.inst = noone;
	}
	
	 // 
	if(!instance_exists(wep.inst)){
		with(obj_create(x, y, "BendyLaserCont")){
			other.wep.inst = self;
			
			creator = other;
			team = other.team;
		}
	}
	
	 // 
	else{
		
	}
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);