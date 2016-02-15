package app.go.hero {
import app.manager.CollisionManager;
import app.map.MapManager;
import core.event.InputEvent;
import app.go.hero.IState;
import assets.Assets;
import core.IInput;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.setInterval;

public class Hero extends Sprite {	
	private var _state:IState;
	private var _bmp:Bitmap;
	
	public var speed:Number = 4;
	public var moveDir:Array = [0, 0, 0, 0];
	
	public function Hero() {
		//var mc:MovieClip = new MovieClip(Assets.Atlas.getTextures("idle"), 8);
		//addChild(mc);
		//(_input).addEventListener(Event.CHANGE, function():void{});
		_bmp = new Bitmap(new BitmapData(64, 64, true, 0));
		addChild(_bmp);
		_bmp.x = _bmp.y = -32;
		
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
		var bd:BitmapData = _bmp.bitmapData;
		bd.fillRect(bd.rect, 0);
		bd.copyPixels(Assets.Atlas.graph, new Rectangle(i.x, i.y, i.w, i.h), new Point(0, 0));
	}
	
	public function input(cmd:String):void {
		_state.update(cmd);
	}
	
	public function update():void {
		var nextX:Number = x + (moveDir[0] + moveDir[1]) * speed;
		var nextY:Number = y + (moveDir[2] + moveDir[3]) * speed;
		if (!CollisionManager.checkByCoord(nextX, nextY, MapManager.current.map)) return;
		
		x += (moveDir[0]+moveDir[1]) * speed;
		y += (moveDir[2] + moveDir[3]) * speed;
		
		for each(var f:* in _followers){
			f.x = x;
			f.y = y;
		}
	}
	
	private var _followers:Object = {};
	public function attachToHero(id:String, target:Object):void {
		_followers[id] = target;
		target.x = x;
		target.y = y;
	}
	
	public function getFollower(id:String):Object { return _followers[id]; }
	public function get state():IState { return _state;}

}
}