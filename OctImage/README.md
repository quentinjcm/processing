# OctImage

While I was working on the colour quantization sketch, I wanted to try using some octree quantization and so I built a class to filter the pixels of an image into a tree. The trouble was, I had no idea if it was working or not so I decided to write a 3d viewer for visualizing the tree. This sketch is that viewer. And hey, it turns out that you get some quie interesting results when you visualize images as 3d tree structures :D

[pictures coming soon]

This was my first foray into 3D graphics in processing, and, using the trusty example sketches, it was actually quite easy. Or at least it would have been if I hadn't gone down the rabbit hole of creating my own camera class... and my camera needed matricies, so I wrote some functions for those as well... My cameras also had to be stored and organised for switching between views so I wrote a viewport class to hold the cameras. All in all I'm pretty happy with they way it turned out, the tumbeling is pretty logical (almost) and it all feels relatively neat and tidy (we'll see if I still think that in a month or two when I need to come back to this sketch...)

One thing I was particularly supprised by was the frame rate drop when I turn on wireframe mode, I guess those wires are pretty heavy...