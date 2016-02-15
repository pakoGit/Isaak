package app {
import app.go.hero.Hero;
import app.input.KeyboardInput;
import app.map.MapManager;
import app.map.Room;
import app.util.TestToolbox;
import core.event.InputEvent;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.geom.Matrix;

public class Application{
	private var _world:Sprite;
	private var _stage:Stage;
	private var _canvas:BitmapData;
	private var toDraw:Array = [];
	
	private var pl:Hero = new Hero();
	
	public function Application(stage:Stage) {
		_stage = stage;
		_world = new Sprite();
		_stage.addChild(_world);
		_canvas = new BitmapData(_stage.stageWidth, _stage.stageHeight, true, 0);
		var b:Bitmap = new Bitmap(_canvas);
		_world.addChild(b);
		_world.addEventListener(Event.ENTER_FRAME, update);
		
		trace("app start");
		var room:Room = new Room(MapManager.buildRoom());
		//_world.addChild(room);
		toDraw.push(room);
		
		_world.addChild(pl);
		pl.x = _world.width>>1;
		pl.y = _world.height>>1;
		
		_stage.addChild(new TestToolbox(pl, room));
		
		var input:KeyboardInput = new KeyboardInput(_stage);
		input.addEventListener(InputEvent.CHANGE, inputChanged);
		
		_world.cacheAsBitmap = true;
		var m:mmask = new mmask();
		m.scaleX = m.scaleY = 2;
		_world.addChild(m);
		m.cacheAsBitmap = true;
		_world.mask = m;
		pl.attachToHero("light", m);
	}
	
	private function inputChanged(e:InputEvent):void {
		pl.input(e.result);
	}
	
	private function update(e:Event):void {
		_canvas.lock();
		_canvas.fillRect(_canvas.rect, 0);
		pl.update();

		for (var i:int = 0; i < toDraw.length; i++) {
			var d:Object = toDraw[i];
			d.draw(_canvas);
		}
		_canvas.unlock();
	}
	
}
}