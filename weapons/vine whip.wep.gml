#define init
    var m = "../sprites/",
    	p = m + "weapons/";
    	
    global.sprWep = sprScrewDriver; //sprite_add_weapon("../sprites/weapons/sprBendyLaser.png", 4, 5);
    
    var p = m + "projectiles/";
    global.sprIceVine		= sprite_add(p + "sprIceVine.png",		3, 0, 8);
    global.sprIceVineStart	= sprite_add(p + "sprIceVineStart.png", 3, 0, 8);
    global.sprIceVineEnd	= sprite_add(p + "sprIceVineEnd.png",	3, 0, 8);
    
    var p = m + "effects/";
	global.sprIceVineLeaf = sprite_add(p + "sprIceVineLeaf.png", 3, 16, 16);
    
#define weapon_sprt return global.sprWep;
#define weapon_name return "VINE WHIP";
#define weapon_text return "";
#define weapon_type return 0; // Melee
#define weapon_cost return 0;
#define weapon_load return 12;
#define weapon_area return -1;
#define weapon_auto return true;
#define weapon_swap return sndSwapSword;
#define weapon_melee return false;

#define weapon_fire(_wep)
	
	 // Vine:
	with(mod_script_call("mod", "gunsies", "spawn_vine", x, y, self, random_range(4, 6), gunangle + (accuracy * orandom(20)))){
		creator = other;
		team = other.team;
		
		alarm1 = 30;
		
		if(instance_exists(child)){
			if(instance_exists(parent)){
				sprite_index = global.sprIceVine;
			}
			else{
				sprite_index = global.sprIceVineStart;
			}
			if(leaf_sprite != null){
				leaf_sprite = global.sprIceVineLeaf;
			}
		}
		else{
			sprite_index = global.sprIceVineEnd;
		}
		
		motion_add(direction, random_range(2, 3));
		motion_add(point_direction(other.x, other.y, x, y), random_range(3, 4));
	}
	
	weapon_post(7, 13, 7);
	
	 // Sounds:
	audio_sound_set_track_position(sound_play_pitch(sndWallBreakJungle, 1.5), 0.3);
	audio_sound_set_track_position(sound_play_pitchvol(sndPlantSnareTrapperTB, 0.55, 0.5), 0.25);
	sound_play_pitch(sndJungleAssassinAttack, 1.2);
    
#define orandom(_num) return irandom_range(-_num, _num);
#define obj_create(_x, _y, _name) return mod_script_call("mod", "gunsies", "obj_create", _x, _y, _name);