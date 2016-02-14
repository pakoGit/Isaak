package app.input {
import core.IInput;
import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

public class KeyboardInput implements IInput {
	
	public function KeyboardInput(stage:Stage) {
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
	}
	
	public function getCode():int {
		return 1;
	}
	
	private function keyDown(e:KeyboardEvent):void {
		var k:uint = e.keyCode;
		if (k == Keyboard.W) {
			
		}else if (k == Keyboard.S) {
			
		}
		if ( k == Keyboard.A) {
			
		}else if (k == Keyboard.D) {
			
		}
		if (k == Keyboard.SPACE) {
			
		}
	}
	
	private function keyUp(e:KeyboardEvent):void {
		
	}

}
}