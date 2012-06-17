
package {
	import flash.display.DisplayObject;
	import com.greensock.TweenLite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.display.Sprite;

	public class Canvas extends Sprite {
	
		private var _cnt		:Sprite;
		private var _msk		:Shape;
		private var _numBalls	:uint = 1000;
		private var _margin		:uint = 20;
		
		public function Canvas()
		{
			this.x = this.y = _margin;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		private function onAddedToStage($e:Event):void
		{
			_cnt = new Sprite();
			_cnt.graphics.beginFill(0xffffff);
			_cnt.graphics.drawRect(0, 0, stage.stageWidth - _margin*2, stage.stageHeight - _margin*2 - 50);	
			_msk = new Shape();
			_msk.graphics.beginFill(0x000000);
			_msk.graphics.drawRect(0, 0, _cnt.width, _cnt.height);
			addChild(_cnt);
			addChild(_msk);
			_cnt.mask = _msk;
		}
		
		override public function get mask():DisplayObject
		{
			return _cnt.mask;	
		}
		
		public function draw():void
		{
		// clear //	
			while(_cnt.numChildren) _cnt.removeChildAt(0);
			
		// attach new balls //	
			for (var i : int = 0; i < _numBalls; i++) {
				var b:Ball = new Ball();
					b.x = Math.random()*_cnt.width - b.width/2;
					b.y = Math.random()*_cnt.height - b.height/2;
				_cnt.addChild(b);
				b.scaleX = b.scaleY = 0;
				var speed:Number = Math.random()*.5 +.5;
				var scale:Number = Math.random()*.5 + 1;
				TweenLite.to(b, speed, {scaleX:scale, scaleY:scale, delay:i*.01});
			}
		}
	}
}
