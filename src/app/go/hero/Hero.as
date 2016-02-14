package app.go.hero {
import core.IState;
import assets.Assets;
import core.GameObj;
import core.IInput;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.setInterval;

public class Hero extends Sprite {
	private var _input:IInput;
	private var _state:IState;
	private var _bdata:BitmapData;
	
	public function Hero(input:IInput) {
		_input = input;
		
		var i:* = Assets.Atlas.getTexture("idle1");
		var j:* = Assets.Atlas.getTextures("idle");
		_bdata = new BitmapData(i.w, i.h, true, 0);
		_bdata.copyPixels(Assets.Atlas.graph, new Rectangle(i.x, i.y, i.w, i.h), new Point(0, 0));
		//var mc:MovieClip = new MovieClip(Assets.Atlas.getTextures("idle"), 8);
		//addChild(mc);
	}
	
	public function changeState(newState:IState):void {
		
	}
	
	public function update():void {
		_state.update(_input);
	}
	
	public function get graph():BitmapData { return _bdata; }

}
}