package faceless.go.weapons {
	import faceless.global.GameVar;
	import org.flixel.FlxSprite;
	
	public class Bullet extends FlxSprite {
		[Embed(source = "../../../../lib/heroA_bullet.png")]
		private var bulletPng:Class;
		
		private const speed:Number = 4;
		private var _maxDistance:Number;
		private var _distance:Number;
		public var type:String;
		
		/**
		 *
		 * @param	X
		 * @param	Y
		 * @param	speedX 1:right, -1:left
		 * @param	speedY 1:up, -1:down
		 * @param	distance
		 */
		public function Bullet(X:int = 0, Y:int = 0, speedX:Number = 0, speedY:Number = 0, distance:Number = 300) {
			super(X, Y);
			makeGraphic(25, 11, 0xffff0000);
			loadGraphic(bulletPng, false, true);
			speedXY(speedX, speedY);
			maxDistance = distance;
			width = height = 12;
			Reset();
		}
		
		public function speedXY(speedX:Number = 0, speedY:Number = 0):void {
			velocity.x = speedX * speed;
			velocity.y = -speedY * speed;
			angle = speedY * 90;
			facing = speedX == 1?LEFT:RIGHT;
			if (speedY < 0) {
				offset.x = 7;
				offset.y = 6;
			}else if (speedY > 0) {
				offset.x = 6;
				offset.y = -6;
			}else if (speedX > 0) {
				offset.x = 12;
				offset.y = 0;
			}else {
				offset.x = 0;
				offset.y = 0;
			}
		}
		
		public function set maxDistance(distance:Number):void {
			_maxDistance = distance;
		}
		
		public override function update():void {
			x += velocity.x;
			y += velocity.y;
			_distance += Math.abs(velocity.x || velocity.y);
			super.update();
		}
		
		public function isValid():Boolean {
			return _distance < _maxDistance;
		}
		
		public function Reset():void {
			_distance = 0;
		}
	
	}
}