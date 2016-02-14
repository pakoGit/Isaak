package app.go.hero {
import core.event.InputEvent;
import app.go.hero.IState;
import assets.Assets;
import core.GameObj;
import core.IInput;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.setInterval;

public class Hero extends GameObj {	
	private var _state:IState;
	private var _bdata:BitmapData;
	
	public const speed:Number = 2;
	public var moveDir:Array = [0, 0, 0, 0];
	
	public function Hero() {		
		//var mc:MovieClip = new MovieClip(Assets.Atlas.getTextures("idle"), 8);
		//addChild(mc);
		//(_input).addEventListener(Event.CHANGE, function():void{});
		_bdata = new BitmapData(64, 64, true, 0);
		changeState(new HeroIdleState(this));
	}
	
	private var _states:Object = { };
	public function changeState(newState:IState):void {
		/*var state:IState = _states[newState.getName()];
		if (!state) {
			state = newState;
			_states[newState.getName()] = new newState;
		}*/
		_state = newState;
		var i:* = _state.getTexture();		
		_bdata.fillRect(_bdata.rect, 0);
		_bdata.copyPixels(Assets.Atlas.graph, new Rectangle(i.x, i.y, i.w, i.h), new Point(0, 0));
	}
	
	public function input(cmd:String):void {
		_state.update(cmd);
	}
	
	public function update():void {
		x += (moveDir[0]+moveDir[1]) * speed;
		y += (moveDir[2]+moveDir[3]) * speed;
	}
	
	public override function draw(canvas:BitmapData):void {
		var mtrx:Matrix = new Matrix;
		mtrx.scale(scaleX, scaleY);
		mtrx.translate(x-scaleX*32, y);
			
		canvas.draw(_bdata, mtrx , null, null, null);	
	}
		
	public function get graph():BitmapData { return _bdata; }
	public function get state():IState { return _state;}

}
}