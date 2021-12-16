#define init
	var m = "../sprites/",
		p = m;
		
	p = m + "weapons/";
    global.sprWep = sprite_add_weapon(p + "sprMegaDiscGun.png", 5, 12);
    
    p = m + "projectiles/";
    
    var _path = p + "sprMegaDisc.png";
    global.sprMegaDisc = sprite_add(_path, 1, 5, 5);
    global.sprMegaDiscDeathCause = noone;
    
    if(fork()){
    	
    	 // Ensure Sprite is Loaded:
    	file_load(_path);
    	while(!file_loaded(_path)){
    		wait(0);
    	}
    	file_unload(_path);
    	
    	 // Drawing:
    	var _sn   = 64,
    		_sw   = 64,
    		_sh   = 64,
    		_surf = surface_create(_sw * _sn, _sh);
    	
	    surface_set_target(_surf);
	    draw_clear_alpha(0, 0);
	    
	    with(MegaDisc_create(_sw / 2, _sh / 2)){
	    	image_xscale = 0.6;
	    	image_yscale = 0.6;
	    	
	    	
	    	repeat(_sn){
		    	event_perform(ev_draw, 0);
	    		
	    		image_angle -= (360 / _sn);
	    		x += _sw;
	    	}
	    	
	    	instance_delete(self);
	    }
	    
	    surface_reset_target();
	    
	     // Save and Load:
	    var _save = "sprMegaDiscDeathCause.png";
	    surface_save(_surf, _save);
	    
	    global.sprMegaDiscDeathCause = sprite_add(_save, _sn, _sw / 2, _sh / 2);
	    
	    surface_destroy(_surf);
    }
    
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "REAVER";
#define weapon_text return "";
#define weapon_type return 3; // Bolt
#define weapon_cost return 2;
#define weapon_load return 16;
#define weapon_area return 10; // 5-2
#define weapon_auto return true;
#define weapon_swap return sndSwapBow;

#define weapon_reloaded
	if(!button_check(index, "fire")){
		sound_play(sndCrossReload);
	}

#define weapon_fire(_wep)
	
	var _inst = instances_matching_lt(instances_matching_gt(instances_matching(instances_matching(CustomProjectile, "name", "MegaDisc"), "creator", self), "time", 0), "tier", 4);
	if(!array_length(_inst)){
		with(MegaDisc_create(x, y)){
			creator = other;
			team = other.team;
			
			direction = other.gunangle;
			speed = maxspeed;
			
			_inst = self;
		}
		
		 // Game Feel:
		weapon_post(12, 6, 24);
		sleep(60);
		
		sound_play(sndDiscgun);
	}
	
	with(_inst){
		time = weapon_get_load(mod_current) + 1;
		tier++;
		
		var _scale = 1/20;
		image_xscale += _scale;
		image_yscale += _scale;
		
		grow_speed += 1/35;
	}
	
	audio_sound_set_track_position(sound_play(sndDiscHit), 0.2);
	
#define MegaDisc_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "MegaDisc";
		
		 // Visual:
		sprite_index = global.sprMegaDisc;
		var _scale = 1/5;
		image_xscale = _scale;
		image_yscale = _scale;
		hitid = [global.sprMegaDiscDeathCause, "MEGA DISC"];
		
		 // Vars:
		mask_index = mskShield;
		friction = 0.5;
		angle_speed = 10;
		grow_speed = 0;
		damage = 50;
		force = 5;
		typ = 1;
		time = 1;
		flash = 0;
		minspeed = 4;
		maxspeed = 12;
		tier = 0;
		
		 // Alarms:
		alarm0 = -1;
		
		 // Events:
		on_step = script_ref_create(MegaDisc_step);
		on_end_step = script_ref_create(MegaDisc_end_step);
		on_draw = script_ref_create(MegaDisc_draw);
		on_wall = script_ref_create(MegaDisc_wall);
		on_hit = script_ref_create(MegaDisc_hit);
		on_alrm0 = script_ref_create(MegaDisc_alrm0);
		
		return self;
	}
	
#define MegaDisc_step
	 // Run Alarms:
	if(alarm0 >= 0 && --alarm0 == 0 && (script_ref_call(on_alrm0) || !instance_exists(self))) exit;

	angle_speed = min(angle_speed + (current_time_scale / 4), 10);
	image_angle -= (current_time_scale * angle_speed);
	
	flash -= current_time_scale;

	if(time > 0){
		var _scale = current_time_scale * grow_speed;
		image_xscale += _scale;
		image_yscale += _scale;
		
		grow_speed = lerp(0, grow_speed, power(6/7, current_time_scale));
		time -= current_time_scale;
		
		if(instance_exists(creator)){
			x = creator.x + creator.hspeed_raw - hspeed_raw;
			y = creator.y + creator.vspeed_raw - vspeed_raw;
			
			speed_raw += friction_raw;
			
			direction = creator.gunangle;
			creator.wkick = max(creator.wkick, 7);
			
			var _off = ((image_xscale + image_yscale) / 2) * 48;
			x += lengthdir_x(_off, direction);
			y += lengthdir_y(_off, direction);
			
			if(time <= 0){
				
				with(creator){
					motion_set(gunangle + 180, 4);
				}
				
				x += hspeed_raw;
				y += vspeed_raw;
				
				alarm0 = 10;
				flash = 2;
				
				view_shake_at(x, y, 20);
				sleep(20);
				
				sound_play(sndSuperDiscGun);
			}
		}
	}
	
	speed = clamp(speed, minspeed, maxspeed);
	
	 // Destroy:
	var _minScale = 1/6;
	if(image_xscale < _minScale || image_yscale < _minScale){
		instance_destroy();
	}
	
#define MegaDisc_end_step
	 // Trail:
	if(time <= 0 && (current_frame % 2) < current_time_scale){
		var s = (image_xscale + image_yscale) / 2,
			o = 360 / round((s * 64 * pi) / 5),
			w = max(lerp(s, 2, 1/3), 4/3),
			r = s * 32;
			
		for(var i = 0; i < 360; i += o){
			var _nx = x + lengthdir_x(r, i + o),
				_ny = y + lengthdir_y(r, i + o);
			
			with(instance_create(x + lengthdir_x(r, i), y + lengthdir_y(r, i), BoltTrail)){
				image_angle = point_direction(x, y, _nx, _ny);
				image_xscale = point_distance(x, y, _nx, _ny);
				image_yscale = w;
			}
		}
	}
	
#define MegaDisc_draw
	if(flash > 0){
		draw_set_fog(true, image_blend, 0, 0);
	}

	var _lx  = image_xscale * sprite_get_width(mask_index)  / 2,
		_ly  = image_yscale * sprite_get_height(mask_index) / 2,
		_sw  = sprite_get_width(sprite_index),
		_sxo = sprite_get_xoffset(sprite_index),
		_lx1 = _lx  - _sxo,
		_ly1 = _ly  - _sxo,
		_lx2 = _lx1 + _sw,
		_ly2 = _ly1 + _sw,
		_dir = image_angle,
		_num = round((2 * pi * ((_lx + _ly) / 2)) / sprite_get_height(sprite_index));
		
	 // Set Initial Points:
	var _o  = (360 / _num),
		_x1 = x + lengthdir_x(_lx1, _dir),
		_y1 = y + lengthdir_y(_ly1, _dir),
		_x2 = x + lengthdir_x(_lx2, _dir),
		_y2 = y + lengthdir_y(_ly2, _dir),
		_x3 = 0,
		_y3 = 0,
		_x4 = 0,
		_y4 = 0;
		
	repeat(_num){
		_dir += _o;
		
		 // Increment Points:
		_x3 = _x2;
		_y3 = _y2;
		_x4 = _x1;
		_y4 = _y1;
		
		_x1 = x + lengthdir_x(_lx1, _dir);
		_y1 = y + lengthdir_y(_ly1, _dir);
		_x2 = x + lengthdir_x(_lx2, _dir);
		_y2 = y + lengthdir_y(_ly2, _dir);
			
		draw_sprite_pos(sprite_index, image_index, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4, image_alpha);
	}
	
	if(flash > 0){
		draw_set_fog(false, c_white, 0, 0);
	}
	
#define MegaDisc_wall
	if(time <= 0 && !array_length(instances_meeting(x, y, instances_matching(Floor, "mask_index", mskFloor)))){
		move_bounce_solid(false);
		speed += 4;
	}

	with(other){
		instance_create(x, y, FloorExplo);
		instance_destroy();
	}
	
	var _scale = 1/30;
	image_xscale -= _scale;
	image_yscale -= _scale;
    
#define MegaDisc_hit
	if(projectile_canhit_melee(other)){
		projectile_hit_push(other, damage, force);
	}
	
#define MegaDisc_alrm0
	if(!place_meeting(x, y, creator)){
		team = -1;
	}
	else{
		alarm0 = 1;
	}
	
#define instances_meeting(_x, _y, _obj)
	/*
		Returns all given instances that would be touching the calling instance at a given position
		Much better performance than manually performing "place_meeting(x, y, other)" with every instance
	*/
	
	var	_tx = x,
		_ty = y;
		
	x = _x;
	y = _y;
	var r = instances_matching_ne(instances_matching_le(instances_matching_ge(instances_matching_le(instances_matching_ge(_obj, "bbox_right", bbox_left), "bbox_left", bbox_right), "bbox_bottom", bbox_top), "bbox_top", bbox_bottom), "id", id);
	x = _tx;
	y = _ty;
	
	return r;
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);