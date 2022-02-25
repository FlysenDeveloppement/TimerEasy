--[[
	API:
	  Documentation: https://devforum.roblox.com/t/tablecare-v-101-module-to-manage-tables-more-easier/1533465
	  Version: 1.0.0
	  
	 
	License: 
	
	  Licenced under the MIT licence.     
	  		MIT License
			Copyright (c) 2021 Tom Flysen
			Permission is hereby granted, free of charge, to any person obtaining a copy
			of this software and associated documentation files (the "Software"), to deal
			in the Software without restriction, including without limitation the rights
			to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
			copies of the Software, and to permit persons to whom the Software is
			furnished to do so, subject to the following conditions:
			The above copyright notice and this permission notice shall be included in all
			copies or substantial portions of the Software.
			THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
			IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
			FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
			AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
			LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
			OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
			SOFTWARE.
	  
	Authors:
	
	  Flysen (@Tom_minecraft) - Feburary 25th, 2021 - Created the file.    
--]]


local Timer = {}
Timer.__index = Timer

local Signal = require(script.Signal)

function Timer.new(second:number)
	if not second then error(debug.traceback("Missing seconds (number type) arguments.")) end
	
	local self = setmetatable({}, Timer)
	self.Time = second
	self.BaseTime = second
	self.IsPlaying = false
	self.TimeChanged = Signal.new()
	
	return self
end

function Timer:Play()
	if not self.IsPlaying then
		self.IsPlaying = true
		self.Time = self.BaseTime
		spawn(function()
			while self.IsPlaying and self.Time > 0 do
				self.Time = self.Time - 1
				self.TimeChanged:Fire(self.Time)
				wait(1)
			end
		end)
	else
		warn(debug.traceback("Timer is already playing."))
	end
end

function Timer:Pause()
	if self.IsPlaying then
		self.IsPlaying = false
	else
		warn(debug.traceback("Timer is already paused"))
	end
end

function Timer:Resume()
	if self.Time == 0 then
		warn(debug.traceback("Can't resume the Timer because the timer has ended."))
	else
		if self.IsPlaying == false then
			self.IsPlaying = true
			spawn(function()
				while self.IsPlaying and self.Time > 0 do
					self.Time = self.Time - 1
					self.TimeChanged:Fire(self.Time)
					wait(1)
				end
			end)
		else
			warn(debug.traceback("Timer is already playing."))
		end
	end
end

function Timer:AddTime(secondsToAdd:number)
	if not secondsToAdd then error(debug.traceback("Missing 1 arguments to play the function.")) end
	
	self.Time = self.Time + secondsToAdd
end

function Timer:Stop()
	self.IsPlaying = false
	self.Timer = self.BaseTime
end

return Timer
