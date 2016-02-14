package core {
import flash.display.BitmapData;

public class TextureAtlas {
	private var _map:Object = { };//id => {x,y,w,h}
	private var _atlas:BitmapData;
	
	public function TextureAtlas(bdata:BitmapData, conf:XML) {
		_atlas = bdata;
		for each(var _:XML in conf.SubTexture ) {
			_map[_.@name] = {x:Number(_.@x), y:Number(_.@y), w:Number(_.@width), h:Number(_.@height)};
		}
	}
	
	public function getTexture(id:String):Object {
		return _map[id];
	}
	
	public function getTextures(id:String):Array {
		var a:Array = [];
		for (var i:String in _map) {
			if (i.lastIndexOf(id) > -1) a.push(_map[i]);
		}
		return a;
	}
	
	public function get graph():BitmapData { return _atlas;}

}
}