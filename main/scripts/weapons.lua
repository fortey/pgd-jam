local M ={}

local camera = require "orthographic.camera"
local CAMERA_ID = hash("/camera")

M["gun"] = {
	name = "gun",
	sprite = hash("char_gun"),
	fire_anim = hash("char_gun_fire"),
	time_between_atack = 0.1,
	ammunition  = 100,
	clip_capacity = 12,
	catridges = 12,
	reload_time = 1,
	show_reload_between_attack = false,
	shoot = function(self, go)
		local crosshair_world = go.get_position("crosshair")
		local player_world = go.get_position()
		local offset = vmath.normalize(crosshair_world - player_world) * 5
		
		local offset = vmath.rotate(go.get_rotation(), vmath.vector3(2, 28, 0))
		factory.create("#shoot_factory", go.get_position() + offset)

		sound.play("#shoot")
		camera.recoil(CAMERA_ID, offset, 0.03)
	end
}

M["shotgun"] = {
	name = "shotgun",
	sprite = hash("char_shotgun"),
	fire_anim = hash("char_shotgun_fire"),
	time_between_atack = 0.5,
	ammunition  = 100,
	clip_capacity = 6,
	catridges = 6,
	reload_time = 1,
	show_reload_between_attack = true,
	shoot = function(self, go)
		local crosshair_world = go.get_position("crosshair")
		local player_world = go.get_position()
		local offset = vmath.normalize(crosshair_world - player_world) * 5
		
		local rotation = go.get_rotation()
		local offset = vmath.rotate(rotation, vmath.vector3(2, 28, 0))

		local rotate_step = self.spread_angle/5
		for i = -5,5,1 do 
			factory.create("#shoot_factory", player_world + offset, rotation*vmath.quat_rotation_z(i*rotate_step), {speed = math.random(800, 1300), lifetime = 0.4})
		end

		sound.play("#shoot")
		camera.recoil(CAMERA_ID, offset, 0.08)
	end
}
return M