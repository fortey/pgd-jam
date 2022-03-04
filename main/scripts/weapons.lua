local M ={}

local camera = require "orthographic.camera"
local CAMERA_ID = hash("/camera")

M["gun"] = {
	sprite = hash("char_gun"),
	shoot = function(self, go)
		local crosshair_world = go.get_position("crosshair")
		local player_world = go.get_position()
		local offset = vmath.normalize(crosshair_world - player_world) * 5
		
		local offset = vmath.rotate(go.get_rotation(), vmath.vector3(2, 28, 0))
		factory.create("#shoot_factory", go.get_position() + offset)

		sound.play("#shoot")
		camera.recoil(CAMERA_ID, offset, 0.2)
	end
}

M["shotgun"] = {
	sprite = hash("char"),
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
		camera.recoil(CAMERA_ID, offset, 0.4)
	end
}
return M