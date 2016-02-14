package app.map {
import assets.Assets;
import flash.display.Sprite;

public class Room extends Sprite{
	private var _m:Array = [];
	
	public function Room(arr:Array) {
		_m = arr;
		fill();
	}
	
	public function fill():void {
		for (var i:int = 0; i < _m.length; i++) {
			for (var j:int = 0; j < _m[i].length; j++) {
				//var t:Texture = Assets.Atlas.getTexture(_m[i][j]);
				//var img:Image = new Image(t);
				//img.x = i * img.width;
				//img.y = j * img.height;
				//addChild(img);
			}
		}
	}
	
}
}