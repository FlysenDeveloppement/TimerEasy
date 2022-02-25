# TimerEasy

TimerEasy is a module to manage your timers more easier using some functions.

## Install
Installing TimerEasy is very simple. Move the module in the ReplicatedStorage and read the documentation below.

**Roblox Studio:**

1. Get [TimerEasy]() from the Roblox library.
2. Place the TimerEasy module into the ReplicatedStorage.

### Usage

First, get the module to your script
```lua
local TimerEasy = require(game:GetService("ReplicatedStorage").TimerEasy)
```

That would be the necessary code to create and manage the timer.

### How to create a timer?

Make a timer is really simple, use the function TimerEasy.new(seconds)
The seconds arguments must be a number or nil. If it's nil, the timer will set the seconds to 0 automatically.

```lua
local TimerEasy = require(game:GetService("ReplicatedStorage").TimerEasy)
local seconds = 60

local myTimer = TimerEasy.new(seconds)
```

Now, the timer is ready to be used.

### How to start it?
To start the timer, use the function myTimer:Play()
```lua
local TimerEasy = require(game:GetService("ReplicatedStorage").TimerEasy)
local seconds = 60

local myTimer = TimerEasy.new(seconds)
myTimer:Play()
```

### Pause, resume and stop function

To pause the timer, use the function myTimer:Pause().
```lua
local TimerEasy = require(game:GetService("ReplicatedStorage").TimerEasy)
local seconds = 60

local myTimer = TimerEasy.new(seconds)
myTimer:Play()
myTimer:Pause()
```

If you want to resume the timer, use the function myTimer:Resume().
```lua
local TimerEasy = require(game:GetService("ReplicatedStorage").TimerEasy)
local seconds = 60

local myTimer = TimerEasy.new(seconds)
myTimer:Play()
myTimer:Pause()
myTimer:Resume()
```
Disclaimer: If you use the function play to resume the timer, the timer will reset the seconds and if you use the function stop to pause the timer, you will set the seconds to the base seconds.

If you want to stop the function, just use the function myTimer:Stop()
```
local TimerEasy = require(game:GetService("ReplicatedStorage").TimerEasy)
local seconds = 60

local myTimer = TimerEasy.new(seconds)
myTimer:Play()
myTimer:Stop()
```

### Events

The function myTimer.TimeChanged(actualSeconds) is a function who is fired everytime the timer changes. 
```lua
local TimerEasy = require(game:GetService("ReplicatedStorage").TimerEasy)
local seconds = 60

local myTimer = TimerEasy.new(seconds)
myTimer:Play()

myTimer.TimeChanged:Connect(function(actualSeconds)
  print("My timer is now to "..actualSeconds.." seconds")
end)
```
