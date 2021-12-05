#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprNeonGun.png", 4, 6);
    
    global.sprNeon = sprite_add("../sprites/projectiles/sprNeon.png", 1, 5, 5);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "NEON GUN";
#define weapon_text return "";
#define weapon_type return 5; // Energy
#define weapon_cost return 1;
#define weapon_load return 10;
#define weapon_area return -1;
#define weapon_swap return sndSwapEnergy;
#define weapon_auto return true;

#define weapon_fire(_wep)
    var _skill = skill_get(mut_laser_brain);
    
    var _last = noone;
    repeat(8){
    	with(Neon_create(x, y)){
    		creator = other;
    		team = other.team;
    		
    		direction = other.gunangle + orandom(4);
    		speed = 6;
    		
    		parent = _last;
    		with(_last){
    			child = other;
    		}
    		_last = self;
    	}
    }
    
    weapon_post(8, 4, 4);
    sound_play(sndLaser);
    
#define Neon_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "Neon";
		
		 // Visual:
		sprite_index = global.sprNeon;
		
		 // Vars:
		mask_index = mskPlasma;
		damage = 2;
		force = 2;
		typ = 0;
		child = noone;
		parent = noone;
		
		 // Events:
		on_end_step = script_ref_create(Neon_end_step);
		on_wall = script_ref_create(Neon_wall);
		
		return self;
	}
	
#define Neon_end_step
	if(instance_exists(child)){
		var _len = 10,
			_dis = point_distance(x, y, child.x, child.y),
			_dir = point_direction(x, y, child.x, child.y);
			
		var l = (_dis - _len) / 2,
			d = _dir;
		
		x += lengthdir_x(l, d);
		y += lengthdir_y(l, d);
		
		child.x -= lengthdir_x(l, d);
		child.y -= lengthdir_y(l, d);
	}
	
#define Neon_wall
	move_bounce_solid(false);
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);