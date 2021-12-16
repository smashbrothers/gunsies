#define init
	var m = "../sprites/",
		p = m;
		
	p = m + "weapons/";
    global.sprWep = sprite_add_weapon(p + "sprBouncyLaser.png", 4, 6);
    
    p = m + "projectiles/";
    global.sprBouncyLaser = sprite_add(p + "sprBouncyLaser.png", 1, 1, 4);
    global.sprBouncyLaserStart = sprite_add(p + "sprBouncyLaserStart.png", 1, 24, 12);
    global.sprBouncyLaserEnd = sprite_add(p + "sprBouncyLaserEnd.png", 1, 0, 12);
    
	var _path = p + "mskBouncyLaser.png";
	global.mskBouncyLaser = sprite_add(_path, 1, 1, 4);
	
	if(fork()){
		file_load(_path);
		while(!file_loaded(_path)){
			wait(0);
		}
		file_unload(_path);
		
		sprite_collision_mask(global.mskBouncyLaser, false, 0, 0, 0, 0, 0, 0, 0);
		
		exit;
	}

#define weapon_sprt return global.sprWep;
#define weapon_name return "KRYPTON BEAMER";
#define weapon_text return "";
#define weapon_type return 5; // Energy
#define weapon_cost return 4;
#define weapon_load return 12;
#define weapon_area return -1;
// #define weapon_auto return true;
#define weapon_swap return sndSwapEnergy;

#define weapon_fire(_wep)
	var _skill = skill_get(mut_laser_brain);
	
	/*
	var _inst = instances_matching(instances_matching(instances_matching(CustomProjectile, "name", "BouncyLaser"), "creator", self), "parent", noone),
		_ammo = 2 + ceil(_skill);
	
	if(!array_length(_inst)){
		_ammo--;
		
		with(BouncyLaser_create(x, y)){
			creator = other;
			team = other.team;
			
			target = other;
			
			image_angle  = other.gunangle;	
			
			_inst = self;
		}
	}
	
	with(_inst){
		if(_ammo > 0){
			ammo = _ammo;
			_ammo = 0;
		}
	}
	*/
	
	with(BouncyLaser_create(x, y)){
		creator = other;
		team = other.team;
		
		target = other;
		ammo = 2;
		
		shake *= other.accuracy;
		image_angle  = other.gunangle + (other.accuracy * orandom(4));	
	}
	
	weapon_post(8, 4, 12);
	motion_add(gunangle + 180, 3);
	sleep(55);
	
	audio_sound_set_track_position(sound_play_pitch(sndEliteInspectorFire, 1), 0.278);
	audio_sound_set_track_position(sound_play_pitchvol(sndPlasmaBigUpg, 0.8, 0.6), 0.45);
	sound_play_gun(sndLaserCannon, 0.3, 0.3);
	
	
#define BouncyLaser_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "BouncyLaser";
		
		 // Visual:
		sprite_index = global.sprBouncyLaser;
		image_yscale = lerp(1, 1.4, skill_get(mut_laser_brain));
		
		 // Vars:
		mask_index = global.mskBouncyLaser;
		damage = 2;
		force = 2;
		typ = 2;
		ammo = 0;
		target = noone;
		time = 24;
		child = noone;
		parent = noone;
		end_x = x;
		end_y = y;
		shake = 7;
		home = noone;
		
		 // Events:
		on_step = script_ref_create(BouncyLaser_step);
		on_draw = script_ref_create(BouncyLaser_draw);
		on_hit = script_ref_create(BouncyLaser_hit);
		on_wall = script_ref_create(BouncyLaser_wall);
		
		return self;
	}
	
#define BouncyLaser_step
	
	var _yscale = image_yscale;
	image_yscale = 1;
	image_xscale = 1;
	
	 // Angle:
	if(instance_exists(target)){
		image_angle = (parent == noone) ? (target.gunangle + (angle_difference(image_angle, target.gunangle) * power(1 - 1/40, current_time_scale))) : target.image_angle;
		
		x = target.x + target.hspeed_raw;
		y = target.y + target.vspeed_raw;
		
		 // Bounce off Walls:
		if(parent != noone){
			var h =  dcos(image_angle),
				v = -dsin(image_angle);
				
			if(place_meeting(x + h, y, Wall)){
				h *= -1;
			}
			
			if(place_meeting(x, y + v, Wall)){
				v *= -1;
			}
			
			image_angle = point_direction(0, 0, h, v);
		}
		
		 // Home on Hit Enemy:
		if(instance_exists(home) && !collision_line(x	, y, home.x, home.y, Wall, false, false)){
			var _angle = point_direction(x, y, home.x, home.y);
			if(parent == noone){
				image_angle = _angle + (angle_difference(image_angle, _angle) * power(3/4, current_time_scale));
			}
			else{
				image_angle += angle_difference(_angle, image_angle) * 1/4;
			}
		}
		
		 // Offset:
		if(parent == noone){
			image_angle += random_range(-shake, shake);
			move_contact_solid(image_angle, (_yscale * 16));
		}
	}
	
	shake = max(shake - current_time_scale, 0);
	
	end_x = x;
	end_y = y;
	
	 // Hitscan:
	move_outside_solid(image_angle, 8);
	move_contact_solid(image_angle, 800);
	
	xprevious = x;
	yprevious = y;
	
	image_yscale = _yscale;
	image_xscale = point_distance(end_x, end_y, x, y);
	
	 // Enemy Collision:
	if(place_meeting(x, y, enemy)){
		while(place_meeting(x, y, enemy)){
			image_xscale /= 2;
			
			x -= (x - end_x) / 2;
			y -= (y - end_y) / 2;
		}
		
		var _num  = 2,
			_addx = lengthdir_x(_num, image_angle),
			_addy = lengthdir_y(_num, image_angle);
			
		while(!place_meeting(x, y, enemy)){
			image_xscale += _num;
			x += _addx;
			y += _addy;
		}
	}
	
	 // Create Child Laser:
	while(ammo > 0){
		ammo--;
		
		 // Search for Existing Child Lasers:
		var _inst = child;
		if(instance_exists(_inst)){
			while(instance_exists(_inst.child)){
				_inst = _inst.child;
			}
			_inst.ammo += ammo;
		}
		else{
			
			 // New Child Laser:
			with(BouncyLaser_create(x, y)){
				creator = other.creator;
				team = other.team;
				
				target = other;
				ammo = other.ammo;
				
				parent = other;
				other.child = self;
				
				script_ref_call(on_step);
			}
		}
		
		ammo = 0;
	}
	
	 // Effects:
	if(random(3) < current_time_scale){
		with(instance_create(x + orandom(3), y + orandom(3), PlasmaTrail)){
			sprite_index = sprPopoPlasmaTrail;
		}
	}

	 // Death:	
	time -= current_time_scale;
	if(time <= 0){
		
		image_yscale -= current_time_scale / 8;
		if(image_yscale <= 0){
			instance_destroy();
		}
	}
	
#define BouncyLaser_draw
	draw_self();
	if(parent == noone){
		draw_sprite_ext(global.sprBouncyLaserStart, image_index, end_x, end_y, image_yscale, image_yscale, image_angle, image_blend, image_alpha);
	}
	if(child == noone){
		draw_sprite_ext(global.sprBouncyLaserEnd, image_index, x, y, image_yscale, image_yscale, image_angle, image_blend, image_alpha);
	}
	
#define BouncyLaser_hit
	if(projectile_canhit(other)){
		projectile_hit(other, (damage * current_time_scale), force, image_angle);
		
		 // Set Homing Target:
		if(instance_is(other, enemy)){
			home = other;
		}
	}
	
#define BouncyLaser_wall
	
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);