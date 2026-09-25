*by Gpssickle! :D*

<h1 align="center">Gravel.cc</h1>

![Gravel :D](https://i.imgur.com/T8azxCr.png)


<p align="center">A "simple" .lua script that you guys would definitely like! Called "Gravel.cc" or "G.cc" or something</p>

*(Formerly "HBSS")*

---

This is the official repository for Gravel.cc!

Im mostly active on [YOUTUBE](https://youtube.com/@gpssickle?si=H0dugKCbTpV_yGK7) or [SCRIPTBLOX](https://scriptblox.com/u/Gpssickle) if you guys want to see my random scripts :3

**Warner**: Gravel.cc is still underdevelopment so elements/feats can change or become missing/unavailable & bugs can occur.

---

# Loading G.cc

![Loader](https://i.imgur.com/jrSilTP.png)

When executing the loadstring, you'll get these '2' buttons:

---

<img src="https://i.imgur.com/aFTF0OI.png" width="30" alt= "desc">
"LEGACY VERSION"

---

<img src="https://i.imgur.com/zfdignn.png" width="30" alt= "desc">
"NEW VERSION"


---

you could either choose a more deprecated version of Gravel.cc or a new & updated version.

# Loadstrings

Raw Loadstring:

*(Cached by GitHub.)*
```lua
local url = "https://raw.githubusercontent.com/hm5650/HBSS/refs/heads/main/HBSS.lua"

local req = request or http_request or (syn and syn.request)
local data
if req then
	local res = req({
		Url = url,
		Method = "GET"
	})
	if res and res.Body then
		data = res.Body
	end
else
	pcall(function()
		data = game:HttpGet(url)
	end)
end
if data then
	loadstring(data)()
else
	warn("gravel.cc phailed to load :(")
end
```

---

API Loadstring:

*(Bypasses GitHub cache.)*
```lua
local a,b,c,g="/hm5650/HBSS/","/HBSS.lua",".github","https://"
local d=request({Url=`{g}api{c}.com/repos{a}contents{b}`,Headers={Accept=`application/vnd{c}.VERSION.raw`}})
if d.StatusCode~=200 then
    d.Body=game:HttpGet(`{g}raw{c}usercontent.com{a}refs/heads/main{b}`)
end
local e,f=loadstring(d.Body)
if not e then warn(f) else e() end
```

---

# Tabs TL;DR

A quick-references of features that Gravel.cc has :p

---

## MainTab

- AntiKick - Blocks server kicks (needs hookmetamethod)
- TeamTarget - Enemies / Teams / All / Specific Team
- Specific Teams - Pick which teams to target (multi-select)
- TargetType - Players / NPCs / Both
- GetTarget - Closest / Lowest Health / TargetSeen
- Targetseen Switch Rate - Delay between target switches
- Ignore Forcefield - Skip spawn-protected players
- Indicator UI - Small HUD showing current target + features
  - Draggable, Always Visible, Size slider, Reset Position
- QuickToggles - Mobile-friendly toggle buttons
  - Selection dropdown, Draggable toggle, Size slider
- Keybinds - Enable/disable, HoldKey mode, custom key per feature
- AutoFarm - Toggle, Align Part, TP Max Range, TP Distance, Vertical Offset
- Optimization - Copy-paste FPS/network optimizer code
- Updaters speed / Updaters - Performance vs accuracy
- Cache Cleaners - Clear target cache interval
- Save/Load
  - New Save, Load Save, Delete Save, Delete All Saves
  - Autoload on Game, Remove Autoload
  - Saves List + Autoload List paragraphs

---

## VisualsTab

- ESP Master Toggle - Enables all ESP features
- ESP Hertz - Refresh rate for ESP updates
- Scoper - What to scan: Humanoids / ClickDetectors / TouchInterests / ProximityPrompts / Tools
- Tracer Start Position - Center / Bottom / Top / corners
- Tracer ESP Only Targets - Only draw lines to current target
- ESP Colour Based On Health - Color shifts with HP
- ESP Components
  - Highlight ESP, Text ESP, Box ESP, Health ESP, Head Dot ESP, Tracer ESP
- Scene
  - Brightness slider, ClockTime slider, Skybox Changer, Kill Lighting button
  - FOV toggle + FOV value slider
- ESP Colors - ESP, Target, Team, Tracer Line
- SA1 FOV Colors - SilentAim (HB) ring normal + target
- SA2 FOV Colors - SilentAim (HK) ring normal + target
- Aimbot FOV Colors - Ring normal + target
- TriggerBot FOV Colors - Ring normal + target
- Hitbox Colors - Visualizer color
- Reach Colors - Visualizer color
- Theme - UI theme dropdown, transparency slider, Tag TextCursor inputs, Save/Reload UI settings

---

## AntiAimTab

- AntiAim Master Toggle
- Modes (pick one):
  - Raycast AntiAim - TP when aimed at
  - Above Player - hover above nearest enemy
  - Behind Player - TP behind nearest enemy
  - Orbit Players - circle nearest enemy
- Settings
  - Teleport Distance (Raycast)
  - Above Height
  - Behind Distance
  - Orbit Speed / Radius / Height
- SpinBot - Toggle + speed slider
- Desync - Toggle + transparency slider

---

## AimbotTab

- Aimbot Toggle
- WallCheck - Raycast visibility check
- 360° Aimbot - No FOV limit
- Target Part - Head / HumanoidRootPart
- Aim Method - CFrame / MouseMoveRel / Camera / MouseMove / Teleport
- Aim Strength - 0 (none) to 1 (instant snap)
- Prediction - Lead target movement
- Aimbot Hertz - Update rate
- FOV Radius - Screen-space aim circle
- Target Range - Max world distance

---

## SilentAimTab (HB)

- SilentAim (HB) Toggle
- WallCheck - Don't shoot through walls
- Scale To Screen - Hitbox grows with distance
- STS Distance - Prevents clipping into you
- Target Part - Random / Head / HumanoidRootPart
- Target Range - Max distance
- HitChance - 0-100%
- Headshot Chance - Only for Random part
- Responsiveness - Update interval
- FOV Radius - Ring size
- Hitbox Transparency - Visual transparency

---

## SilentAimTab2 (HK)

- SilentAim (HK) Toggle
- WallCheck - Visibility check (may lag)
- WallBang - Shoot through walls
- Bullet Teleport - Spawn bullet at target
- 360 Mode - Ignore FOV
- Target Part - Random / Head / HumanoidRootPart
- Aim Methods - Raycast / FireServer / InvokeServer / Mouse.Hit (multi)
- Hit Chance - 0-100%
- Headshot Chance - For Random part
- Prediction - Lead movement
- Responsiveness - Update interval
- FOV Radius / Target Range
- Remote Gestalt - Custom remote name patterns
- Detected Remotes - Live list of matched remotes

---

## HitboxTab

- Hitbox Toggle
- Hitbox Size - 1 to 500
- Hitbox Visualizer
  - Toggle, Shape (Block/Sphere), Material (7 options), Transparency slider

---

## ReachTab

- Reach Toggle
- Reach Type - Sphere / Flat
- Reach Distance - Input field
- Show Visualizer - Toggle
- Visualizer Material - 7 options
- Visualizer Transparency - Slider
- Auto Activate - Auto-click tools
- Activate Delay - Slider

---

## ClientTab

- ClientMods Toggle
- Noclip - Walk through parts
- Flight - Creative-style fly + speed slider
- Walkspeed - Toggle + slider
- TPWalk - Teleport-walk + speed slider
- Infinite Jump - Toggle
- Jumppower - Toggle + slider
- Gravity - Toggle + slider
- HipHeight - Toggle + slider
- Truss - Ladder fly
- Airwalk - Walk on air
- Auto Respawn - Respawn at death position

---

## WorldTab

- ProxPrompts Mods - Hold Duration, Max Activation, Max Indicator
- X-Ray - Toggle, Transparency, Blacklist (multi)
- Interactions
  - Function 2 Fire (TouchInterest / ClickDetectors / ProximityPrompts / Remotes)
  - Fire All Once, Loop Fire All, Interval slider

---

## MiscTab

- TriggerBot - Toggle, Wall Check, Target Part, FOV Radius, Hit Chance, Shoot Delay, PressDown
- BHop - Bunny hop toggle
- AntiAfk - Prevent idle kick
- Cframe View - Spectate enemies + Zoom slider
- WallOver (Cam-Y) - Shoot over walls + Offset slider

*- Script Buttons (pls ignore): badapple, bringparts, Brick.cc, cookie, pop-up, notif, fling, invistool*

---

## BGMTab

- Play Music Toggle
- Add Music - ID + Title inputs
- Select Music - Dropdown
- Delete Selected - Remove custom tracks
- Volume / Pitch - Sliders
- Save / Reload - Persist music settings

---

## DevTab

- Statistics Paragraph - FPS, ping, memory, uptime, errors/warnings
- Console Output - Live LogService feed
  - Filter: Show Prints / Warnings / Errors
  - Clear Console, Copy Console Log
- Lua Code Runner - Input, Run Code, Execution Output, Clear Output
- Utilities
  - Open Developer Console
  - Reset Stats
  - Re-hook SilentAim (HK)
  - Force Rescan Players

---

## InfoTab

- Support Section - Social links, profile, game link
- About Section - What Gravel is
- Tabs Overview - Description of every tab
- Guide Section - Full tutorials for:
  - Setup, SilentAim (HB), SilentAim (HK), Hitbox, Aimbot, AntiAim, AutoFarm, ESP, ClientMods, TriggerBot, Keybinds, Save/Load, Troubleshooting, Known Limitations
- Credits - WindUI, Alurt, Redliner
- Update Log - Full version history

---

## Default Keybinds

| Key | Feature |
|-----|---------|
| E | SilentAim (HB) |
| R | SilentAim (HK) |
| Q | Aimbot |
| F | AutoFarm |
| L | AntiAim |
| J | Desync |
| X | TriggerBot |
| V | BHop |
| G | Hitbox |
| Z | ESP |
| N | ClientMods |
| B | SilentAim (HB) WallCheck |
| H | Aimbot WallCheck |
| U | SilentAim (HK) WallCheck |
| Y | TriggerBot WallCheck |
| LeftAlt | HoldKey modifier |

---

## Quick Notes

- Semi-universal, works on most generic shooters, not all games
- Keyless & free & open source
- HK features need hookmetamethod + hookfunction
- Not mobile friendly for TriggerBot
- Autoload remembers a save per PlaceId

---

**Gravel.cc:**

<details>
  <summary>Active Tabs</summary>

  1. MainTab
  2. VisualsTab
  3. AntiAimTab
  4. AimbotTab
  5. SilentAimTab (HB)
  6. SilentAimTab2 (HK)
  7. HitboxTab
  8. ReachTab
  9. ClientTab
  10. WorldTab
  11. MiscTab
  12. BGMTab
  13. DevTab
  14. InfoTab
</details>

<details>
  <summary>Unactive Tabs</summary>

  1. BotTab
</details>

<details>
  <summary>Files</summary>

  >Executor Workspace - your injector's workspace :p
  
  V
  
  >Gravel_Saves - stores .JSON Save files here!
  
  V
  
  >assets - stores other .JSON files
</details>

---

***Gpssickle:***

<details>
  <summary>Links</summary>

  1. [YouTube; Main Channel](https://youtube.com/@gpssickle?si=9bBIhhY7-nt2Ot7J)
  2. [YouTube; Second Channel](https://www.youtube.com/@gpszickle)
  3. [RScripts](rscripts.net/@Gpssickle)
  4. [Scriptblox](https://scriptblox.com/u/Gpssickle)
  5. [Roblox](roblox.com/users/8517361356/profile)
</details>

---

## Gallery

random art that appears when I'm bored :7

--

<img src="https://i.imgur.com/6ns17nM.png" width="200" alt= "coolart">
<img src="https://i.imgur.com/VYd7IcR.png" width="200" alt= "anothercoolart">
<img src="https://i.imgur.com/tk1YXYL.png" width="200" alt= "anotheranothercoolart">
<img src="https://i.imgur.com/i3GLMLs.png" width="200" alt= "anotheranotheranothercoolart">
<img src="https://i.imgur.com/yGHxiTq.png" width="200" alt= "anotheranotheranotheranothercoolart">

pretty cool art right :3

---

<img src="https://i.imgur.com/ORn8h9o.png" width="100" alt= "colonthree">

<p align="center">
  <i>"yway :3"</i><br>
  ㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤ- Gpssickle
</p>
