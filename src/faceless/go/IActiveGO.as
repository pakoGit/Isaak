package faceless.go {
import faceless.state.FSM;
import org.flixel.FlxSprite;
	
public interface IActiveGO {
	function set speed(s:Number):void;
	function get speed():Number;
	function get hp():Number;
	function hit(d:Number):void;
	function get state():FSM;
	function get condition():FSM;
	function get sprite():FlxSprite;
}
}