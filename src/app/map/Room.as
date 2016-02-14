package app.map {
import assets.Assets;
import core.GameObj;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class Room extends GameObj{
	private var _m:Array = [];
	
	public function Room(arr:Array) {
		fill(arr);
	}
	
	public function fill(map:Array):void {
		for (var i:int = 0; i < map.length; i++) {
			for (var j:int = 0; j < map[i].length; j++) {
				var t:Object = Assets.Atlas.getTexture(map[i][j]);
				_m.push({x:64*i, y:64*j, tile:t});
			}
		}
	}
	
	public override function draw(canvas:BitmapData):void {
		var mtrx:Matrix = new Matrix;
		for (var i:int = 0; i < _m.length; i++) {
			canvas.copyPixels(Assets.Atlas.graph, new Rectangle(_m[i].tile.x, _m[i].tile.y, _m[i].tile.w, _m[i].tile.h), new Point(_m[i].x, _m[i].y));
		}
	}
	
}
}