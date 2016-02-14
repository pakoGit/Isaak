package app.input {
import core.event.InputEvent;
import core.IInput;
import flash.display.Stage;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

public class KeyboardInput extends EventDispatcher implements IInput {
	private var lastAct:String;
	
	public function KeyboardInput(stage:Stage) {
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
	}
	
	public function getCode():String {
		return lastAct;
	}
	
	private function keyDown(e:KeyboardEvent):void {
		var act:String = getAct(e.keyCode);
		if(act){
			var s:String = "+" + act;
			lastAct = s;
			dispatchEvent(new InputEvent(InputEvent.CHANGE, s));
		}
	}
	
	private function keyUp(e:KeyboardEvent):void {
		var act:String = getAct(e.keyCode);
		if(act){
			var s:String = "-" + act;
			lastAct = s;
			dispatchEvent(new InputEvent(InputEvent.CHANGE, s));
		}
	}
	
	private function getAct(k:uint):String {
		var s:String = null;
		if (k == Keyboard.W) {
			s = CmdName.UP; 
		}else if (k == Keyboard.S) {
			s = CmdName.DOWN;
		}
		if ( k == Keyboard.A) {
			s = CmdName.LEFT;
		}else if (k == Keyboard.D) {
			s = CmdName.RIGHT;
		}
		if (k == Keyboard.SPACE) {
			s = CmdName.FIRE;
		}
		return s;
	}

}
}