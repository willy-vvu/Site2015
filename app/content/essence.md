*Racing, distilled.*

A minimalistic racing game written in Processing in under 5000 bytes for the Kapparate 5K competition.

I tried to create a sense of scale and an atmospheric world that would seem nearly impossibe within only five kilobytes. This meant that I needed to use procedural generation. In the beginning of each run, a random 2D array is generated. In order to save more space, I re-used the same array to randomly generate both the terrain and clouds.

However, I wanted the track to remain the same each time for a consistent racing experience. That meant storing the track in the source code itself. I used Blender to model the track, rendering it into a depth map viewed from above. Then, I wrote my own string compression algorithm toh compress the image into a string that could be included in the source code.

With the components of the world in place, I moved onto the water. I was able to achieve a pseudo-reflection by adding twice the number of world objects twice - one above the water, and the other a perfect mirror reflection. In between the two, I inserted a partially-transparent plane, which gave the relfected objects a bluish tinge. The results looked surprisingly nice!
