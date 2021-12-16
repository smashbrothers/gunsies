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
    		speed = random(6);
    		
    		parent = _last;
    		with(_last){
    			child = other;
    		}
    		_last = self;
    	}
    }
    _last.speed = 6;
    
    weapon_post(8, 4, 4);
    sound_play(sndLaser);
    
#define Neon_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "Neon";
		
		 // Visual:
		sprite_index = global.sprNeon;
		
		 // Vars:
		mask_index = mskPlasma;
		friction = 0.2;
		damage = 2;
		force = 2;
		typ = 0;
		child = noone;
		parent = noone;
		
		 // Events:
		on_end_step = script_ref_create(Neon_end_step);
		on_hit = script_ref_create(Neon_hit);
		on_wall = script_ref_create(Neon_wall);
		
		return self;
	}
	
#define Neon_end_step
	if(!instance_exists(child)){
		var _inst = instances_matching_le(instances_matching(object_index, "name", name), "id", id),
			_cx = 0,
			_cy = 0;
			
		with(_inst){
			if(!instance_exists(parent)){
				_inst = instances_matching_ge(_inst, "id", id);
				break;
			}
		}
		
		var _num = array_length(_inst);
			
		with(_inst){
			_cx += x;
			_cy += y;
		}
		
		_cx /= _num;
		_cy /= _num;
		
		var _ang = 0;
		
		with(_inst){
			_ang += point_direction(_cx, _cy, x, y);
		}
		
		_ang /= _num;
		
		var a = 10,
			b = floor(_num / -2) * a;
			
		with(_inst){
			x += lengthdir_x(b, _ang);
			y += lengthdir_y(b, _ang);
			
			b += a;
		}
	}
	
#define Neon_hit
	if(projectile_canhit_melee(other)){
		projectile_hit_push(other, damage, force);
	}
	
#define Neon_wall
	move_bounce_solid(false);
	speed *= 4/3;
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);