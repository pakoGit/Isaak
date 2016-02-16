package faceless.util {
	import core.Light;
	import faceless.go.Hero;
	import com.bit101.components.PushButton;
	import com.bit101.components.Panel;
	import com.bit101.components.Label;
	import com.bit101.components.HSlider;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
public class TestToolbox extends Sprite{
	private var panel:Panel;
	public function TestToolbox(hero:Hero, light:Light, dark:*, room:*) {
		this.x = 530;
		this.y = 6;
		
		panel = new Panel(this, 0, 0); panel.width =  104; panel.height = 110;
		//HERO SPEED
		var label:Label = new Label(panel.content, 0, 0, "Hero speed: "+hero.speed);
		var vslider:HSlider = new HSlider(panel.content, 2, 14, function():void {
			var c:Number = vslider.value * 10;
			hero.speed = c;
			
			label.text = "Hero speed: " + c.toFixed(2);
		}); vslider.value = hero.speed / 10;
		//LIGHT 
		var l2:Label = new Label(panel.content, 0, 26, "Light R: 6");
		var v2:HSlider = new HSlider(panel.content, 2, 40, function():void {
			var c:Number = v2.value / 10;
			light.scale.x = c;
			light.scale.y = c;
			l2.text = "Light R: " + c.toFixed(2);
		}); v2.value = 60;
		addScroll(0, 52, dark.ID, "Darkness:", function(value:Number):void {
			value = (value/100) * 255;
			dark.ID = value << 24;
		});
		//ROOM
		var roomBtn:PushButton = new PushButton(panel.content, 2, 52+30, "Rebuild room", function():void {
			//MapManager.rebuild();
		});
	}
	
	private function addScroll(x:int, y:int, value:uint, label:String, handler:Function):void {
		var l:Label = new Label(panel.content, x, y, label);
		var v:HSlider = new HSlider(panel.content, x + 2, y + 14, function():void {
			l.text = label + v.value;
			handler(v.value);
		});
		v.value = (value / 0xff000000) * 100;
		l.text = label + v.value;
	}

}

}