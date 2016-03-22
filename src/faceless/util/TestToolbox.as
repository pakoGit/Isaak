package faceless.util {
	import faceless.global.GameVar;
	import faceless.go.Hero;
	import com.bit101.components.PushButton;
	import com.bit101.components.Panel;
	import com.bit101.components.Label;
	import com.bit101.components.HSlider;
	import faceless.go.Player;
	import faceless.manager.EnemyManager;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import org.flixel.FlxG;
	
public class TestToolbox extends Sprite{
	private var panel:Panel;
	public function TestToolbox(hero:Player, dark:*) {
		this.x = GameVar.SCREEN_W - 110;
		this.y = 6;
		
		panel = new Panel(this, 0, 0); panel.width =  104; panel.height = 154+24;
		//HERO SPEED
		addScroll(0, 0, hero.speed / 10, "Hero speed: ", function(value:Number):Number {
			var c:Number = value * 10;
			hero.speed = c;
			return c;
		});
		//LIGHT
		addScroll(0, 26, 60, "Light R: ", function(value:Number):Number {
			var c:Number = value / 10;
			hero.light.scale.x = c;
			hero.light.scale.y = c;
			return c;
		});
		addScroll(0, 52, (uint(dark.ID) / 0xff000000) * 100, "Darkness: ", function(value:Number):Number {
			value = (value/100) * 255;
			dark.ID = value << 24;
			return value;
		});
		//ENEMY
		addScroll(0, 78, (EnemyManager.Get().distance/500)*100, "Hero view: ", function(value:Number):Number {
			value = (value/100) * 500;
			EnemyManager.Get().distance = value;
			return value;
		});
		//RESET HERO
		var respawnBtn:PushButton = new PushButton(panel.content, 2, 78+30, "Reset hero", function():void {
			hero.respawn();
		});
		//TOGGLE DARKNESS
		var darkBtn:PushButton = new PushButton(panel.content, 2, 78+30+24, "Toggle Darkness", function():void {
			dark.ID = dark.ID != 0?0:237 << 24; //== 237<<24?0:237<<24;
		});
		//TOGGLE DEBUG MODE
		var debugBtn:PushButton = new PushButton(panel.content, 2, 78+30+24+24, "Debug Draw", function():void {
			FlxG.visualDebug = !FlxG.visualDebug;
		});
		
		//ROOM
		/*var roomBtn:PushButton = new PushButton(panel.content, 2, 52+30, "Rebuild room", function():void {
			MapManager.rebuild();
		});*/
		//STATE CHANGE
		//var l1:Label = new Label(panel.content, 0, 80, "Q: Poison\tE: Slow");
	}
	
	private function addScroll(x:int, y:int, value:uint, label:String, handler:Function):void {
		var l:Label = new Label(panel.content, x, y, label);
		var v:HSlider = new HSlider(panel.content, x + 2, y + 14, function():void {
			l.text = label + handler(v.value);
		});
		v.value = value;
	}

}

}