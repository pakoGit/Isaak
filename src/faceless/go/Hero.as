package faceless.go {
import faceless.global.GameVar;
import org.flixel.FlxG;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;
	
public class Hero extends FlxSprite{
	[Embed(source = "../../../lib/hero.png")]private var heroPng:Class;
	private var _runSpeed:Number = GameVar.BASE_HERO_SPEED;
	public var parent:Player;
	
	public function Hero(X:int = 0, Y:int = 0) {
		super(X, Y);
		loadGraphic(heroPng, true, true, 64, 64);
		addAnimation("move", [5, 2, 0, 2], 8);
		addAnimation("move_up", [4]);
		addAnimation("idle", [4, 1, 3], 4);
		addAnimation("die", [6]);
		play("idle");
		speed = _runSpeed;
		width = 60; height = 60;
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