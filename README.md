##[AS3 Bitmap Snapshot](http://www.quietless.com/kitchen/dynamically-create-an-image-in-flash-and-save-it-to-the-desktop-or-server/)

####A simple utility class to draw any DisplayObject to an .png or .jpg
Also includes a sample php script that you can use to upload and save it to a server.
***
Example Usage
```actionscript
private function saveToDesktop():void
{    
var img.BitmapSnapshot = new BitmapSnapshot(displayObject, filename);
    img.saveToDesktop();
}
 
private function saveOnServer():void
{
var img:BitmapSnapshot = new BitmapSnapshot(displayObject, filename);
    img.saveOnServer(phpscript, destinationOnServer);
}
```
[Live Demo & More Information Here.](http://www.quietless.com/kitchen/dynamically-create-an-image-in-flash-and-save-it-to-the-desktop-or-server/)

This repository contains the full source for the demo on my website, [the actual BitmapSnaphot class is located here.](http://github.com/braitsch/as3-bitmap-snapshot/blob/master/libs/com/quietless/bitmap/BitmapSnapshot.as)