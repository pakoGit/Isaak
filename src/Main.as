package {
import faceless.Faceless;
import faceless.global.Assets;
import flash.display.Sprite;
import flash.events.Event;
import flash.system.Security;

[Frame(factoryClass = "Preloader")]
[SWF(backgroundColor = 0x000000, width = 800, height = 600, frameRate = 60)]

public class Main extends Sprite {
	
	public function Main() {
		if (stage) init();
		else addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event = null):void {
		removeEventListener(Event.ADDED_TO_STAGE, init);

		//new Application(stage);
		Security.allowDomain("*")
		Assets.READY.add(onReady);
		new Assets();
	}
	private function onReady():void{
		addChild(new faceless.Faceless);
	}

}
}