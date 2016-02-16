package core {
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class Light extends FlxSprite{
		
		[Embed(source="../../lib/glow-light.png")]private var LightImageClass:Class;
		
		private var darkness:FlxSprite;
		
		public function Light(x:Number, y:Number, darkness:FlxSprite):void {
			super(x, y, LightImageClass);
			
			this.darkness = darkness;
			this.blend = "screen";
			scale.x = 6;
			scale.y = 6;
		}
		
		override public function draw():void {
			var screenXY:FlxPoint = getScreenXY();
			darkness.stamp(this, screenXY.x - this.width / 2, screenXY.y - this.height / 2);
		}
	
	}
}