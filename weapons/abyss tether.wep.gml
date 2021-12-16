#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprAbyssTether.png", 14, 6);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "ABYSS TETHER";
#define weapon_text return "CATCH OF THE DAY";
#define weapon_type return 5; // Energy
#define weapon_cost return 1;
#define weapon_load return 6;
#define weapon_area return -1;
#define weapon_auto return true;
#define weapon_swap return sndSwapEnergy;

#define step
	if(button_pressed(index, "horn")){
		with(instances_matching(CustomObject, "name", "Coelacanth")){
			instance_destroy();
		}
		
		var _last = noone;
		for(var i = 0; i < 4; i++){
			with(obj_create(mouse_x[index], mouse_y[index], "Coelacanth")){
				sprite_index = sprite_list[i];
				
				var _scale = (skill_get(mut_laser_brain) / 3) + 1;
				image_xscale = _scale;
				image_yscale = _scale;
				
				if(_last == noone){
					head = true;
					alarm0 = 90;
				}
				
				parent = _last;
				with(parent){
					child = other;
				}
				_last = self;
			}
		}
	}

#define weapon_fire(_wep)
	var _inst = instances_matching(instances_matching(CustomProjectile, "name", "Tether"), "creator", self);
	if(array_length(_inst) <= 0){
		var _skill = skill_get(mut_laser_brain);
		
		 // Create Tether:
		_inst = obj_create(x, y, "Tether");
		with(_inst){
			creator = other;
			team = other.team;
			
			 // Target:
			var _head = instances_matching(instances_matching(CustomObject, "name", "Coelacanth"), "head", true),
				_dmax = 1/0,
				_near = noone,
				_mx   = mouse_x[other.index],
				_my   = mouse_y[other.index];
			
			with(_head){
				var _mdis = point_distance(x, y, _mx, _my);
				if(_mdis < _dmax){
					_dmax = _mdis;
					_near = self;
				}
			}
			
			target = _near;
			
			var _scale = (_skill / 3) + 1;
			image_xscale = _scale;
			image_yscale = _scale;
		}
		
		 // Sounds:
		 // oasis explosion small / large
		if(_skill > 0){
			// sound_play_pitch(sndOasisPortal, 0.8);
			sound_play_pitchvol(sndPlasmaBigExplodeUpg, 0.8, 1);
			sound_play_pitchvol(sndNothing2Ball, 0.8, 0.7);
		}
		else{
			// sound_play_pitch(sndOasisExplosionSmall, 0.8);
			sound_play_pitchvol(sndPlasmaBigExplode, 0.8, 0.6);
			sound_play_pitchvol(sndNothing2Ball, 1, 0.7);
		}
		
		weapon_post(0, 6, 12);
	}
	
	 // Continue Tether:
	with(_inst){
		timer += weapon_get_load(mod_current);
	}
	
	 // Game Feel:
	weapon_post(7, 0, 3);
	sleep(20);
	
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);