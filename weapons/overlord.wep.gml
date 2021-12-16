#define init
    global.sprWep = sprite_add_weapon("../sprites/weapons/sprOverlord.png", 7, 8);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "OVERLORD";
#define weapon_text return choose("MORE BULLET PER BULLET", "RIVER OF LEAD");
#define weapon_type return 1; // Bullet
#define weapon_cost return 2;
#define weapon_load return 2;
#define weapon_area return -1;
#define weapon_auto return true;
#define weapon_swap return sndSwapMachinegun;

#define weapon_reloaded
	 // The Shells:
	repeat((ceil((current_frame / 60)) % 7) + 1){
		with(instance_create(x, y, Shell)){
			direction = other.gunangle + orandom(30) + 180;
			speed	  = 3 + random(2);
		}
	}

#define weapon_fire(_wep)
	var n = (ceil((current_frame / 60)) % 7) + 1,
		o = (n < 2 || n > 3);
	
	if(o){
		with(instance_create(x, y, Bullet1)){
			creator = other;
			team = other.team;
			direction = other.gunangle + (other.accuracy * orandom(4));
			image_angle = direction;
			speed = 16;
		}
	}	
	
	if(n > 1){
		var l = (o ? 12 : 6);
		for(var i = 0; i < 360; i += (360 / (n - o))){
			var d = i + (current_frame * 10);
	 		
	 		with(instance_create(x + lengthdir_x(l, d), y + lengthdir_y(l, d), Bullet1)){
				creator = other;
				team = other.team;
				direction = other.gunangle + (other.accuracy * orandom(4));
				image_angle = direction;
				speed = 16;
			}
		}
	}
	
	weapon_post(12, 16, 8);
	motion_add(gunangle + 180, 1.2);
	sleep(15);
	
    audio_sound_set_track_position(sound_play_pitchvol(sndGuitarHit7, random_range(0.7, 0.9), 0.8), 0.2);
	audio_sound_set_track_position(sound_play_pitchvol(sndStatueCharge, random_range(0.7, 0.9), 0.5), 1.3);
	sound_play_pitchvol(sndBecomeNothingHurt, 1.2, 0.4);
	
	audio_sound_pitch(sound_play_gun(sndDoubleMinigun, 0, ((n > 2) ? -0.5 : 0.3)), 0.8);
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);