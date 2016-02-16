package faceless.go {
import org.flixel.FlxG;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;
	
public class Hero extends FlxSprite {
	[Embed(source = "../../../lib/hero.png")]private var heroPng:Class;
	private var RUN_SPEED:Number = 160;
	
	public function Hero(X:int = 0, Y:int = 0) {
		super(X, Y);
		loadGraphic(heroPng, true, true, 64, 64);
		addAnimation("move", [5, 2, 0, 2], 8);
		addAnimation("move_up", [4]);
		addAnimation("idle", [4, 1, 3], 4);
		play("idle");
		
		speed = RUN_SPEED;
	}
	
	public function set speed(s:Number):void {
		RUN_SPEED = s;
		drag.x = drag.y = RUN_SPEED * 12;
		maxVelocity = new FlxPoint(RUN_SPEED, RUN_SPEED);
	}
	public function get speed():Number {
		return RUN_SPEED;
	}
	
	public override function update():void {
		acceleration.x  = acceleration.y = 0;
		if (FlxG.keys.A) {
			facing = RIGHT;
			acceleration.x = -drag.x;
		} else if (FlxG.keys.D) {
			facing = LEFT;
			acceleration.x = drag.x;
		}
		if (FlxG.keys.W) {
			acceleration.y = -drag.y;
		} else if (FlxG.keys.S) {
			acceleration.y = drag.y;
		}
		
		 //Animation
		if (velocity.x != 0) { 
			play("move"); 	
		}else if (velocity.y != 0) {
			play("move_up"); 	
		}else if (!velocity.x) { 
			play("idle"); 
		}
	}

}
}