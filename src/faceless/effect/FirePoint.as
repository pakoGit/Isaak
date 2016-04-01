package faceless.effect {
	import core.Light;
	import faceless.global.Assets;
	import faceless.global.GameVar;
	import org.flixel.FlxSprite;
	
	public class FirePoint extends FlxSprite {
		private const speed:Number = 4;
		private var _maxDistance:Number;
		private var _distance:Number;
		private var light:Light;
		public var type:String;
		
		/**
		 *
		 * @param	X
		 * @param	Y
		 * @param	speedX 1:right, -1:left
		 * @param	speedY 1:up, -1:down
		 * @param	distance
		 */
		public function FirePoint(X:Number = 0, Y:Number = 0, speedX:Number = 0, speedY:Number = 0, distance:Number = 300) {
			super(X, Y);
			loadGraphic(Assets.getPng(Assets.FIRE), true, false, 75, 75);
			addAnimation("anim", [0, 1, 2, 3], 8);
			play("anim");
			//addAnimationCallback(function():void {  } );
			//solid = false;
			speedXY(speedX, speedY);
			maxDistance = distance;
			width = height = 12;
			offset.x = 75 >> 1;
			offset.y = 75 >> 1;
			
			light = new Light(X, Y, GameVar.DARKNESS);
			light.scale.x = 4;
			light.scale.y = 4;
			//light.scale.y = 0.8;
			GameVar.BULLETS_MANAGER.cont.add(light);
			
			Reset();
		}
		
		public function speedXY(speedX:Number = 0, speedY:Number = 0):void {
			velocity.x = speedX * speed;
			velocity.y = -speedY * speed;
			/*angle = speedY * 90;
			facing = speedX == 1 ? LEFT : RIGHT;
			if (speedY < 0) {
				offset.x = 7;
				offset.y = 6;
			} else if (speedY > 0) {
				offset.x = 6;
				offset.y = -6;
			} else if (speedX > 0) {
				offset.x = 12;
				offset.y = 0;
			} else {
				offset.x = 0;
				offset.y = 0;
			}*/
		}
		
		public function set maxDistance(distance:Number):void {
			_maxDistance = distance;
		}
		
		public override function update():void {
			x += velocity.x;
			y += velocity.y;
			_distance += Math.abs(velocity.x || velocity.y);
			light.x = x;
			light.y = y;
			super.update();
		}
		
		public function isValid():Boolean {
			return _distance < _maxDistance;
		}
		
		public function Reset():void {
			_distance = 0;
			light.visible = true;
		}
		
		public function clear():void {
			GameVar.BULLETS_MANAGER.cont.remove(light);
		}
		
		public function remove():void {
			light.visible = false;
		}
	
	}
}