#define init
	 // Sprites:
	var m = "sprites/",
		p = m;
	
		 // Projectiles:
		p = m + "projectiles/";
			
			 // Beetles:
			global.sprBeetle = sprite_add(p + "sprBeetle.png", 3, 12, 12);
			global.sprBeetleStick = sprite_add(p + "sprBeetleStick.png", 1, 12, 12);
		 
			 // Piercer Bullets:
			global.sprPiercerBullet = sprite_add(p + "sprPiercerBullet.png", 2, 10, 10);
			
			 // Seed:
			global.sprSeed = sprite_add(p + "sprSeed.png", 2, 8, 8);
			
			 // Syringes:
			global.sprSyringe = sprite_add(p + "sprSyringe.png", 2, 8, 8);
			
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
		
			 // Piercer Bullet:
			global.sprPiercerBulletHit = sprite_add(p + "sprPiercerBulletHit.png", 4, 10, 10);
			
			 // Syringe:
			global.sprSyringeDamage = sprite_add(p + "sprSyringeDamage.png", 8, 16, 32);
			
			 // Vine:
			global.sprVineLeaf = sprite_add(p + "sprVineLeaf.png", 3, 16, 16);
			global.sprVineSparkle = sprite_add(p + "sprVineSparkle.png", 4, 8, 8);
			
			 // Warp Bullet:
			global.sprWarpBulletHit = sprite_add(p + "sprWarpBulletHit.png", 4, 10, 10);
			global.sprWarpBulletAppear = sprite_add(p + "sprWarpBulletAppear.png", 4, 10, 10);
			global.sprWarpBulletDisappear = sprite_add(p + "sprWarpBulletDisappear.png", 4, 10, 10);
			global.sprWarpBulletTrail = sprite_add(p + "sprWarpBulletTrail.png", 4, 4, 4);
			
			
	 // Mod Type:
	mod_current_type = script_ref_create(0)[0];
			
#macro mod_current_type global.mod_current_type
			
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
		var _dis = point_distance(other.x, other.y, other.xprevious, other.yprevious),
			_dir = point_direction(other.x, other.y, other.xprevious, other.yprevious);
			
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
	if(projectile_canhit_melee(other)){
		projectile_hit(other, damage, force, direction);
		
		sleep(20);
		x -= hspeed_raw;
		y -= vspeed_raw;
	}
	
#define PiercerBullet_destroy
    with(instance_create(x + hspeed, y + vspeed, BulletHit)){
    	sprite_index = global.sprPiercerBulletHit;
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
		var _dis = point_distance(other.x, other.y, other.xprevious, other.yprevious),
			_dir = point_direction(other.x, other.y, other.xprevious, other.yprevious);
			
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
			var _last = other,
				_wall = false;
				
			while(ammo-- > 0){
				var l = random_range(12, 16),
					d = _last.direction;
					
				 // Home to Nearest Enemy:	
				if(instance_exists(enemy)){
					var _lx = _last.x,
						_ly = _last.y;
						
					other.x -= 10000;
					other.y -= 10000;
					
					var _near = instance_nearest(_lx, _ly, enemy);
					
					var _nx = _near.x,
						_ny = _near.y;
						
					if(point_distance(_lx, _ly, _nx, _ny) < 64 && collision_line(_lx, _ly, _nx, _ny, Wall, false, false) <= 0){
						d += angle_difference(point_direction(_lx, _ly, _nx, _ny), d) * 2/3;
					}
					
					other.x += 10000;
					other.y += 10000;
				}
				
				 // Noise:
				d += orandom(15);
					
				 // Hit Wall:
				if(!place_free(_last.x, _last.y)){
					
					instance_create(_last.x, _last.y, Dust);
					d += random_range(90, 270);
					
					sleep(8);
					_wall = true;
				}
					
				 // Create Projectile:
				with(obj_create(_last.x + lengthdir_x(l, d), _last.y + lengthdir_y(l, d), "Vine")){
					creator = other.creator;
					team = other.team;
					
					target = _target;
					parent = _last;
					
					_last = self;
					
					with(parent){
						child = other;
					}
					
					direction   = d;
					image_angle = d;
					
					if(other.ammo > 0){
						if(parent == _target){
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
					
					motion_add(direction, random_range(2, 3));
					motion_add(point_direction(other.x, other.y, x, y), random_range(3, 4));
					
					with(instance_create(random_range(bbox_left, bbox_right), random_range(bbox_top, bbox_bottom), ThrowHit)){
						sprite_index = global.sprVineSparkle;
						direction = other.direction;
						speed = other.speed;
					}
				}
			}
			
			 // Sounds:
			audio_sound_set_track_position(sound_play_pitch(sndWallBreakJungle, 1.5), 0.3);
			audio_sound_set_track_position(sound_play_pitchvol(sndPlantSnareTrapperTB, 0.55, 0.5), 0.25);
			sound_play_pitch(sndJungleAssassinAttack, 1.2);
			
			if(_wall){
				sound_play_pitchvol(sndPlasmaHit, random_range(0.6, 0.8), 0.7);
				sound_play_pitch(sndPillarBreak, random_range(0.6, 0.8));
			}
			else{
				sound_play_pitch(sndPortalFlyby4, random_range(1.5, 1.7));
			}
			
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
		var _dis = point_distance(other.x, other.y, other.xprevious, other.yprevious),
			_dir = point_direction(other.x, other.y, other.xprevious, other.yprevious);
			
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
		blink = 15;
		
		 // Mod Compat:
		ammo_type = 3;
		
		 // Alarms:
		alarm1 = 50;
		
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
    	
        move_contact_solid(direction + 180, 800);
        
    	 // Effect:
    	with(instance_create(x, y, BulletHit)){
    		sprite_index = global.sprWarpBulletAppear;
    		image_angle  = other.image_angle;
    	}
        
         // Sounds:
        var _snd = sound_play_hit(sndLaserUpg, 0.3);
        audio_sound_set_track_position(_snd, 0.5);
        audio_sound_gain(_snd, 0.5, 0);
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
            
             // Fire:
            instance_exists(creator){
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
		var _inst = instances_matching(CustomProjectile, "name", "Beetle", "PiercerBullet", "Seed", "Syringe", "WarpBullet");
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
		var _inst = instances_matching(CustomProjectile, "name", "Vine");
		if(array_length(_inst)) with(_inst){
			image_yscale *= 2;
			image_alpha  /= 10;
			
			draw_self();
			
			image_yscale /= 2;
			image_alpha  *= 10;
		}
	}

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