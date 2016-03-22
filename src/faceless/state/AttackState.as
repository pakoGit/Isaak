package faceless.state {
	import faceless.go.IActiveGO;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.osflash.signals.Signal;
	
	public class AttackState implements IState {
		public static var onAttack:Signal = new Signal(Object);
		private var _target:IActiveGO;
		
		public function AttackState(target:IActiveGO) {
			_target = target;
		}
		
		public function focus():void {
			_target.sprite.color = 0xffffff;
			_target.sprite.play("attack");
		}
		
		public function apply():void {
			focus();
			//_target.speed = 0;
		}
		
		public function refresh():void {
		
		}
		
		public function update():void {
			var t:FlxSprite = _target.sprite;
			if (FlxG.keys.RIGHT) t.facing = FlxObject.LEFT
			else if(FlxG.keys.LEFT) t.facing = FlxObject.RIGHT
			if (_target.sprite.frame == 2) {
				onAttack.dispatch(param);
			}
		}
		
		public function end():void {
			_target.sprite.play("idle");
		}
		
		private var param:Object;
		public function callback(param:Object = null):void {
			this.param = param;
		}
	
	}
}