/**
 *  Version : 2.00 
 *  Last Updated : 12/11/2009
 *  ActionScript : 3.0
 *  Author : @braitsch
 *  Documentation : http://www.quietless.com/kitchen/upload-bitmapdata-snapshot-to-server-in-as3
**/

package com.quietless.bitmap {
	
	import com.adobe.images.*;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;

	public class BitmapSnapshot extends EventDispatcher {
		
		public var debug		:Boolean = true;	// trace to the output console //
		private var _name		:String;			// name to give the newly created image //
		private var _image 		:ByteArray; 		// image data represented as a byte array //

		public function BitmapSnapshot($targ:DisplayObject, $name:String = 'MyImage.png', $width:Number = 0, $height:Number = 0)
		{
			_name = $name;
			
		// draw the display object into a new bitmapdata object //	
		    var bmd:BitmapData = new BitmapData($width || $targ.width, $height || $targ.height);
				bmd.draw($targ);
				
		// encode the bitmapdata object to png or jpg based on the name it was was given //
			var ext:String = $name.substr(-3);
			var a:Date = new Date();	
			if (ext=='png') _image = PNGEncoder.encode(bmd);
			if (ext=='jpg') _image = new JPGEncoder(80).encode(bmd);
			
		// out time to generate image file //
			log('Time to produce image = '+(new Date().time-a.time)/1000+' seconds');
		    if (!_image) log('!! Failed To Convert : '+ $targ.name+ 'To An Image - !! Ensure File Extension Is Either .jpg or .png');
		}
		
		public function saveToDesktop():void
		{
			var fr:FileReference = new FileReference();
				fr.save(_image, _name);
		}

		public function saveOnServer($script:String, $destination:String = ''):void
		{
			var hdr:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
			var req:URLRequest = new URLRequest($script+'?filename='+_name+'&destination='+$destination);
				req.requestHeaders.push(hdr);
				req.data = _image;				
				req.method = URLRequestMethod.POST;
			
			var ldr:URLLoader = new URLLoader();
				ldr.dataFormat = URLLoaderDataFormat.BINARY;
				ldr.addEventListener(Event.COMPLETE, onRequestComplete);
				ldr.addEventListener(IOErrorEvent.IO_ERROR, onRequestFailure);
				ldr.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityViolation)
				ldr.load(req);	
		}

 //- EVENT HANDLERS ----------------------------------------------------------------------

		private function onRequestComplete(e:Event):void
		{
			log('Upload of '+_name+' was successful');
		}	
		
		private function onRequestFailure(e:IOErrorEvent):void
		{
			log('Upload of '+_name+' has failed');
		}	
		
		private function onSecurityViolation(e:SecurityErrorEvent):void
		{
			log('Security Violation has occurred, check crossdomain policy files');
		}				
		
 //- OUTPUT ------------------------------------------------------------------------------
		
		private function log(...rest):void
		{
			if (debug) for (var i : int = 0; i < rest.length; i++) trace(rest[i]);
		}
		
	}
	
}
