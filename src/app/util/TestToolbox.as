package app.util {
	import app.go.hero.Hero;
	import app.map.MapManager;
	import app.map.Room;
	import com.bit101.components.PushButton;
	import com.bit101.components.Panel;
	import com.bit101.components.Label;
	import com.bit101.components.HSlider;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
public class TestToolbox extends Sprite{
	
	public function TestToolbox(hero:Hero, room:Room) {
		this.x = 530;
		this.y = 6;
		
		
		var panel:Panel = new Panel(this, 0, 0); panel.width =  104;
		//HERO SPEED
		var label:Label = new Label(panel.content, 0, 0, "Hero speed: "+hero.speed);
		var vslider:HSlider = new HSlider(panel.content, 2, 14, function():void {
			var c:Number = vslider.value / 10;
			hero.speed = c;
			label.text = "Hero speed: " + c.toFixed(2);
		}); vslider.value = hero.speed * 10;
		//LIGHT 
		var l2:Label = new Label(panel.content, 0, 26, "Light: 2");
		var v2:HSlider = new HSlider(panel.content, 2, 40, function():void {
			var c:Number = v2.value / 10;
			hero.getFollower("light").scaleX = c;
			hero.getFollower("light").scaleY = c;
			l2.text = "Hero speed: " + c.toFixed(2);
		}); v2.value = 20;
		//ROOM
		var roomBtn:PushButton = new PushButton(panel.content, 2, 56, "Rebuild room", function():void {
			room.fill(MapManager.buildRoom());
		});
	}

}

}