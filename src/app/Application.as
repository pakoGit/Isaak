package app {
import app.go.hero.Hero;
import app.input.KeyboardInput;
import app.map.MapManager;
import app.map.Room;
import com.bit101.components.HSlider;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Stage;
import flash.events.Event;
import flash.geom.Matrix;

public class Application{
	private var _world:Stage;
	private var _canvas:BitmapData;
	private var toDraw:Array = [];
	
	public function Application(stage:Stage) {
		_world = stage;
		_canvas = new BitmapData(_world.stageWidth, _world.stageHeight, true, 0);
		var b:Bitmap = new Bitmap(_canvas);
		_world.addChild(b);
		_world.addEventListener(Event.ENTER_FRAME, update);
		
		trace("app start");
		var mm:MapManager = new MapManager;
		var room:Room = new Room(mm.buildRoom());
		_world.addChild(room);
		
		var pl:Hero = new Hero(new KeyboardInput(_world));
	//	_world.addChild(pl);
		toDraw.push(pl);
		
		var vslider:HSlider = new HSlider(_world, 10, 10, function():void {
			trace(vslider.value);
		});
	}
	
	private function update(e:Event):void {
		_canvas.lock();
		_canvas.fillRect(_canvas.rect, 0);
		var mtrx:Matrix =  new Matrix;
		for (var i:int = 0; i < toDraw.length; i++) {
			var d:Object = toDraw[i];
			mtrx.translate(d.x, d.y);
			_canvas.draw(d.graph, mtrx , null, null, null);
		}
		//_canvas.draw(
		_canvas.unlock();
	}
	
}
}