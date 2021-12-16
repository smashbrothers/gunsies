#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprMillipedeGun.png", 11, 8);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "MILLIPEDE GUN";
#define weapon_text return "MECHANICAL TERROR";
#define weapon_type return 3; // Bolt
#define weapon_cost return 4;
#define weapon_load return 15;
#define weapon_area return -1;
#define weapon_auto return true;
#define weapon_swap return sndSwapBow;
#define weapon_burst return 5;
#define weapon_burst_time return 3;

#define weapon_fire(_wep)
	
	var _inst = instances_matching_gt(instances_matching(instances_matching(CustomProjectile, "name", "Millipede"), "creator", self), "time", 0);
	with(obj_create(x, y, "Millipede")){
		creator = other;
		team = other.team;
		
		time = weapon_burst_time() + 1;
		
		direction = other.gunangle + (other.accuracy * orandom(16));
		speed = 8;
		
		move_contact_solid(direction, speed);
		
		if(array_length(_inst)){
			sprite_index = spr_tail;
			
			with(_inst){
				
				 // Segment Setup:
				child		 = other;
				child.parent = self;
				
				if(instance_exists(parent)){
					sprite_index = spr_body;
				}
				
				var _inst = self;
				while(instance_exists(_inst)){
					with(_inst){
						
						 // Pull Segments Back:
						var _max = seg_dis,
							_dis = point_distance(x, y, child.x, child.y);
							
						if(_dis > _max){
							var l = _dis - _max,
								d = point_direction(x, y, child.x, child.y);
								
							x += lengthdir_x(l, d);
							y += lengthdir_y(l, d);
							
							child.direction = point_direction(child.x, child.y, x, y);
						}
						
						_inst = parent;
					}
				}
				
				break;
			}
		}
		
		image_angle = direction;
	}
	
	 // Game Feel:
	weapon_post(13, -7, 13);
	motion_add(gunangle, 3);
	
	 // Sounds:
	var _snd = sound_play_pitchvol(sndSodaMachineBreak, random_range(0.6, 0.8), 1.2);
	audio_sound_set_track_position(_snd, 0.1);
	audio_sound_gain(_snd, 0, 650);
	
	var _snd = sound_play_pitchvol(sndNothingHurtMid, random_range(0.6, 0.8), 0.8);
	audio_sound_set_track_position(_snd, 0.1);
	audio_sound_gain(_snd, 0, 400);
	
	sound_play_pitchvol(sndSnowTankShoot, random_range(0.7, 0.9), 0.6);
	sound_play_pitchvol(sndSuperCrossbow, random_range(0.6, 0.8), 0.8);
	
	var _snd = sound_play_gun(sndSeekerShotgun, 0, -0.5);
	audio_sound_set_track_position(_snd, 0.2);
	audio_sound_pitch(_snd, random_range(0.6, 0.8));
	
     // Burst:
    if(array_find_index(instances_matching(CustomObject, "name", "WeaponBurst"), other) < 0){
        with(obj_create(x, y, "WeaponBurst")){
            accuracy = other.accuracy;
            creator  = other;
            team     = other.team;
            spec     = other.specfiring;
            wep      = _wep;
            ammo     = weapon_burst() - 1;
            time_max = weapon_burst_time();
            time     = time_max;
        }
    }
	
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);