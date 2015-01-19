*The very core of a space simulator.*

The first-place winner of the 2014 Fall Kapparate 5K competition.  
Getting over 16000 views in a month, Singularity itself was written over the course of a month.

As quoted by Kapparate,

> The KTByte 5k is a competition to write a Processing app in less than 5 kilobytes. The wining project, Singularity by Willy Wu, is a space simulator, where the play uses the mouse and keyboard to move (Cursor pitches/yaws, WASD/Space/C are thrusters, Q/E rolls, X stops). Clicking fires the weapon. The browser compatability and playability of this application were both flawless. The program was also technically complex, requiring a four dimensional vector class to maintain the state of each object. The addition of a beautiful 3d radar ensured this project's first place position.

**Instructions**

Use the mouse cursor to pitch and yaw. Hold the mouse button to fire main weapons.
Use WASD to engage lateral thrusters. Use Space and C to engage vertical thrusters.
Use Q and E to roll. X slows the craft to a stop.

If you take critical damage or crash into another object, your screen will go dark and you will re-spawn in your initial location.

Note: Transparency effects used in the radar and shield indicator will only work in the Java version of Processing.

**Ship manual**

Your ship is equipped with a fly-by-wire system, using a flight computer to compute the desired trajectory and stabilize the craft.

Attention: if you experience high g-forces while pitching too quickly or accelerating vertically, you may experience difficulty seeing. This is caused by the blood rushing towards or away from your head, and at higher forces may cause temporary loss of vision known as blackout.

Near the bottom of the cockpit, you may notice your ship's radar, which registers objects within 2 kilometers. White points represent space debris and red points represent enemy spacecraft. The vertical lines drawn from points to the equatorial plane represent how far above or below these detected objects lie relative to your ship. Pay close attention to the radar to avoid colliding with nearby objects and to detect enemies behind, above, or below you.

Surrounding your ship is a recharging shield. The shield's current charge status is displayed as a bar near the top of the cockpit. After sustaining damage, it may take a moment before the shields begin recharging - this is normal behavior. Once your shield is fully depleted, you are completely vulnerable to enemy fire.
