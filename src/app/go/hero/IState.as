package app.go.hero {
import core.IInput;

public interface IState {
	function update(cmd:String):void;
	function getName():String;
	function getTexture():Object;
}
}