package faceless.util {
	import faceless.go.Hero;
	import com.bit101.components.PushButton;
	import com.bit101.components.Panel;
	import com.bit101.components.Label;
	import com.bit101.components.HSlider;
	import faceless.go.Player;
	import faceless.manager.EnemyManager;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
public class TestToolbox extends Sprite{
	private var panel:Panel;
	public function TestToolbox(hero:Player, dark:*, room:*) {
		this.x = 530;
		this.y = 6;
		
		panel = new Panel(this, 0, 0); panel.width =  104; panel.height = 110;
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
		//l.text = label + v.value;
	}

}

}