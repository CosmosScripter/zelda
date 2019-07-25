minetest.register_craftitem("zelda:key", {
	description = "Key",
	inventory_image = "key.png",
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" then
		    	local pos1 = pointed_thing.under
			local pos3 = {x=pos1.x, y=pos1.y + 1, z=pos1.z}
			local pos2 = {x=pos1.x, y=pos1.y - 1, z=pos1.z}
   			local node_name = minetest.get_node(pos1).name
    			if node_name =="doors:door_steel_t_1" then
				minetest.env:remove_node(pos1)
				minetest.env:remove_node(pos2)
				nodeupdate(pos1)
				nodeupdate(pos2)
		 		minetest.sound_play("secret", pos1)
				if minetest.setting_getbool("creative_mode") then
					itemstack:take_item()
				else 
					itemstack:take_item()
				end
				return itemstack
			elseif node_name=="doors:door_steel_b_1" then
				minetest.env:remove_node(pos1)
				minetest.env:remove_node(pos3)
				nodeupdate(pos1)
				nodeupdate(pos3)
		 		minetest.sound_play("secret", pos1)
				if minetest.setting_getbool("creative_mode") then
					itemstack:take_item()
				else 
					itemstack:take_item()
				end
				return itemstack
			end
		end
	
	end,
})

minetest.register_node("zelda:chest", {
	description = "Treasure Chest",
	inventory_image = "treasure_img.png",
	tiles = {
		"surprise_top.png",
		"surprise_top.png",
		"surprise_side.png",
		"surprise_side.png",
		"surprise_side.png",
		"surprise_front.png",
	},
	paramtype = "light",
	light_source = 5,
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.sound_play("surprise", pos)
		minetest.chat_send_player(clicker:get_player_name(), "<Chest> You got....")
		minetest.after(7.9, function()
			local choose = math.random(1,5)
			minetest.env:remove_node(pos)
			nodeupdate(pos)
			minetest.add_particlespawner({
				amount = 80,
				time = 0.1,
				minpos = {x=pos.x, y=pos.y, z=pos.z},
				maxpos = {x=pos.x, y=pos.y, z=pos.z},
				minvel = {x=-5, y=-5, z=-5},
				maxvel = {x=5, y=5, z=5},
				minacc = {x=0, y=-10, z=0},
				maxacc = {x=0, y=-10, z=0},
				minexptime = 1,
				maxexptime = 1,
				minsize = 1,
				maxsize = 1,
				collisiondetection = true,
				vertical = false,
				texture = "drop.png",
				})
			if choose == 1 then
				minetest.add_item(pos, "default:apple")
				minetest.chat_send_player(clicker:get_player_name(), "<Chest> AN APPLE!")
			elseif choose == 2 then
				minetest.add_item(pos, "default:diamond")
				minetest.add_item(pos, "default:gold_lump")
				minetest.add_item(pos, "default:steel_ingot")
				minetest.add_item(pos, "default:coal_lump")
				minetest.chat_send_player(clicker:get_player_name(), "<Chest> ORES!")
			elseif choose == 3 then
				minetest.add_item(pos, "bows:bow_obsidian")
				minetest.chat_send_player(clicker:get_player_name(), "<Chest> A BOW!")
			elseif choose == 4 then
				minetest.add_item(pos, "zelda:key")
				minetest.chat_send_player(clicker:get_player_name(), "<Chest> A KEY!")
			elseif choose == 5 then
				minetest.add_item(pos, "zelda:master_sword")
				minetest.chat_send_player(clicker:get_player_name(), "<Chest> THE MASTER SWORD!")
			end
		
		end)	
	end,
})

minetest.register_craft( {
	output = "zelda:chest",
	recipe = {
		{"", "default:gold_ingot", ""},
		{"default:gold_ingot", "default:chest", "default:gold_ingot"},
		{"", "default:gold_ingot", ""}
	}
})

minetest.register_tool("zelda:master_sword", {
    description = "Master Sword",
	inventory_image = "master_sword.png",
   	 stack_max = 1,
	tool_capabilities = {
		full_punch_interval = 0.05,
		max_drop_level=0,
		damage_groups = {fleshy=15},
		groupcaps={
				fleshy={time ={[2]=0.65, [3]=0.25}, uses=200, maxlevel=3},
				snappy={times={[2]=0.70, [3]=0.25}, uses=200, maxlevel=3},
				choppy={times={[3]=0.65}, uses=200, maxlevel=0}
		}
	}
})

minetest.register_node("zelda:pot", {
	description = "Pot",
	drawtype = "plantlike",
	tiles = {"pot.png"},
	paramtype = "light",
	inventory_image = "pot.png",
	visual_scale = 1.1,
	wield_scale = {x=1.1, y=1.1, z=1.1},
	groups = {choppy=3},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
	},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local chance = math.random(1,5)
		minetest.env:remove_node(pos)
		nodeupdate(pos)
		clicker:get_inventory():add_item("main", "zelda:pot1")
		minetest.sound_play("pick_pot", pos)
		if chance >= 3 then
			minetest.add_particlespawner({
				amount = 1,
				time = 0.1,
				minpos = {x=pos.x, y=pos.y, z=pos.z},
				maxpos = {x=pos.x, y=pos.y, z=pos.z},
				minvel = {x=-5, y=-5, z=-5},
				maxvel = {x=5, y=5, z=5},
				minacc = {x=0, y=-10, z=0},
				maxacc = {x=0, y=-10, z=0},
				minexptime = 3,
				maxexptime = 3,
				minsize = 2,
				maxsize = 2,
				collisiondetection = true,
				vertical = false,
				texture = "heart.png",
				})
			minetest.sound_play("heart", pos)
			clicker:set_hp(clicker:get_hp()+5)
		end

	end,
})

minetest.register_craftitem("zelda:pot1", {
	description = "Pot (throwable)",
	inventory_image = "pot.png",
	on_use = function(itemstack, user, pointed_thing)
			if not minetest.setting_getbool("creative_mode") then itemstack:take_item()
		end
		if pointed_thing.type ~= "nothing" then
			local pointed = minetest.get_pointed_thing_position(pointed_thing)
			if vector.distance(user:getpos(), pointed) < 8 then
				return itemstack
			end
		end
		local pos = user:getpos()
		local dir = user:get_look_dir()
		local yaw = user:get_look_yaw()
		if pos and dir then
			pos.y = pos.y + 1.5
			minetest.sound_play("throw", pos)
			local obj = minetest.add_entity(pos, "zelda:pot_entity")
			if obj then
				obj:setvelocity({x=dir.x * 20, y=dir.y * 20, z=dir.z * 20})
				obj:setacceleration({x=dir.x * -3, y=-10, z=dir.z * -3})
				obj:setyaw(yaw + math.pi)
				local ent = obj:get_luaentity()
				if ent then
					ent.player = ent.player or user
				end
			end
		end
		return itemstack
	end,
})

local ZELDA_POT_ENTITY={
	physical = false,
	timer=0,
	visual = "sprite",
	visual_size = {x=0.5, y=0.5},
	textures = {"pot.png"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
}

ZELDA_POT_ENTITY.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)

	if self.timer > 0.12 then
		local objs = minetest.get_objects_inside_radius({x = pos.x, y = pos.y, z = pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "zelda:pot_entity" and obj:get_luaentity().name ~= "__builtin:item" then
					local damage = 5
					obj:punch(self.object, 1.0, {
						full_punch_interval = 1.0,
						damage_groups= {fleshy = damage},
					}, nil)
					minetest.sound_play("shatter", {pos = self.lastpos, gain = 0.8})
					self.object:remove()
				end
			else
				local damage = 5
				obj:punch(self.object, 1.0, {
					full_punch_interval = 1.0,
					damage_groups= {fleshy = damage},
				}, nil)
				minetest.sound_play("shatter", {pos = self.lastpos, gain = 0.8})
				self.object:remove()
			end
		end
	end

	if self.lastpos.x ~= nil then
		if minetest.registered_nodes[node.name].walkable then
			if not minetest.setting_getbool("creative_mode") then
				minetest.add_item(self.lastpos, "default:clay_brick")
				minetest.add_item(self.lastpos, "default:clay_lump")
			end
			minetest.sound_play("shatter", {pos = self.lastpos, gain = 0.8})
			self.object:remove()
		end
	end
	self.lastpos= {x = pos.x, y = pos.y, z = pos.z}
end
minetest.register_entity("zelda:pot_entity", ZELDA_POT_ENTITY)

minetest.register_craft( {
	output = "zelda:pot",
	recipe = {
		{"", "default:clay_brick", ""},
		{"default:clay_brick", "bucket:bucket_empty", "default:clay_brick"},
		{"", "default:clay_brick", ""}
	}
})

minetest.register_craftitem("zelda:navi", {
	description = "Navi",
	inventory_image = "fairy.png",
	on_use = function(itemstack, user, pointed_thing)
		if user:get_hp() <= 5 then
			local pos = user:getpos()
			minetest.add_particlespawner({
				amount = 1,
				time = 0.1,
				minpos = {x=pos.x, y=pos.y, z=pos.z},
				maxpos = {x=pos.x, y=pos.y, z=pos.z},
				minvel = {x=-2, y=-5, z=-2},
				maxvel = {x=2, y=10, z=2},
				minacc = {x=0, y=-1, z=0},
				maxacc = {x=0, y=-1, z=0},
				minexptime = 4,
				maxexptime = 4,
				minsize = 2,
				maxsize = 2,
				collisiondetection = true,
				vertical = false,
				texture = "fairy.png",
				})
			minetest.add_particlespawner({
				amount = 80,
				time = 0.1,
				minpos = {x=pos.x, y=pos.y, z=pos.z},
				maxpos = {x=pos.x, y=pos.y, z=pos.z},
				minvel = {x=-2, y=-5, z=-2},
				maxvel = {x=2, y=10, z=2},
				minacc = {x=0, y=-1, z=0},
				maxacc = {x=0, y=-1, z=0},
				minexptime = 1,
				maxexptime = 1,
				minsize = 1,
				maxsize = 2,
				collisiondetection = true,
				vertical = false,
				texture = "drop.png",
				})
			minetest.sound_play("navi", pos)
			user:set_hp(user:get_hp()+10)
			if not minetest.setting_getbool("creative_mode") then 
				itemstack:take_item()
			end
			return itemstack
		else
			local pos = user:getpos()
			local voice = math.random(1,5)
			if voice == 1 then
			minetest.sound_play("hello", pos)
			elseif voice == 2 then
			minetest.sound_play("hey", pos)
			elseif voice == 3 then
			minetest.sound_play("listen", pos)
			elseif voice == 4 then
			minetest.sound_play("look", pos)
			elseif voice == 5 then
			minetest.sound_play("watchout", pos)
			end
		end		
		
	end,
})


minetest.register_craft( {
	output = "zelda:navi",
	recipe = {
		{"", "default:mese_crystal_fragment", ""},
		{"default:mese_crystal_fragment", "zelda:pot", "default:mese_crystal_fragment"},
		{"", "default:mese_crystal_fragment", ""}
	}
})

minetest.register_craftitem("zelda:ocarina", {
	description = "Ocarina of Time",
	inventory_image = "ocarina.png",
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		local key = user:get_player_control()
		if key.sneak then
			time = minetest.get_timeofday()
			hp = user:get_hp()
			posoc = user:getpos()
			time_mel = true
			minetest.chat_send_player(user:get_player_name(), "<Ocarina Of Time> You will come back to this moment when you play the Song of Time.")
		elseif key.aux1 then
			local p = {
		                pos1 = {x=pos.x, y=pos.y+1, z=pos.z},
		                pos2 = {x=pos.x, y=pos.y-1, z=pos.z},
		                pos3 = {x=pos.x+1, y=pos.y, z=pos.z},
		                pos4 = {x=pos.x-1, y=pos.y, z=pos.z},
		                pos5 = {x=pos.x, y=pos.y, z=pos.z+1},
		                pos6 = {x=pos.x, y=pos.y, z=pos.z-1},
		                }
		        for k, v in pairs(p) do
		                if (minetest.get_node(v).name == "default:water_source" or minetest.get_node(v).name == "default:water_flowing") then
		 		minetest.sound_play("song_storms", pos)
				minetest.after(4.0, function()
					minetest.env:remove_node(v)
					minetest.chat_send_player(user:get_player_name(), "<Ocarina Of Time> You've played the Song of Storms.")
				end)	
		                end
		        end
		else
			if time_mel == true then
		 		minetest.sound_play("song_time", pos)
				minetest.after(9.0, function()
					user:setpos(posoc)
					user:set_hp(hp)
					minetest.set_timeofday(time)
					minetest.chat_send_player(user:get_player_name(), "<Ocarina Of Time> You've played the Song of Time.")
				end)
			else
				minetest.chat_send_player(user:get_player_name(), "<Ocarina Of Time> You must play another melody before trying this.")			
			end
		end
		
	end,
})

minetest.register_craft( {
	output = "zelda:ocarina",
	recipe = {
		{"", "default:mese_crystal", ""},
		{"default:mese_crystal", "zelda:navi", "default:mese_crystal"},
		{"", "zelda:master_sword", ""}
	}
})
--Treasures in Desert's Dungeons and Mines
dofile(minetest.get_modpath("zelda").."/mines.lua")

 minetest.register_ore({
     ore_type = "scatter",
     ore = "zelda:chest",
     wherein = "default:desert_stone",
     clust_scarcity = 35*35*35,
     clust_num_ores = 1,
     clust_size = 1,
     height_min = -500,
	height_max = -4,
})
