package app {
import app.go.hero.Hero;
import app.input.KeyboardInput;
import app.map.MapManager;
import app.map.Room;
import com.bit101.components.HSlider;
import core.event.InputEvent;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Stage;
import flash.events.Event;
import flash.geom.Matrix;

public class Application{
	private var _world:Stage;
	private var _canvas:BitmapData;
	private var toDraw:Array = [];
	
	private var pl:Hero = new Hero();
	
	public function Application(stage:Stage) {
		_world = stage;
		_canvas = new BitmapData(_world.stageWidth, _world.stageHeight, true, 0);
		var b:Bitmap = new Bitmap(_canvas);
		_world.addChild(b);
		_world.addEventListener(Event.ENTER_FRAME, update);
		
		trace("app start");
		var mm:MapManager = new MapManager;
		var room:Room = new Room(mm.buildRoom());
		//_world.addChild(room);
		toDraw.push(room);
		
		//_world.addChild(pl);
		toDraw.push(pl);
		
		var vslider:HSlider = new HSlider(_world, 10, 10, function():void {
			trace(vslider.value);
		});
		
		var input:KeyboardInput = new KeyboardInput(_world);
		input.addEventListener(InputEvent.CHANGE, inputChanged);
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