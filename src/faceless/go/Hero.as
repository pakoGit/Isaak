package faceless.go {
import faceless.global.GameVar;
import org.flixel.FlxG;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;
	
public class Hero extends FlxSprite{
	[Embed(source = "../../../lib/hero_beta.png")]private var heroPng:Class;
	private var _runSpeed:Number = GameVar.BASE_HERO_SPEED;
	public var parent:Player;
	
	public function Hero(X:int = 0, Y:int = 0) {
		super(X, Y);
		loadGraphic(heroPng, true, true, 128, 128);
		addAnimation("attack", [0, 1, 2, 3], 8);
		addAnimation("idle", [4, 5, 6, 7], 4);
		addAnimation("move", [8, 9, 10, 11], 8);
		addAnimation("move_up", [8]);// TODO: HERO MOVE_UP ANIM
		addAnimation("die", [11]); //	TODO: HERO DIE ANIM
		play("idle");
		speed = _runSpeed;
		offset.x = 46;
		offset.y = 36;
		width = 30; height = 60;
	}
	
	public function set speed(s:Number):void {
		_runSpeed = s;
		drag.x = drag.y = _runSpeed * 12;
		maxVelocity = new FlxPoint(_runSpeed, _runSpeed);
	}
	
	public function get speed():Number {
		return _runSpeed;
	}
	
	public override function update():void {
		move();
	}
	
	public function move():void {
		acceleration.x  = acceleration.y = 0;
		if (FlxG.keys.A) {
			acceleration.x = -drag.x;
		} else if (FlxG.keys.D) {
			acceleration.x = drag.x;
		}
		if (FlxG.keys.W) {
			acceleration.y = -drag.y;
		} else if (FlxG.keys.S) {
			acceleration.y = drag.y;
		}
	}

}
}