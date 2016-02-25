package {
import app.Application;
import faceless.Faceless;
import flash.display.Sprite;
import flash.events.Event;

[Frame(factoryClass = "Preloader")]
[SWF(backgroundColor = 0x000000, width = 640, height = 480, frameRate = 60)]

public class Main extends Sprite {
	
	public function Main() {
		if (stage) init();
		else addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event = null):void {
		removeEventListener(Event.ADDED_TO_STAGE, init);

		//new Application(stage);
		addChild(new faceless.Faceless);

		stage.addEventListener(Event.DEACTIVATE, deactivate);
	}

	private function deactivate(e:Event):void {
		stage.addEventListener(Event.ACTIVATE, activate);
		//_starling.stop();
	}

	private function activate(e:Event):void {
		stage.removeEventListener(Event.ACTIVATE, activate);
		//_starling.start();
	}

}
}