#define init
	var m = "../sprites/",
		p = m;
		
	p = m + "weapons/";
    global.sprWep = sprite_add_weapon(p + "sprAcidBazooka.png", 10, 7);
    
    p = m + "projectiles/";
    global.sprAcidRocket = sprite_add(p + "sprAcidRocket.png", 1, 4, 4);
    global.sprAcid = sprite_add(p + "sprAcid.png", 4, 24, 24);
    
    p = m + "effects/";
    global.sprAcidBubble = sprite_add(p + "sprAcidBubble.png", 6, 8, 8);
    global.sprAcidExplosionStreak = sprite_add(p + "sprAcidExplosionStreak.png", 7, 0, 16);
    
    global.acid_draw = noone;
    global.acid_bloom_draw = noone;
    global.acid_surf = noone;
    global.acid_bloom_surf = noone;
    
    global.acid_color_a = make_color_rgb(133, 249, 26);
    global.acid_color_b = make_color_rgb(133, 194, 5);
    global.acid_color_c = make_color_rgb(190, 253, 8);

#define cleanup
	if(instance_exists(global.acid_draw)){
		instance_delete(global.acid_draw);
	}
	if(instance_exists(global.acid_bloom_draw)){
		instance_delete(global.acid_bloom_draw);
	}
	if(surface_exists(global.acid_surf)){
		surface_destroy(global.acid_surf);
	}
	if(surface_exists(global.acid_bloom_surf)){
		surface_destroy(global.acid_bloom_surf);
	}
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "ACID BAZOOKA";
#define weapon_text return "POLLUTE";
#define weapon_type return 4; // Explosive
#define weapon_cost return 2;
#define weapon_load return 25;
#define weapon_area return -1;
#define weapon_swap return sndSwapExplosive;
#define weapon_burst return 2;
#define weapon_burst_time return 4;

#define weapon_fire(_wep)
	
	 // Projectile:
	with(AcidRocket_create(x, y)){
		creator = other;
		team = other.team;
		
		direction = other.gunangle + (other.accuracy * orandom(6));
		image_angle = direction;
		speed = 2;
	}
	
	 // Game Feel:
	weapon_post(16, 8, 32);
	motion_add(gunangle + 180, 3);
	
	audio_sound_gain(sound_play_pitchvol(sndRocket, random_range(0.9, 1.1), 0.7), 0, 190);
	audio_sound_set_track_position(sound_play_pitchvol(sndSewerPipeBreak, random_range(0.7, 0.9), 0.3), 0.1);
	audio_sound_gain(sound_play_gun(sndNothingHurtHigh, 0.1, 0.3), 0.6, 0);
	
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
	
#define AcidRocket_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "AcidRocket";
		
		 // Visual:
		sprite_index = global.sprAcidRocket;
		depth = 0;
		
		 // Vars:
		mask_index = mskBullet1;
		damage = 18;
		force = 8;
		typ = 2;
		time = 6;
		
		 // Events:
		on_step = script_ref_create(AcidRocket_step);
		on_draw = script_ref_create(AcidRocket_draw);
		on_destroy = script_ref_create(AcidRocket_destroy);
		
		return self;
	}
	
#define AcidRocket_step
	
	if(time > 0){
		time -= current_time_scale;
		if(time <= 0){
			
			sound_play(sndRocketFly);
		}
	}
	else{
		
		 // Accelerate:
		speed = min(speed + current_time_scale, 12);
		
		 // Smoke:
		if(visible && random(4) < current_time_scale){
			instance_create(x, y, Smoke);
		}
	}
	
	
	 // Sucks:
	if(place_meeting(x, y, Explosion)){
		instance_destroy();
	}
	
#define AcidRocket_draw
	draw_self();
	
	if(time <= 0){
		draw_sprite_ext(sprRocketFlame, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	}
	
#define AcidRocket_destroy

	 // Acid:
	repeat(15){
		with(Acid_create(x, y)){
			creator = other.creator;
			team = other.team;
			
			direction = random(360);
			speed = random_range(3, 6);
			
			motion_add(other.direction, 4);
		}
	}
	
	 // Explosion:
	instance_create(x, y, Explosion);
	repeat(2){
		instance_create(x, y, SmallExplosion);
	}
	
	sleep(15);
	
	var o = random(360);
	for(var i = 0; i < 360; i += (360 / 3)){
		with(instance_create(x, y, AcidStreak)){
			sprite_index = global.sprAcidExplosionStreak;
			image_angle = o + i;
			direction = image_angle;
			speed = 4;
		}
	}
	
	 // Sounds:
	audio_sound_set_track_position(sound_play_pitchvol(sndPlantSnareTrapperTB, random_range(0.7, 0.9), 0.5), 0.25);
	audio_sound_set_track_position(sound_play_pitchvol(sndSewerPipeBreak, random_range(0.7, 0.9), 0.3), 0.1);
	
	sound_play_pitch(sndExplosion, random_range(0.9, 1.1));
	audio_sound_gain(sound_play_pitch(sndEnergyHammer, 0.5), 0, 200);
	
	
#define AcidRipple_create(_x, _y)
	with(instance_create(_x, _y, CustomObject)){
		name = "AcidRipple";
		 
		 // Visual:
		image_blend = c_yellow;
		 
		 // Vars:
		radius = 24;
		width = 12;
		
		 // Events:
		on_step = script_ref_create(AcidRipple_step);
		on_draw = script_ref_create(AcidRipple_draw);
		
		return self;
	}
	
#define AcidRipple_step
	radius += (current_time_scale * 3);
	
	width -= (current_time_scale * 2);
	if(width <= 0){
		
		instance_destroy();
	}
	
#define AcidRipple_draw
	draw_set_color(image_blend);
	draw_primitive_begin(pr_trianglestrip);
	
	var o = 360 / round((2 * pi * radius) / 10);
	for(var i = 0; i <= 360; i += o){
		var r = (radius - width);
		
		draw_vertex(x + lengthdir_x(r, i),		y + lengthdir_y(r, i));
		draw_vertex(x + lengthdir_x(radius, i), y + lengthdir_y(radius, i));
	}
	
	draw_primitive_end();
	draw_set_color(c_white);
	
#define Acid_create(_x, _y)
	with(instance_create(_x, _y, CustomProjectile)){
		name = "Acid";
		
		 // Name:
		sprite_index = global.sprAcid;
		image_index = irandom(3);
		image_speed = 0;
		image_angle = random(360);
		depth = 2;
		
		var _scale = random_range(1/3, 1);
		image_xscale = _scale * choose(-1, 1);
		image_yscale = _scale * choose(-1, 1);
		
		 // Vars:
		mask_index = mskSuperFlakBullet;
		friction = 0.8;
		damage = 2;
		force = 0;
		typ = 0;
		time = random_range(90, 110);
		
		 // Mod Compat:
		ammo_type = 4;
		
		 // Events:
		on_step = script_ref_create(Acid_step);
		on_draw = script_ref_create(Acid_draw);
		on_wall = script_ref_create(Acid_wall);
		on_hit = script_ref_create(Acid_hit);
		
		return self;
	}
	
#define Acid_step
	image_angle += (current_time_scale / 3);
	
	if(visible){
		
		 // Effects:
		if(random(75) < current_time_scale && speed <= 0){
			with(instance_create(x + (image_xscale * orandom(6)), y + (image_yscale * orandom(6)), PlasmaTrail)){
				sprite_index = global.sprAcidBubble;
				depth = 0;
			}
		}
	
		 // Drawing:
		if(!instance_exists(global.acid_draw)){
			global.acid_draw = script_bind_draw(draw_acid, depth, false);
		}
		
		if(global.acid_draw.depth > depth){
			global.acid_draw.depth = depth;
		}
		
		 // Bloom:
		if(!instance_exists(global.acid_bloom_draw)){
			global.acid_bloom_draw = script_bind_draw(draw_acid, -6, true);
		}
	}
	
	 // Shrink:
	time -= current_time_scale;
	if(time <= 0){
		image_alpha -= (current_time_scale / 60);
		if(image_alpha <= 0.8){
			
			instance_create(x, y, Smoke);
			
			 // Goodbye:
			instance_destroy();
		}
	}
	
#define Acid_draw
	
#define Acid_wall
	with(other){
		instance_create(x, y, FloorExplo);
		instance_destroy();
	}
	
	speed *= 0.8;
	
	view_shake_at(x, y, 4);
	sleep(15);
	
#define Acid_hit
	if(projectile_canhit_melee(other)){
		projectile_hit_push(other, damage, force);
	}

#define draw_acid
	var _bloom = (argument_count <= 0) ? false : argument0;

	// trace_time();
	var _inst = instances_matching(instances_matching(CustomProjectile, "name", "Acid"), "visible", true);
	if(array_length(_inst)){
		
		if(!surface_exists(global.acid_surf)){
			global.acid_surf = surface_create(game_width, game_height);
		}
		
		surface_set_target(global.acid_surf);
		draw_clear_alpha(0, 0);
		draw_set_blend_mode(bm_add);
		
		 // Draw Instances:
		d3d_set_projection_ortho(view_xview_nonsync, view_yview_nonsync, game_width, game_height, 0);
		
		with(_inst){
			if(_bloom){
				image_xscale *= 2;
				image_yscale *= 2;
			}
			
			draw_self();
			
			if(_bloom){
				image_xscale /= 2;
				image_yscale /= 2;
			}
		}
		
		draw_reset_projection();
		
		draw_set_alpha_test(true);
		draw_set_alpha_test_ref_value(255 * 0.9);
		
		 // Bloom Drawing:
		if(_bloom){
			if(!surface_exists(global.acid_bloom_surf)){
				global.acid_bloom_surf = surface_create(game_width, game_height);
			}
			
			surface_set_target(global.acid_bloom_surf);
			draw_clear_alpha(0, 0);
			
			draw_surface(global.acid_surf, 0, 0);
			
			surface_reset_target();
			draw_set_alpha_test(false);
			
			draw_set_fog(true, global.acid_color_a, 0, 0);
			draw_set_alpha(0.1);
			
			draw_surface(global.acid_bloom_surf, view_xview_nonsync, view_yview_nonsync);
			
			draw_set_alpha(1);
			draw_set_blend_mode(bm_normal);
		}
		
		 // Normal Drawing:
		else{
			
			surface_reset_target();
			draw_set_blend_mode(bm_normal);
			
			 // Draw Darker Color:
			draw_set_fog(true, global.acid_color_b, 0, 0);
			draw_surface(global.acid_surf, view_xview_nonsync, view_yview_nonsync + 1);
			
			 // Draw Lighter Color:
			draw_set_fog(true, global.acid_color_a, 0, 0);
			draw_surface(global.acid_surf, view_xview_nonsync, view_yview_nonsync);
			
			draw_set_alpha_test(false);
		}
		
		draw_set_fog(false, c_white, 0, 0);
	}
	// trace_time("acid")

    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);