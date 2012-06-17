
package {
	import flash.display.Shape;

	public class Ball extends Shape {

		public function Ball()
		{
			var r:uint = Math.random()*20 + 20;
			this.graphics.beginFill(Math.random()*0xffffff);
			this.graphics.drawEllipse(-r/2, -r/2, r, r);
		}
	}
}
