#define init
	 // Sprites:
	var m = "sprites/",
		p = m;
	
		 // Projectiles:
		p = m + "projectiles/";
			
			 // Anchor:
			global.sprAnchor = sprite_add(p + "sprAnchor.png", 7, 4, 12);
			
			 // Beetles:
			global.sprBeetle = sprite_add(p + "sprBeetle.png", 3, 12, 12);
			global.sprBeetleStick = sprite_add(p + "sprBeetleStick.png", 1, 12, 12);
			
			 // Bendy Laser:
			global.sprBendyLaser = sprite_add(p + "sprBendyLaser.png", 2, 0, 3);
			global.sprBendyLaserJoint = sprite_add(p + "sprBendyLaserJoint.png", 1, 3, 3);
			 
			var _path = p + "mskBendyLaser.png";
			global.mskBendyLaser = sprite_add(_path, 1, 0, 3);
			
			if(fork()){
				file_load(_path);
				while(!file_loaded(_path)){
					wait(0);
				}
				file_unload(_path);
				
				sprite_collision_mask(global.mskBendyLaser, false, 0, 0, 0, 0, 0, 0, 0);
				
				exit;
			}
			
			 // Coelacanth:
			global.sprCoelacanth1 = sprite_add(p + "sprCoelacanth1.png", 1, 32, 32);
			global.sprCoelacanth2 = sprite_add(p + "sprCoelacanth2.png", 1, 32, 32);
			global.sprCoelacanth3 = sprite_add(p + "sprCoelacanth3.png", 1, 32, 32);
			global.sprCoelacanth4 = sprite_add(p + "sprCoelacanth4.png", 1, 32, 32);
			
			 // Destroyer:
			global.sprDestroyerHead = sprite_add(p + "sprDestroyerHead.png", 3, 16, 16);
			global.sprDestroyerBody = sprite_add(p + "sprDestroyerBody.png", 7, 16, 16);
			global.sprDestroyerTail = sprite_add(p + "sprDestroyerTail.png", 3, 16, 16);	
			
			 // Millipede:
			global.sprMillipedeHead = sprite_add(p + "sprMillipedeHead.png", 3, 16, 16);
			global.sprMillipedeBody = sprite_add(p + "sprMillipedeBody.png", 3, 16, 16);
			global.sprMillipedeTail = sprite_add(p + "sprMillipedeTail.png", 3, 16, 16);
		 
			 // Piercer Bullets:
			global.sprPiercerBullet = sprite_add(p + "sprPiercerBullet.png", 2, 10, 10);
			
			 // Seed:
			global.sprSeed = sprite_add(p + "sprSeed.png", 2, 8, 8);
			
			 // Syringes:
			global.sprSyringe = sprite_add(p + "sprSyringe.png", 2, 8, 8);
			
			 // Tether:
			global.sprTether = sprite_add(p + "sprTether.png", 4, 12, 12);
			
			 // Vine:
			global.sprVine	    = sprite_add(p + "sprVine.png",		 3, 0, 8);
			global.sprVineStart = sprite_add(p + "sprVineStart.png", 3, 0, 8);
			global.sprVineEnd   = sprite_add(p + "sprVineEnd.png",	 3, 0, 8);
			
			var _path = p + "mskVine.png";
			global.mskVine = sprite_add(_path, 1, 0, 8);
			
			if(fork()){
				file_load(_path);
				while(!file_loaded(_path)){
					wait(0);
				}
				file_unload(_path);
				
				sprite_collision_mask(global.mskVine, false, 0, 0, 0, 0, 0, 0, 0);
				
				exit;
			}
			
			 // Warp Bullets:
			global.sprWarpBullet = sprite_add(p + "sprWarpBullet.png", 3, 10, 10);
			
		 // Effects:
		p = m + "effects/";
			
			 // Anchor:
			global.sprAnchorTrail = sprite_add(p + "sprAnchorTrail.png", 2, 4, 4);
			
			 // Millipede:
			global.sprMillipedeDisappear = sprite_add(p + "sprMillipedeDisappear.png", 4, 16, 16);
			
			 // Piercer Bullet:
			global.sprPiercerShell = sprite_add(p + "sprPiercerShell.png", 1, 1, 3);
			global.sprPiercerBulletHit = sprite_add(p + "sprPiercerBulletHit.png", 4, 10, 10);
			global.sprPiercerBulletPierce = sprite_add(p + "sprPiercerBulletPierce.png", 4, 10, 10);
			
			 // Syringe:
			global.sprSyringeDamage = sprite_add(p + "sprSyringeDamage.png", 8, 16, 32);
			
			 // Tether:
			global.sprTetherDisappear = sprite_add(p + "sprTetherDisappear.png", 4, 12, 12);
			global.sprTetherTrail = sprite_add(p + "sprTetherTrail.png", 4, 4, 4);
			global.sprTetherEnd = sprite_add(p + "sprTetherEnd.png", 4, 16, 16);
			
			 // Vine:
			global.sprVineLeaf = sprite_add(p + "sprVineLeaf.png", 3, 16, 16);
			global.sprVineSparkle = sprite_add(p + "sprVineSparkle.png", 4, 8, 8);
			
			 // Warp Bullet:
			global.sprWarpShell = sprite_add(p + "sprWarpShell.png", 1, 1, 2);
			global.sprWarpBulletHit = sprite_add(p + "sprWarpBulletHit.png", 4, 10, 10);
			global.sprWarpBulletAppear = sprite_add(p + "sprWarpBulletAppear.png", 4, 10, 10);
			global.sprWarpBulletDisappear = sprite_add(p + "sprWarpBulletDisappear.png", 4, 10, 10);
			global.sprWarpBulletTrail = sprite_add(p + "sprWarpBulletTrail.png", 4, 4, 4);
			
	 // Globals:
	global.coelacanth_bloom = noone;
			
			
	 // Mod Type:
	mod_current_type = script_ref_create(0)[0];
			
#macro mod_current_type global.mod_current_type

#define cleanup
	with(global.coelacanth_bloom){
		instance_destroy();
	}
			
#define obj_create(_x, _y, _name)
	 // Vanilla Objects:
	if(is_real(_name)){
		if(object_exists(_name)){
			return instance_create(_x, _y, _name);
		}
	}
	else{
	
		 // Custom Objects:
		var _script = `${_name}_create`;
		if(mod_script_exists(mod_current_type, mod_current, _script)){
			return mod_script_call(mod_current_type, mod_current, _script, _x, _y);
		}
	}
	
	 // Compile Object List:
	var a = [];
	for(var i = 1; true; i++){
		var r = script_get_name(i);
		
		if(is_undefined(r)){
			return a;
		}
		
		var n = string_copy(r, 1, string_length(r) - 7);
		if(string_delete(r, 1, string_length(n)) == "_create"){
			
			array_push(a, n);
		}
	}
	
#define Anchor_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "Anchor";
		
		 // Visual:
		sprite_index = global.sprAnchor;
		image_speed = 0.4;
		image_index = 1 - image_speed;
		
		 // Vars:
		mask_index = mskBolt;
		damage = 60;
		force = 12;
		typ = 2;
		canhurt = true;
		hit = [];
		wave = random(90);
		
		 // Mod Compat:
		ammo_type = 3;
		is_bolt = true;
		
		 // Alarms:
		alarm1 = -1;
		
		 // Events:
		on_step = script_ref_create(Anchor_step);
		on_end_step = script_ref_create(Anchor_end_step);
		on_anim = script_ref_create(Anchor_anim);
		on_hit = script_ref_create(Anchor_hit);
		on_wall = script_ref_create(Anchor_wall);
		on_alrm1 = script_ref_create(Anchor_alrm1);
		
		return self;
	}
	
#define Anchor_step
	 // Run Alarms:
	if(alarm1 >= 0 && --alarm1 == 0 && (script_ref_call(on_alrm1) || !instance_exists(self))) exit;
	
	wave += current_time_scale;
	
	 // Seeking:
	var _skill = skill_get(mut_bolt_marrow);
	if(canhurt && _skill > 0 && instance_exists(enemy)){
		
		var n = instance_nearest(x, y, enemy);
		if(point_distance(x, y, n.x, n.y) < (16 * _skill)){
			x = n.x - hspeed_raw;
			y = n.y - vspeed_raw;
		}
	}
	
#define Anchor_end_step
	 // Trail:
	if(canhurt){
		var _x = xprevious,
			_y = yprevious,
			_len = 7,
			_frm = true;
			
		while(point_distance(_x, _y, x, y) > _len){
			var _dir = point_direction(_x, _y, x, y);
			
			with(instance_create(_x, _y, BoltTrail)){
				sprite_index = global.sprAnchorTrail;
				image_angle = _dir;
				image_index = _frm;
				_frm = !_frm;
			}
			
			_x += lengthdir_x(_len, _dir);
			_y += lengthdir_y(_len, _dir);
		}
	}
	/*
	if(canhurt){
		var _dis = point_distance(x, y, xprevious, yprevious),
			_dir = point_direction(x, y, xprevious, yprevious);
			
		with(instance_create(x, y, BoltTrail)){
			image_xscale = _dis;
			image_angle  = _dir;
		}
	}
	*/
	
#define Anchor_anim
	image_index += 1;
	
#define Anchor_hit
	if(canhurt && projectile_canhit(other)){
		if(array_find_index(hit, other) < 0 || place_meeting(x, y, Wall) || place_meeting(x + hspeed_raw, y + vspeed_raw, Wall)){
			projectile_hit(other, damage, force, direction);
			
			array_push(hit, other);
			sleep(20 + (10 * other.size));
		}
		
		 // Drag:
		if(other.my_health > 0){
			with(other){
				move_contact_solid(other.direction, other.speed);
				instance_create(x, y, Dust);
			}
		}
	}
	
#define Anchor_wall
	if(canhurt){
		canhurt = false;
		alarm1 = 30;
		
		// image_index = 1;
		image_speed = 0;
		
		// x += hspeed;
		// y += vspeed;
		// xprevious = x;
		// yprevious = y;
		
		speed = 0;
		
		instance_create(x, y, Dust);
		sound_play_pitch(sndBoltHitWall, random_range(0.7, 0.9));
		
		view_shake_at(x, y, 7);
	}
	
#define Anchor_alrm1
	instance_destroy();

#define Beetle_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "Beetle";
		
		 // Visual:
		sprite_index = global.sprBeetle;
		
		 // Vars:
		mask_index = mskSeeker;
		damage = 9;
		force = 4;
		typ = 2;
		wave = random(90);
		color = make_color_rgb(206, 194, 194);
		canhurt = true;
		wallbounce = 3;
		target = noone;
		blink = 20;
		
		 // Mod Compat:
		ammo_type = 3;
		is_bolt = true;
		
		 // Alarms:
		alarm0 = 120;
		alarm1 = -1;
		
		 // Events:
		on_step = script_ref_create(Beetle_step);
		on_end_step = script_ref_create(Beetle_end_step);
		on_wall = script_ref_create(Beetle_wall);
		on_hit = script_ref_create(Beetle_hit);
		on_anim = script_ref_create(Beetle_anim);
		on_alrm0 = script_ref_create(Beetle_alrm0);
		on_alrm1 = script_ref_create(Beetle_alrm1);
		
		return self;
	}
	
#define Beetle_step
	 // Run Alarms:
	if(alarm0 >= 0 && --alarm0 == 0 && (script_ref_call(on_alrm0) || !instance_exists(self))) exit;
	if(alarm1 >= 0 && --alarm1 == 0 && (script_ref_call(on_alrm1) || !instance_exists(self))) exit;
	
	wave += current_time_scale;

	 // Seek Cursor:
	if(canhurt){
		var _gx = null,
			_gy = null,
			_sc = 1/5;
			
		 // Prioritize Targeted Enemies:
		if(instance_exists(target)){
			_gx = target.x;
			_gy = target.y;
		}
		else{
			if(instance_exists(creator)){
				
				 // Find Creator Goal:
				if("index" in creator){
					_gx = mouse_x[creator.index];
					_gy = mouse_y[creator.index];					
				}
				else{
					_gx = x;
					_gy = y;
				}
			
				 // Seek Enemies:
				var _skill = skill_get(mut_bolt_marrow);	
				if(_skill > 0 && instance_exists(enemy)){
					var _near = instance_nearest(_gx, _gy, enemy);
					if(point_distance(x, y, _gx, _gy) < 64 && point_distance(x, y, _near.x, _near.y) < (64 * _skill)){
						
						target = _near;
						_gx = _near.x;
						_gy = _near.y;
						
						_sc = 1/3;
					}
				}
			}
		}
		
		 // Seek:
		if(_gx != null && _gy != null){
			var _gd = point_direction(x, y, _gx, _gy) + sin(wave / 10) * 30;
			direction = _gd + (angle_difference(direction, _gd) * power(1 - _sc, current_time_scale));
			image_angle = direction;
		}
	}
	
#define Beetle_end_step
	 // Trail:
	if(canhurt){
		var _dis = point_distance(x, y, xprevious, yprevious),
			_dir = point_direction(x, y, xprevious, yprevious);
			
		with(instance_create(x, y, BoltTrail)){
			image_xscale = _dis;
			image_angle  = _dir;
			image_blend  = other.color;
		}
	}
	
#define Beetle_wall
	if(canhurt){
		if(wallbounce-- > 0){
			move_bounce_solid(false);
			instance_create(x, y, Dust);
		}
		else{
			canhurt = false;
			alarm1 = 30;
			
			sprite_index = global.sprBeetleStick;
			
			with(instance_create(x, y, BoltTrail)){
				image_xscale = other.speed;
				image_angle  = other.image_angle;
				image_blend  = other.color;
			}
			
			x += hspeed;
			y += vspeed;
			xprevious = x;
			yprevious = y;
			
			instance_create(x, y, Dust);
			
			sound_play_pitch(sndBoltHitWall, random_range(1, 1.2));
			
			var _snd = sound_play_pitchvol(sndNothingHurtMid, random_range(1.3, 1.5), 0.7);
			audio_sound_set_track_position(_snd, 0.2);
			audio_sound_gain(_snd, 0, 300);
			
			speed = 0;
		}
	}
	
#define Beetle_hit
	if(canhurt && projectile_canhit(other)){
		projectile_hit(other, damage, force, direction);
		
		 // Destroy:
		if(other.my_health > 0){
			
			 // Stick:
			var _target = other;
			with(instance_create(x, y, BoltStick)){
				sprite_index = global.sprBeetleStick;
				image_angle = other.image_angle;
				target = _target;
			}
			
			 // Goodbye:
			instance_destroy();
		}
	}
	
#define Beetle_anim
	image_index = 1;
	
	
#define Beetle_alrm0
	if(blink-- > 0){
		alarm0  = 3;
		visible = !visible;
	}
	else{
		
		instance_create(x, y, Dust);
		instance_destroy();
	}

#define Beetle_alrm1
	instance_destroy();

#define BendyLaser_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "BendyLaser";
		
		 // Visual:
		sprite_index = global.sprBendyLaser;
		
		 // Vars:
		mask_index = global.mskBendyLaser;
		damage = 2;
		force = 2;
		typ = 0;
		target = noone;
		
		 // Mod Compat:
		ammo_type = 5;
		is_laser = true;
		
		 // Alarms:
		alarm0 = 3;
		
		 // Events:
		on_step = script_ref_create(BendyLaser_step);
		on_end_step = script_ref_create(BendyLaser_end_step);
		on_draw = script_ref_create(Bendylaser_draw);
		on_hit = script_ref_create(BendyLaser_hit);
		on_wall = script_ref_create(BendyLaser_wall);
		on_alrm0 = script_ref_create(BendyLaser_alrm0);
		
		return self;
	}
	
#define BendyLaser_step
	 // Run Alarms:
	if(alarm0 >= 0 && --alarm0 == 0 && (script_ref_call(on_alrm0) || !instance_exists(self))) exit;
	
#define BendyLaser_end_step
	
	 // Stretch:
	if(instance_exists(target)){
		image_angle  = point_direction(x, y, target.x, target.y);
		image_xscale = point_distance(x, y, target.x, target.y);
	}
	
#define Bendylaser_draw
	draw_self();
	
#define BendyLaser_hit
	if(projectile_canhit(other)){
		projectile_hit(other, damage, force, direction);
		
		image_yscale -= (current_time_scale / 10);
	}
	
#define BendyLaser_wall
	
	image_yscale -= (current_time_scale / 10);
	if(image_yscale <= 0){
		instance_destroy();
	}
	
#define BendyLaser_alrm0
	target = noone;
	
#define BendyLaserCont_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "BendyLaserCont";
		
		 // Visual:
		
		 // Vars:
		
		 // Events:
		
		
		return self;
	}

#define Coelacanth_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "Coelacanth";
		
		 // Visual:
		sprite_list = [global.sprCoelacanth1, global.sprCoelacanth2, global.sprCoelacanth3, global.sprCoelacanth4];
		sprite_index = sprite_list[0];
		image_speed	= 0.4;
		depth = -8;
		hitid = [sprite_index, "ABYSS CREATURE"];
		
		 // Vars:
		mask_index = mskExploder;
		direction = 0;//random(360);
		friction = 0.2;
		player_mask = mskSuperFlakBullet;
		player_damage = 2;
		gunangle = direction;
		damage = 6;
		force = 0;
		team = 2;
		parent = noone;
		child = noone;
		target = noone;
		minspeed = 3.2;
		maxspeed = 9.6;
		wave = random(90);
		head = false;
		turn = 0;
		dash = 0;
		slash = [];
		
		 // Alarms:
		alarm0 = -1;
		
		 // Events:
		on_step = script_ref_create(Coelacanth_step);
		on_draw = script_ref_create(Coelacanth_draw);
		on_end_step = script_ref_create(Coelacanth_end_step);
		on_alrm0 = script_ref_create(Coelacanth_alrm0);
		
		return self;
	}
	
#define Coelacanth_step
	 // Run Alarms:
	if(alarm0 >= 0 && --alarm0 == 0 && (script_ref_call(on_alrm0) || !instance_exists(self))) exit;
	
	wave += current_time_scale;
	
	 // Motion:
	if(head){
		direction = gunangle + (sin(current_frame / 10) * 30);
		image_angle = direction;
		
		if(dash > 0){
			dash -= current_time_scale;
			motion_add_ct(gunangle, 0.8);
			
			view_shake_at(x, y, 4);
		}
		
		speed = clamp(speed, minspeed, maxspeed);
	}
	
	 // Slashes:
	if(place_meeting(x, y, projectile)){
		var _inst = instances_matching_le(instances_matching_le(instances_matching_ge(instances_matching_ge(instances_matching_ne([BloodSlash, CustomSlash, EnergyHammerSlash, EnergySlash, GuitarSlash, LightningSlash, Slash], "id", id), "bbox_right", bbox_left), "bbox_bottom", bbox_top), "bbox_left", bbox_right), "bbox_top", bbox_bottom);
		
		if(array_length(_inst)) with(_inst){
			if(array_find_index(other.slash, self) < 0 && place_meeting(x, y, other)){
				other.gunangle = direction;
				other.speed = max(other.speed, speed);
				
				with(instance_create(x, y, Deflect)){
					image_angle = other.direction;
				}
				
				array_push(other.slash, self);
			}
		}
	}
	
	 // Damage Hitmes Indiscriminately:
	if(place_meeting(x, y, hitme)){
		var _inst = instances_meeting(x, y, hitme);
		if(array_length(_inst)) with(_inst){
			if(place_meeting(x, y, other)){
				with(other){
					
					/*
					 // Separate Masks for Players:
					var _meeting = true;
					if(other.team == team){
						var _oldmask = mask_index;
						mask_index = player_mask;
						
						_meeting = place_meeting(x, y, other);
						mask_index = _oldmask;
					}
					*/
					
					 // Hurt:
					if(projectile_canhit_melee(other) || (projectile_canhit(other) && other.team != team)){
						projectile_hit(other, damage, force, direction);
						sleep(4 + (2 * other.size));
					}
				}
			}
		}
	}
	
	 // Bloom Drawing:
	var _depth = (depth - 1);
	if(!instance_exists(global.coelacanth_bloom)){
		global.coelacanth_bloom = script_bind_draw(Coelacanth_draw_bloom, _depth);
	}
	
	 // Always on Top:
	if(global.coelacanth_bloom.depth != _depth){
		global.coelacanth_bloom.depth = _depth;
	}
	
#define Coelacanth_end_step
	
	 // Follow Leader:
	if(!instance_exists(parent)){
		var _inst = child;
		
		 // Iterate Through Segments:
		while(instance_exists(_inst)){
			with(_inst){
				var _max = 24 * image_xscale,
					_dis = point_distance(x, y, parent.x, parent.y),
					_dir = point_direction(x, y, parent.x, parent.y);
					
				if(_dis > _max){
					var _len = _dis - _max;
						
					x += lengthdir_x(_len, _dir);
					y += lengthdir_y(_len, _dir);
				}
					
				direction = _dir;
				image_angle = _dir;
				
				 // Next Segment:
				_inst = child;
			}
		}
	}
	
#define Coelacanth_draw
	var _blend = (instance_is(other, self) ? image_blend : c_black);
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, _blend, image_alpha);
	
#define Coelacanth_draw_bloom
	var _inst = instances_matching(CustomObject, "name", "Coelacanth");
	if(array_length(_inst) > 0){
		
		draw_set_blend_mode(bm_add);
		with(_inst){
			event_perform(ev_draw, 0);
			
			image_xscale *= 2;
			image_yscale *= 2;
			image_alpha  /= 10;
			
			event_perform(ev_draw, 0);
			
			image_xscale /= 2;
			image_yscale /= 2;
			image_alpha  *= 10;
		}
		draw_set_blend_mode(bm_normal);
	}
	else{
		
		 // Goodbye:
		instance_destroy();
	}
	
#define Coelacanth_alrm0
	alarm0 = 40 + random(30);
	target = instance_nearest(x, y, Player);
	
	if(instance_exists(target)){
		var _angle = angle_difference(point_direction(x, y, target.x, target.y), gunangle);
		
		if(distance_to_object(target) >= 32){
			if((abs(_angle) * (pi/180) * distance_to_object(target)) >= 32){ // if(abs(_angle) >= 20){
				gunangle += _angle / 10;
				alarm0 = 1;
				
				motion_add(gunangle, 0.3);
			}
			else{
				
				 // Charge:
				if(random(5) < 2){
					dash = 20 + random(30);
					alarm0 += 20;
					
					sound_play(sndNothing2Taunt);
				}
			}
		}
	}
	
	/*
	if(instance_exists(target) && distance_to_object(target) > 32){
		var _td = point_direction(x, y, target.x, target.y);
		if(abs(angle_difference(gunangle, _td)) > 20){
			gunangle = _td + (angle_difference(gunangle, _td) * power(6/7, current_time_scale));
			motion_add(gunangle, 0.4);
			
			alarm0 = 1;
		}
		else{
			if(random(3) < 2){
				dash = 20 + random(20);
				alarm0 += 20;
				
				sound_play(sndNothing2HalfHP);
			}
		}
	}
	*/

#define Destroyer_create(_x, _y)
	with(obj_create(_x, _y, "Millipede")){
		name = "Destroyer";
		
		 // Visual:
		spr_head = global.sprDestroyerHead;
		spr_body = global.sprDestroyerBody;
		spr_tail = global.sprDestroyerTail;
		sprite_index = spr_head;
		
		 // Vars:
		damage = 24;
		color = c_white;
		seg_dis = 11;
		seeker = true;
		
		return self;
	}
	
#define Millipede_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "Millipede";
		
		 // Visual:
		spr_head = global.sprMillipedeHead;
		spr_body = global.sprMillipedeBody;
		spr_tail = global.sprMillipedeTail;
		sprite_index = spr_head;
		image_speed	 = 0.4;
		image_index  = 1 - image_speed;
		
		 // Vars:
		mask_index = mskFlakBullet;
		damage = 16;
		force = 6;
		typ = 2;
		parent = noone;
		child = noone;
		color = make_color_rgb(206, 194, 194);
		canhurt = true;
		target = noone;
		blink = 30;
		seg_dis = 9;
		wave = random(90);
		wallbreak = 0;
		active = true;
		seeker = false;
		time = 1;
		
		 // Mod Compat:
		ammo_type = 3;
		is_bolt = true;
		
		 // Alarms:
		alarm0 = -1;
		alarm1 = -1;
		
		 // Events:
		on_step = script_ref_create(Millipede_step);
		on_end_step = script_ref_create(Millipede_end_step);
		on_hit = script_ref_create(Millipede_hit);
		on_anim = script_ref_create(Millipede_anim);
		on_wall = script_ref_create(Millipede_wall);
		on_alrm0 = script_ref_create(Millipede_alrm0);
		on_alrm1 = script_ref_create(Millipede_alrm1);
		on_cleanup = script_ref_create(Millipede_cleanup);
		
		return self;
	}

#define Millipede_step
	 // Run Alarms:
	if(alarm0 >= 0 && --alarm0 == 0 && (script_ref_call(on_alrm0) || !instance_exists(self))) exit;
	if(alarm1 >= 0 && --alarm1 == 0 && (script_ref_call(on_alrm1) || !instance_exists(self))) exit;
	
	wave += current_time_scale;
	time -= current_time_scale;

	if(canhurt){
		
		 // Seek Cursor:
		if(!instance_exists(parent)){
			var _gx = null,
				_gy = null,
				_sc = 1/5;
				
			 // Prioritize Targeted Enemies:
			if(instance_exists(target)){
				_gx = target.x;
				_gy = target.y;
				
				_sc = 1/3;
			}
			else{
				var _skill = skill_get(mut_bolt_marrow);
				
				 // Destroyer:
				if(seeker){
					if(instance_exists(enemy)){
						var _near = instance_nearest(x, y, enemy);
						if(point_distance(x, y, _near.x, _near.y) < (96 + (96 * _skill))){
							_gx = _near.x;
							_gy = _near.y;
						}
						
						 // Stronger Seeking:
						if(_skill){
							_sc = 3/5;
						}
					}
				}
				else{
					if(instance_exists(creator)){
						
						 // Find Creator Goal:
						if("index" in creator){
							_gx = mouse_x[creator.index];
							_gy = mouse_y[creator.index];					
						}
						else{
							_gx = x;
							_gy = y;
						}
					
						 // Seek Enemies:	
						if(_skill > 0 && instance_exists(enemy)){
							var _near = instance_nearest(_gx, _gy, enemy);
							if(point_distance(x, y, _gx, _gy) < 96 && point_distance(x, y, _near.x, _near.y) < (96 * _skill)){
								
								target = _near;
								_gx = _near.x;
								_gy = _near.y;
								
								_sc = 1/3;
							}
						}
					}
				}
			}
			
			 // Seek:
			if(_gx != null && _gy != null){
				var _gd = point_direction(x, y, _gx, _gy);
				
				if(seeker){
					_gd += orandom(2);
				}
				else{
					_gd += sin(wave / 10) * 30;
				}
				
				direction = _gd + (angle_difference(direction, _gd) * power(1 - _sc, current_time_scale));
				image_angle = direction;
			}
		}
		else{
			
			 // No Speeding:
			x -= hspeed_raw;
			y -= vspeed_raw;
		}
	}
	
	 // Right:
	image_yscale = abs(image_yscale) * ((image_angle >= 90 && image_angle < 270) ? -1 : 1);
	
#define Millipede_end_step
	 // Trail:
	if(!instance_exists(child) && canhurt && time <= 0){
		var _dis = point_distance(x, y, xprevious, yprevious),
			_dir = point_direction(x, y, xprevious, yprevious);
			
		if(seeker){
			with(instance_create(x, y, BoltTrail)){
				image_yscale = 2;
				image_xscale = _dis;
				image_angle  = _dir;
				image_blend  = other.color;
			}
		}
		else{
			for(var i = -90; i <= 90; i += 180){
				var l = 4,
					d = image_angle + i;
					
				with(instance_create(x + lengthdir_x(l, d), y + lengthdir_y(l, d), BoltTrail)){
					image_yscale = 2;
					image_xscale = _dis;
					image_angle  = _dir;
					image_blend  = other.color;
				}
			}
		}
	}

	 // Follow Leader:
	if(!instance_exists(parent)){
		var _inst = child;
		
		 // Iterate Through Segments:
		while(instance_exists(_inst)){
			with(_inst){
				var _max = seg_dis,
					_dis = point_distance(x, y, parent.x, parent.y);
					
				if(_dis > _max){
					var l = _dis - _max,
						d = point_direction(x, y, parent.x, parent.y);
						
					x += lengthdir_x(l, d);
					y += lengthdir_y(l, d);
					
					direction = d;
					image_angle = d;
				}
				
				 // Next Segment:
				_inst = child;
			}
		}
	}
	
#define Millipede_wall
	if(canhurt){
		if(wallbreak++ < (seeker ? 3 : 2)){
			with(other){
				instance_create(x, y, FloorExplo);
				instance_destroy();
			}
		}
		else{
			wallbreak = 0;
			
			var _inst = self;
			while(instance_exists(_inst.child)){
				_inst = _inst.child;
			}
			with(_inst){
				
				if(instance_exists(parent)){
					parent.xprevious = x;
					parent.yprevious = y;
				}
				
				/*
				with(instance_create(x, y, RecycleGland)){
					sprite_index = global.sprMillipedeDisappear;
					image_angle = other.image_angle;
				}
				*/
				
				 // Goodbye:
				instance_destroy();
			}
		}
	}
	
#define Millipede_hit
	if(projectile_canhit(other)){
		projectile_hit(other, damage, force, direction);
		
		 // Pierce:
		if(other.my_health > 0){
			instance_destroy();
		}
	}
	
#define Millipede_anim
	image_index++;
	
#define Millipede_alrm0
	 // Deactivate All:
	if(!instance_exists(child)){
		var _inst = instances_matching(instances_matching_le(instances_matching(object_index, "name", name), "id", id), "active", true),
			_time = 90 + (6 * array_length(_inst))
			
		with(_inst){
			alarm1 = _time;
			active = false;
		}
		
		alarm1 += ceil(current_time_scale);
	}
	
#define Millipede_alrm1
	if(blink-- > 1){
		alarm1  = 2;
		visible = !visible;
	}
	else{
		
		instance_create(x, y, Dust);
		instance_destroy();
	}
	
#define Millipede_cleanup
	with(child){
		if(instance_exists(child)){
			sprite_index = spr_head;
			image_index = 1;
			parent = noone;
		}
	}
	
	with(parent){
		if(instance_exists(parent)){
			sprite_index = spr_tail;
			image_index = 1;
			child = noone;
		}
	}
	
#define OverlordBurst_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "OverlordBurst";
		
		 // Vars:
		creator = noone;
		team = -1;
		time = 1;
		wave = random(90);
		
		 // Events:
		on_step = script_ref_create(OverlordBurst_step);
		
		return self;
	}
	
#define OverlordBurst_step
	wave += current_time_scale;
	
#define PiercerBullet_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "PiercerBullet";
		
		 // Visual:
		sprite_index = global.sprPiercerBullet;
		
		 // Vars:
		mask_index = mskBullet2;
		damage = 3;
		force = 6;
		typ = 1;
		hit = [];
		
		 // Mod Compat:
		ammo_type = 1;
		is_bullet = true;
		
		 // Scripts:
		on_anim = script_ref_create(PiercerBullet_anim);
		on_hit = script_ref_create(PiercerBullet_hit);
		on_destroy = script_ref_create(PiercerBullet_destroy);
		
		return self;
	}
	
#define PiercerBullet_anim
	image_index = 1;
	image_speed = 0;
	
#define PiercerBullet_hit
	if(projectile_canhit(other) && array_find_index(hit, other) < 0){
		projectile_hit(other, damage, force, direction);
		array_push(hit, other);

		sleep(12 + (6 * other.size));
		
		 // Pierce Effect:
		with(instance_create(other.x + hspeed, other.y + vspeed, BulletHit)){
			sprite_index = global.sprPiercerBulletPierce;
			direction = other.direction + orandom(30);
			image_angle = other.image_angle;
			depth = other.depth - 1;
			speed = 3;
		}		
	}
	
#define PiercerBullet_destroy
    with(instance_create(x + hspeed, y + vspeed, BulletHit)){
    	sprite_index = global.sprPiercerBulletHit;
    }
	
#define PiercerShell_create(_x, _y)
	with(instance_create(_x, _y, Shell)){
		name = "PiercerShell";
		
		 // Visual:
		sprite_index = global.sprPiercerShell;
		
		return self;
	}
	
#define Seed_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "Seed";
		
		 // Visual:
		sprite_index = global.sprSeed;
		
		 // Vars:
		mask_index = mskBullet1;
		damage = 10;
		force = 6;
		typ = 2;
		color = make_color_rgb(223, 150, 212);
		canhurt = true;
		ammo = irandom_range(7, 9);
		
		 // Mod Compat:
		ammo_type = 3;
		is_bolt = true;
		
		 // Events:
		on_step = script_ref_create(Seed_step);
		on_end_step = script_ref_create(Seed_end_step);
		on_hit = script_ref_create(Seed_hit);
		on_anim = script_ref_create(Seed_anim);
		on_wall = script_ref_create(Seed_wall);
		on_alrm1 = script_ref_create(Seed_alrm1);
		
		return self;
	}
	
#define Seed_step
	 // Run Alarms:
	if(alarm1 >= 0 && --alarm1 == 0 && (script_ref_call(on_alrm1) || !instance_exists(self))) exit;
	
	 // Seeking:
	var _skill = skill_get(mut_bolt_marrow);
	if(canhurt && _skill > 0 && instance_exists(enemy)){
		
		var n = instance_nearest(x, y, enemy);
		if(point_distance(x, y, n.x, n.y) < (24 * _skill)){
			x = n.x - hspeed_raw;
			y = n.y - vspeed_raw;
		}
	}
	
#define Seed_end_step
	 // Trail:
	if(canhurt){
		var _dis = point_distance(x, y, xprevious, yprevious),
			_dir = point_direction(x, y, xprevious, yprevious);
			
		with(instance_create(x, y, BoltTrail)){
			image_xscale = _dis;
			image_angle  = _dir;
			image_blend  = other.color;
		}
	}
	
#define Seed_hit
	if(canhurt && projectile_canhit(other)){
		projectile_hit(other, damage, force, direction);
		
		 // Destroy:
		if(other.my_health > 0){
			
			 // Stick:
			var _target = other;
			with(instance_create(x, y, BoltStick)){
				sprite_index = other.sprite_index;
				image_angle = other.image_angle;
				target = _target;
			}
			
			 // Vine:
			with(spawn_vine(x, y, other, ammo, direction)){
				creator = other.creator;
				team = other.team;
				
				motion_add(direction, random_range(2, 3));
				motion_add(point_direction(other.x, other.y, x, y), random_range(3, 4));
			}
			
			 // Sounds:
			audio_sound_set_track_position(sound_play_pitch(sndWallBreakJungle, 1.5), 0.3);
			audio_sound_set_track_position(sound_play_pitchvol(sndPlantSnareTrapperTB, 0.55, 0.5), 0.25);
			sound_play_pitch(sndJungleAssassinAttack, 1.2);
			
			/*
			if(_wall){
				sound_play_pitchvol(sndPlasmaHit, random_range(0.6, 0.8), 0.7);
				sound_play_pitch(sndPillarBreak, random_range(0.6, 0.8));
			}
			else{
				sound_play_pitch(sndPortalFlyby4, random_range(1.5, 1.7));
			}
			*/
			
			 // Game Feel:
			sleep(35);
			view_shake_at(x, y, 15);
			
			 // Goodbye:
			instance_destroy();
		}
	}
	
#define Seed_anim
	image_index = 1;
	image_speed = 0;
	
#define Seed_wall
	if(canhurt){
		canhurt = false;
		alarm1 = 30;
		
		with(instance_create(x, y, BoltTrail)){
			image_xscale = other.speed;
			image_angle  = other.image_angle;
			image_blend  = other.color;
		}
		
		x += hspeed;
		y += vspeed;
		xprevious = x;
		yprevious = y;
		
		instance_create(x, y, Dust);
		
		audio_sound_set_track_position(sound_play_pitchvol(sndSnowmanBreak, random_range(0.7, 0.9), 0.8), 0.2);
		sound_play_pitchvol(sndBoltHitWall, random_range(0.8, 1), 0.8);
		sound_play_pitch(sndPlantFireTB, random_range(1.1, 1.3));
		
		speed = 0;
	}
	
#define Seed_alrm1
	instance_destroy();
	
#define Syringe_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "Syringe";
		
		 // Visual:
		sprite_index = global.sprSyringe;
		
		 // Vars:
		mask_index = mskBullet1;
		damage = 8;
		force = 4;
		typ = 2;
		color = make_color_rgb(47, 198, 130);
		canhurt = true;
		
		 // Mod Compat:
		ammo_type = 3;
		is_bolt = true;
		
		 // Events:
		on_step = script_ref_create(Syringe_step);
		on_end_step = script_ref_create(Syringe_end_step);
		on_hit = script_ref_create(Syringe_hit);
		on_anim = script_ref_create(Syringe_anim);
		on_wall = script_ref_create(Syringe_wall);
		on_alrm1 = script_ref_create(Syringe_alrm1);
		
		 // Alarms:
		alarm1 = -1;
		
		return self;
	}
	
#define Syringe_step
	 // Run Alarms:
	if(alarm1 >= 0 && --alarm1 == 0 && (script_ref_call(on_alrm1) || !instance_exists(self))) exit;
	
	 // Seeking:
	var _skill = skill_get(mut_bolt_marrow);
	if(canhurt && _skill > 0 && instance_exists(enemy)){
		
		var n = instance_nearest(x, y, enemy);
		if(point_distance(x, y, n.x, n.y) < (24 * _skill)){
			x = n.x - hspeed_raw;
			y = n.y - vspeed_raw;
		}
	}

#define Syringe_end_step

	 // Trail:
	if(canhurt){
		var _dis = point_distance(x, y, xprevious, yprevious),
			_dir = point_direction(x, y, xprevious, yprevious);
			
		with(instance_create(x, y, BoltTrail)){
			image_xscale = _dis;
			image_angle  = _dir;
			image_blend  = other.color;
		}
	}

#define Syringe_hit
	if(canhurt && projectile_canhit(other)){
		projectile_hit(other, damage, force, direction);
		
		 // Destroy:
		if(other.my_health > 0){
			
			 // Stick:
			var _target = other;
			with(instance_create(x, y, BoltStick)){
				sprite_index = other.sprite_index;
				image_angle = other.image_angle;
				target = _target;
			}
			
			 // Inject:
			if(instance_is(other, enemy) && "syringe_hit" not in other){
				other.syringe_hit = true;
				
				var _num = 0.66;
				other.my_health *= _num;
				other.maxhealth *= _num;
				
				with(instance_create(other.x, other.bbox_top, FrogHeal)){
					sprite_index = global.sprSyringeDamage;
				}
				/*
				var _snd = sound_play_pitch(sndPlasmaHugeUpg, 0.8); 	audio_sound_set_track_position(_snd, 1.2) audio_sound_gain(_snd, 0, 500)
				audio_sound_set_track_position(sound_play_pitchvol(sndPlasmaBigUpg, 0.6, 0.4), 0.45)
				audio_sound_set_track_position(sound_play_pitch(sndEliteInspectorFire, 1), 0.278)
				sndPlantFireTB
				sndHorrorA
				sndFishWarrantEnd
				sndCrystalTB
				sndChickenThrow
				sndChickenReturn
				sndUltraGrenadeSuck
				audio_sound_set_track_position(sound_play_pitchvol(sndPortalStrikeFireButt, 1.2, 2.5), 1.05)
				sound_play_pitch(sndChickenReturn, 1.2);
				
				*/
				
			}
			
			 // Goodbye:
			instance_destroy();
		}
	}
	
#define Syringe_anim
	image_index = 1;
	image_speed = 0;
	
#define Syringe_wall
	if(canhurt){
		canhurt = false;
		alarm1 = 30;
		
		with(instance_create(x, y, BoltTrail)){
			image_xscale = other.speed;
			image_angle  = other.image_angle;
			image_blend  = other.color;
		}
		
		x += hspeed;
		y += vspeed;
		xprevious = x;
		yprevious = y;
		
		instance_create(x, y, Dust);
		
		sound_play_pitch(sndBoltHitWall, random_range(1.1, 1.3));
		sound_play_pitchvol(sndLuckyShotProc, random_range(0.7, 1.1), 0.4);
		
		speed = 0;
	}
	
#define Syringe_alrm1
	instance_destroy();
	
#define Tether_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "Tether";
		
		 // Visual:
		sprite_index = global.sprTether;
		image_speed = 0.4;
		depth = -7;
		
		 // Vars:
		mask_index = mskPlasma;
		damage = 2;
		force = 0;
		typ = 2;
		target = noone;
		color = make_color_rgb(47, 198, 130);
		wave = random(90);
		timer = 1;
		shake = 3;
		
		points = [];
		num_points = 16;
		repeat(num_points){
			array_push(points, {"x": x, "y": y, "w": 1});
		}
		
		 // Mod Compat:
		ammo_type = 5;
		
		 // Events:
		on_step = script_ref_create(Tether_step);
		on_draw = script_ref_create(Tether_draw);
		on_wall = script_ref_create(Tether_wall);
		on_hit = script_ref_create(Tether_hit);
		on_destroy = script_ref_create(Tether_destroy);
		
		return self;
	}
	
#define Tether_step
	wave += current_time_scale;
	
	timer -= current_time_scale;
	if(timer > 0 && instance_exists(creator)){
		with(creator){
			wkick += current_time_scale;
			
			var s = weapon_get_sprite(wep),
				l = sprite_get_width(s) - sprite_get_xoffset(s) - wkick,
				d = gunangle;
				
			other.x = x + lengthdir_x(l, d) + hspeed_raw;
			other.y = y + lengthdir_y(l, d) + vspeed_raw;
		}
		
		image_angle = creator.gunangle;
		
		xprevious = x;
		yprevious = y;
		
		 // Particles:
		if(random(5) < current_time_scale){
			with(instance_create(x, y, PlasmaTrail)){
				sprite_index = global.sprTetherTrail;
				direction = random(360);
				image_angle = direction;
				depth = other.depth;
				speed = 2;
			}
		}
		
		if(instance_exists(target)){
			with(target){
				var _md = point_direction(x, y, mouse_x[other.creator.index], mouse_y[other.creator.index]);
				gunangle = _md + (angle_difference(gunangle, _md) * power(2/3, current_time_scale));
				
				motion_add_ct(gunangle, 1.2);
				alarm0 = 30;
			}
			
			 // Points:
			var _cx = x,
				_cy = y,
				_mx = mouse_x[creator.index],
				_my = mouse_y[creator.index],
				_tx = target.x,
				_ty = target.y,
				_lx = _cx,
				_ly = _cy,
				_lo = wave / 20,
				_la = 1 / num_points,
				_ll = _la,
				_lw = 4;
				
			with(points){
				x = _lx;
				y = _ly;
				w = _lw;
				
				_ll += _la;
					
				 // Stolen Jsburg Math:
				var _x1 = lerp(_cx, _mx, _ll),
					_y1 = lerp(_cy, _my, _ll),
					_x2 = lerp(_mx, _tx, _ll),
					_y2 = lerp(_my, _ty, _ll);
					
				_lo++;
				
				_lx = lerp(_x1, _x2, _ll); // + sin(_lo) * 2;
				_ly = lerp(_y1, _y2, _ll); // + cos(_lo) * 2;
				
				var _shake = other.shake;
				if(_shake > 0){
					_lx += random_range(-_shake, _shake);
					_ly += random_range(-_shake, _shake);
				}
				
				_lw = lerp(_lw, 1, 0.4);
			}
			
			shake -= current_time_scale;
		}
	}
	else{
		
		sound_play_pitch(sndNothing2Beam, random_range(0.9, 1.1));
		
		 // Goodbye:
		instance_destroy();
	}
	
#define Tether_draw
	
	 // Draw Line:
	if(instance_exists(target)){
		draw_set_color(color);
		
		var _last  = noone,
			_scale = image_yscale;
		
		with(points){
			if(_last != noone){
				draw_line_width(_last.x, _last.y, x, y, (w * _scale));
			}
			
			_last = self;
		}
		
		draw_set_color(c_white);
	}
	
	 // Draw Start:
	draw_self();
	
	draw_set_blend_mode(bm_add);
	
	image_xscale *= 2;
	image_yscale *= 2;
	image_alpha  /= 10;
	
	draw_self();
	
	image_xscale /= 2;
	image_yscale /= 2;
	image_alpha  *= 10;
	
	draw_set_blend_mode(bm_normal);
	
#define Tether_wall
	
#define Tether_hit
	if(projectile_canhit(other)){
		projectile_hit(other, (damage * current_time_scale), force, direction);
		sleep(16 + (8 * other.size));
	}
	
#define Tether_destroy
	 // Line:
	var _last  = noone,
		_scale = image_yscale,
		_depth = depth,
		_color = color;
		
	with(points){
		if(_last != noone){
			with(instance_create(x, y, BoltTrail)){
				image_blend = _color;
				image_yscale = (_scale * other.w) / 2;
				image_xscale = point_distance(x, y, _last.x, _last.y);
				image_angle = point_direction(x, y, _last.x, _last.y);
				depth = _depth;
			}
		}
		
		_last = self;
	}
	
	 // Start:
	with(instance_create(x, y, BulletHit)){
		sprite_index = global.sprTetherDisappear;
		image_xscale = other.image_xscale;
		image_yscale = other.image_yscale;
		image_angle  = other.image_angle;
		depth = other.depth;
	}

#define spawn_vine(_x, _y, _target, _length, _direction)
	 // Vine:
	var _last = _target,
		_amnt = _length,
		_inst = [];
		
	while(_amnt-- > 0){
		var l = random_range(12, 16),
			d = (_last == _target) ? _direction : _last.direction;
			
		 // Home to Nearest Enemy:	
		if(instance_exists(enemy)){
			var _lx = _last.x,
				_ly = _last.y;
				
			_target.x -= 10000;
			_target.y -= 10000;
			
			var _near = instance_nearest(_lx, _ly, enemy);
			
			var _nx = _near.x,
				_ny = _near.y;
				
			if(point_distance(_lx, _ly, _nx, _ny) < 64 && collision_line(_lx, _ly, _nx, _ny, Wall, false, false) <= 0){
				d += angle_difference(point_direction(_lx, _ly, _nx, _ny), d) * 2/3;
			}
			
			_target.x += 10000;
			_target.y += 10000;
		}
		
		 // Noise:
		d += orandom(15);
			
		 // Hit Wall:
		if(!place_free(_last.x, _last.y)){
			
			instance_create(_last.x, _last.y, Dust);
			d += random_range(90, 270);
			
			sleep(8);
		}
			
		 // Create Projectile:
		with(obj_create(_last.x + lengthdir_x(l, d), _last.y + lengthdir_y(l, d), "Vine")){
			target = _target;
			parent = _last;
			
			_last = self;
			
			with(parent){
				child = other;
			}
			
			direction   = d;
			image_angle = d;
			
			 // Segment Sprites:
			if(_amnt > 0){
				if(parent == target){
					sprite_index = global.sprVineStart;
				}
				else{
					sprite_index = global.sprVine;
				}
				
				 // Flowers:
				if(random(3) < 1){
					leaf_sprite = global.sprVineLeaf;
					leaf_index  = irandom(sprite_get_number(leaf_sprite) - 1);
				}
			}
			else{
				sprite_index = global.sprVineEnd;
			}
			
			 // Sparkles:
			with(instance_create(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), ThrowHit)){
				sprite_index = global.sprVineSparkle;
				direction = other.direction;
				speed = other.speed;
			}
			
			array_push(_inst, self);
		}
	}
	
	return _inst;
	
#define Vine_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "Vine";
		
		 // Visual:
		sprite_index = global.sprVine;
		image_yscale = choose(-1, 1);
		image_speed = 1;
		leaf_sprite = null
		leaf_index = 0;
		leaf_speed = 0;
		leaf_angle = choose(90, 270) + orandom(45);
		
		 // Vars:
		mask_index = global.mskVine;
		friction = 0.2;
		damage = 2;
		force = 0;
		typ = 0;
		target = noone;
		parent = noone;
		child = noone;
		blink = 0;
		
		 // Mod Compat:
		ammo_type = 3;
		
		 // Alarms:
		alarm1 = 80;
		
		 // Events:
		on_step = script_ref_create(Vine_step);
		on_end_step = script_ref_create(Vine_end_step);
		on_draw = script_ref_create(Vine_draw);
		on_wall = script_ref_create(Vine_wall);
		on_hit = script_ref_create(Vine_hit);
		on_anim = script_ref_create(Vine_anim);
		on_alrm1 = script_ref_create(Vine_alrm1);
		
		return self;
	}
	
#define Vine_step
	 // Run Alarms:
	if(alarm1 >= 0 && --alarm1 == 0 && (script_ref_call(on_alrm1) || !instance_exists(self))) exit;
	
	 // Animate Leaf:
	if(leaf_sprite != null){
		leaf_index = (leaf_index + (leaf_speed * current_time_scale)) % sprite_get_number(leaf_sprite);
	}
	
#define Vine_end_step
	 // Vine Physics:
	var _min = 16,
		_max = 128;
		
	if(instance_exists(parent)){
		var _dis = point_distance(x, y, parent.x, parent.y),
			_len = _dis - _min,
			_dir = point_direction(x, y, parent.x, parent.y),
			_xo	 = lengthdir_x(_len, _dir),
			_yo  = lengthdir_y(_len, _dir);
			
		if(_dis < _max){
			if(target != parent){
				_xo /= 2;
				_yo /= 2;
				
				x += _xo;
				y += _yo;
				
				parent.x -= _xo;
				parent.y -= _yo;
			}
			else{
				
				 // Don't Pull Enemy:
				x += _xo;
				y += _yo;
			}
		}
		else{
			
			 // Estrange:
			parent = noone;
			instance_create(x, y, Smoke);
		}
		
		image_angle = _dir;
	}
	
#define Vine_draw
	var _px = x,
		_py = y,
		_pd = image_angle;
		
	if(instance_exists(parent)){
		_px = parent.x;
		_py = parent.y;
		
		if(target != parent){
			_pd = ((parent.image_angle + image_angle) / 2);
			
			if(abs(parent.image_angle - image_angle) >= 45){
				_pd = image_angle;
			}
		}
	}
	else{
		_px = x + lengthdir_x(16, image_angle);
		_py = y + lengthdir_y(16, image_angle);
	}
	
	var _len = ((sprite_get_height(sprite_index) * image_xscale) / 2) * image_yscale,
		_dir = image_angle;
	
	if(instance_exists(child)){
		_dir = (child.image_angle + image_angle) / 2;
		
		if(abs(child.image_angle - image_angle) >= 45){
			_dir = image_angle;
		}
	}
	
	_pd  += 90;
	_dir += 90;
	
	draw_sprite_pos(
		sprite_index, 
		image_index, 
		_px + lengthdir_x(_len, _pd), 
		_py + lengthdir_y(_len, _pd), 
		x   + lengthdir_x(_len, _dir), 
		y   + lengthdir_y(_len, _dir), 
		x   - lengthdir_x(_len, _dir), 
		y   - lengthdir_y(_len, _dir), 
		_px - lengthdir_x(_len, _pd), 
		_py - lengthdir_y(_len, _pd), 
		image_alpha
	);
	
	 // Leaf:
	if(leaf_sprite != null){
		draw_sprite_ext(leaf_sprite, leaf_index, x, y, image_xscale, image_yscale, (image_angle + leaf_angle), image_blend, image_alpha);
	}
	
#define Vine_wall
	move_bounce_solid(false);
	speed *= 0.8;
	
#define Vine_hit
	if(projectile_canhit(other) && (other.nexthurt <= current_frame || random(6) < current_time_scale)){
		projectile_hit_push(other, damage, force);
	}
	
#define Vine_anim
	image_index = 2;
	
#define Vine_alrm1
	if(blink-- > 0){
		alarm1 = 2;
		visible = !visible;
	}
	else{
		instance_create(x, y, Dust);
		instance_destroy();
	}

#define WarpBullet_create(_x, _y)
    with(instance_create(_x, _y, CustomProjectile)){
        name = "WarpBullet";
        
         // Visual:
        sprite_index = global.sprWarpBullet;
        
         // Vars:
        mask_index = mskBullet1;
        damage = 4;
        force = 4;
        typ = 1;
        warp = 2;
        
         // Mod Compat:
        ammo_type = 1;
        is_bullet = true;
        
         // Events:
        on_step = script_ref_create(WarpBullet_step);
        on_anim = script_ref_create(WarpBullet_anim);
        on_wall = script_ref_create(WarpBullet_wall);
        on_hit  = script_ref_create(WarpBullet_hit);
        on_destroy = script_ref_create(WarpBullet_destroy);
        
        return self;
    }
    
#define WarpBullet_step
	 // Trail:
	if(random(10) < current_time_scale){
    	with(instance_create(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), PlasmaTrail)){
    		sprite_index = global.sprWarpBulletTrail;
    	}
	}
    
#define WarpBullet_anim
    image_index = 1;
    
#define WarpBullet_wall
    if(warp-- > 0){
    	 // Effect:
    	with(instance_create(x + hspeed_raw, y + vspeed_raw, BulletHit)){
    		sprite_index = global.sprWarpBulletDisappear;
    		image_angle  = other.image_angle;
    	}
    	
    	move_outside_solid(direction + 180, speed);
        move_contact_solid(direction + 180, 800);
        
    	 // Effect:
    	with(instance_create(x, y, BulletHit)){
    		sprite_index = global.sprWarpBulletAppear;
    		image_angle  = other.image_angle;
    	}
        
         // Sounds:
        audio_sound_set_track_position(sound_play_pitchvol(sndPortalStrikeFireButt, random_range(0.6, 0.8), 0.1), 1.05);
        audio_sound_set_track_position(sound_play_pitchvol(sndLaserUpg, 			random_range(1.2, 1.4), 0.4), 0.5);
    }
    else{
        
        sound_play_pitch(sndHitWall, random_range(0.9, 1.1));
        
         // Goodbye:
        instance_destroy();
    }
    
#define WarpBullet_hit
	if(projectile_canhit(other)){
		projectile_hit(other, damage, force, direction);
		
		 // Recycle Gland:
		if(instance_is(creator, Player)){
			
			var _skill = skill_get(mut_recycle_gland);
			if(_skill > 0 && random(5) < 3){
				
				instance_create(x, y, RecycleGland);
				with(creator){
					
					ammo[1] = min(ammo[1] + ceil(_skill), typ_amax[1]);
				}
			}
		}
		
		 // Goodbye:
		instance_destroy();
	}
    
#define WarpBullet_destroy
    with(instance_create(x + hspeed, y + vspeed, BulletHit)){
    	sprite_index = global.sprWarpBulletHit;
    }
	
#define WarpShell_create(_x, _y)
	with(instance_create(_x, _y, Shell)){
		name = "WarpShell";
		
		 // Visual:
		sprite_index = global.sprWarpShell;
		
		return self;
	}
	
#define WeaponBurst_create(_x, _y)
    with(instance_create(_x, _y, CustomObject)){
        name = "WeaponBurst";
        
         // Vars:
        accuracy = 1;
        team = -1;
        creator = noone;
        ammo = 0;
        time = 0;
        time_max = 0;
        burst = 0;
        wep = wep_none;
        spec = false;
        
         // Events:
        on_step = script_ref_create(WeaponBurst_step);
        
        return self;
    }
    
#define WeaponBurst_step
    if(time > 0 && ammo > 0){
        
        time -= current_time_scale;
        if(time <= 0){
            
            time += time_max;
            ammo -= 1;
            
            burst++;
            
             // Fire:
            if(instance_exists(creator)){
                x = creator.x;
                y = creator.y;
                if("gunangle" in creator){
                    direction = creator.gunangle;
                }
                
                if(instance_is(creator, Player)){
                    with(creator){
                        
                        if(other.spec){
                            player_swap(self);
                            specfiring = true;
                        }
                        
                        var _accuracy = accuracy,
                            _team     = team;
                            
                        accuracy = other.accuracy;
                        team     = other.team;
                        
                        mod_script_call("weapon", other.wep, "weapon_fire");
                        
                        accuracy = _accuracy;
                        team     = _team;
                        
                        if(other.spec){
                            player_swap(self);
                            specfiring = false;
                        }
                    }
                }
                else{
                    
                     // Non-Player Firing:
                    with(player_fire_ext(direction, wep_none, x, y, team, creator, accuracy)){
                        wep = other.wep;
                        mod_script_call("weapon", wep, "weapon_fire");
                        
                         // Pass Variables:
                        with(other.creator){
                            if(friction != 0){
                                hspeed += other.hspeed;
                                vspeed += other.vspeed;
        						if("wkick"    in self) wkick    = other.wkick;
        						if("wepangle" in self) wepangle = other.wepangle * ((abs(other.wepangle) > 1) ? sign(wepangle) : wepangle);
        						if("reload"   in self) reload  += other.reload;
                            }
                        }
                    }
                }
            }
        }
    }
    else{
        
         // Goodbye:
        instance_destroy();
    }

#define draw_bloom
	if(instance_exists(CustomProjectile)){
		
		 // Generic:
		var _inst = instances_matching(instances_matching(CustomProjectile, "name", "Anchor", "Beetle", "Millipede", "PiercerBullet", "Seed", "Syringe", "WarpBullet"), "visible", true);
		if(array_length(_inst)) with(_inst){
			
			image_xscale *= 2;
			image_yscale *= 2;
			image_alpha  /= 10;
			
			draw_self();
			
			image_xscale /= 2;
			image_yscale /= 2;
			image_alpha  *= 10;
		}
		
		 // Vines:
		var _inst = instances_matching(instances_matching(CustomProjectile, "name", "BendyLaser", "BouncyLaser", "Vine"), "visible", true);
		if(array_length(_inst)) with(_inst){
			image_yscale *= 2;
			image_alpha  /= 10;
			
			event_perform(ev_draw, 0);
			
			image_yscale /= 2;
			image_alpha  *= 10;
		}
	}
	
#define draw_dark
	if(instance_exists(CustomObject)){
		var _inst = instances_matching(instances_matching(CustomObject, "name", "Coelacanth"), "visible", true);
		if(array_length(_inst)) with(_inst){
			var _radius = 96 + random(4);
			
			draw_circle(x, y, _radius, false);
		}
	}
	
	
#define draw_dark_end
	if(instance_exists(CustomObject)){
		var _inst = instances_matching(instances_matching(CustomObject, "name", "Coelacanth"), "visible", true);
		if(array_length(_inst)) with(_inst){
			var _radius = 48 + random(2);
			
			draw_circle(x, y, _radius, false);
		}
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
	
#define instance_nearest_array(_x, _y, _obj)
	/*
		Returns the instance closest to a given point from an array of instances
		
		Ex:
			instance_nearest_array(x, y, instances_matching_ne(hitme, "team", 2));
	*/
	
	var	_disMax  = infinity,
		_nearest = noone;
		
	with(instances_matching_ne(_obj, "id")){
		var _dis = point_distance(_x, _y, x, y);
		if(_dis < _disMax){
			_disMax  = _dis;
			_nearest = self;
		}
	}
	
	return _nearest;
	
#define instances_in_rectangle(_x1, _y1, _x2, _y2, _obj)
	/*
		Returns all instances of the given object whose positions overlap the given rectangle
		Much better performance than checking 'point_in_rectangle()' on every instance
		
		Args:
			x1/y1/x2/y2 - The rectangular area to search
			obj         - The object(s) to search
	*/
	
	return (
		instances_matching_le(
		instances_matching_le(
		instances_matching_ge(
		instances_matching_ge(
		_obj,
		"x", _x1),
		"y", _y1),
		"x", _x2),
		"y", _y2)
	);

#define player_swap(_player)
	/*
	    Code lifted directly from NT:TE
		Cycles the given player's weapon slots
	*/
	
	with(["%wep", "%curse", "%reload", "%wkick", "%wepflip", "%wepangle", "%can_shoot", "%clicked", "%interfacepop", "drawempty%"]){
		var	_name = [string_replace(self, "%", ""), string_replace(self, "%", "b")],
			_temp = variable_instance_get(_player, _name[0], 0);
			
		variable_instance_set(_player, _name[0], variable_instance_get(_player, _name[1], 0));
		variable_instance_set(_player, _name[1], _temp);
	}
    
#define orandom(_num)
    return irandom_range(-_num, _num);