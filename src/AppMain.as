
package {
	import fl.controls.Button;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.quietless.bitmap.BitmapSnapshot;

	[SWF(width='800', height='550', backgroundColor='#333333', frameRate='60')]
	public class AppMain extends Sprite {

		private var _draw			:Button;
		private var _server			:Button;
		private var _desktop		:Button;		
		private var _controls		:Sprite;
		private var _canvas			:Canvas;
		
		private var _filename		:String = 'colored-balls.png';	
		private var _phpscript		:String = 'php/upload.php';
		private var _destination	:String = 'bitmap-snapshots';
		
		public function AppMain()
		{
			_canvas = new Canvas();
			addChild(_canvas);
			initControls();
		}
		
		private function initControls():void
		{
			_controls = new Sprite();
			_draw = new Button();
			_draw.label = 'paint balls';
			_server = new Button();
			_server.label = 'save to server';
			_desktop = new Button();
			_desktop.label = 'save to desktop';			
		
			var spacing:uint = 125;	
			_desktop.x = spacing;				
			_server.x = spacing * 2;
			_controls.addChild(_draw);
			_controls.addChild(_server);
			_controls.addChild(_desktop);			
			_controls.x = stage.stageWidth/2 - _controls.width/2;
			_controls.y = stage.stageHeight - 50;
			_controls.addEventListener(MouseEvent.CLICK, onMouseClick);
			addChild(_controls);
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			if (e.target==_draw) draw();
			if (e.target==_server) saveOnServer();	
			if (e.target==_desktop) saveToDesktop();				
		}
		
		private function draw():void
		{
			_canvas.draw();
		}
		
		private function saveToDesktop():void
		{
			var img:BitmapSnapshot = new BitmapSnapshot(_canvas, _filename, _canvas.mask.width, _canvas.mask.height);
				img.saveToDesktop();			
		}
		
		private function saveOnServer():void
		{
			var img:BitmapSnapshot = new BitmapSnapshot(_canvas, _filename, _canvas.mask.width, _canvas.mask.height);
				img.saveOnServer(_phpscript, _destination);
		}		
		
	}
	
}
