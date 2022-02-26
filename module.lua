--[[
	API:
	  Documentation: https://devforum.roblox.com/t/timereasy-a-module-to-make-timer-more-easy/1681642
	  Version: 1.0.1
	  
	 
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
	if not second or not typeof(second) == "number" then second = 0 end
	
	local self = setmetatable({}, Timer)
	self.Time = second
	self.BaseTime = second
	self.IsPlaying = false
	self.SecondMultiplier = 1
	self.SpeedTime = 1
	self.TimeChanged = Signal.new()
	
	function self:Play()
		if not self.IsPlaying then
			self.IsPlaying = true
			self.Time = self.BaseTime
			spawn(function()
				while self.IsPlaying and self.Time > 0 do
					self.Time = self.Time - self.SecondMultiplier
					self.TimeChanged:Fire(self.Time)
					wait(self.SpeedTime)
				end
			end)
		else
			warn(debug.traceback("Timer is already playing."))
		end
	end

	function self:Pause()
		if self.IsPlaying then
			self.IsPlaying = false
		else
			warn(debug.traceback("Timer is already paused"))
		end
	end

	function self:Resume()
		if self.Time == 0 then
			warn(debug.traceback("Can't resume the Timer because the timer has ended."))
		else
			if self.IsPlaying == false then
				self.IsPlaying = true
				spawn(function()
					while self.IsPlaying and self.Time > 0 do
						self.Time = self.Time - self.SecondMultiplier
						self.TimeChanged:Fire(self.Time)
						wait(self.SpeedTime)
					end
				end)
			else
				warn(debug.traceback("Timer is already playing."))
			end
		end
	end

	function self:AddTime(secondsToAdd:number)
		if not secondsToAdd then error(debug.traceback("Missing 1 arguments to play the function.")) end
		if not typeof(secondsToAdd) == "number" then error(debug.traceback("The secondsToAdd arguments must be a number")) end

		self.Time = self.Time + secondsToAdd
	end

	function self:SkipTime(secondsToSkip:number)
		if not secondsToSkip then error(debug.traceback("Missing 1 arguments to play the function.")) end
		if not typeof(secondsToSkip) == "number" then error(debug.traceback("The secondsToSkip arguments must be a number")) end

		self.Timer = self.Timer - secondsToSkip
	end

	function self:SetSecondMultiplier(newMultiplier:number)
		if not newMultiplier then newMultiplier = 1 end
		if not typeof(newMultiplier) == "number" then error(debug.traceback("The newMultiplier arguments must be a number")) end

		self.SecondMultiplier = newMultiplier
	end

	function self:SetSpeedTime(newMultiplier:number)
		if not newMultiplier then newMultiplier = 1 end
		if not typeof(newMultiplier) == "number" then error(debug.traceback("The newMultiplier arguments must be a number")) end

		self.SpeedTime = newMultiplier
	end

	function self:Stop()
		self.IsPlaying = false
		self.Timer = self.BaseTime
	end
	
	return self
end

return Timer
