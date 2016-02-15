package app.map {
import assets.Assets;
import core.GameObj;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class Room extends GameObj{
	private var _floor:Array = [];
	private var _walls:Array = [];
	
	public function Room(arr:Array) {
		fill(arr);
	}
	
	public function fill(map:Array):void {
		_floor.splice(0);
		var ml:int = map.length;
		var mil:int = map[0].length;
		for (var i:int = 0; i < ml; i++) {
			for (var j:int = 0; j < mil; j++) {
				var t:Object = Assets.Atlas.getTexture(map[i][j]);
				_floor.push( { x:64 * i, y:64 * j, tile:t } );
				
				if (i == 0 || i == ml - 1 || j == 0 || j == mil - 1) {
					if (i == 0 && j == 0) t = Assets.Atlas.getTexture("top_left");
					else if (i == 0 && j == mil - 1) t = Assets.Atlas.getTexture("bot_left");
					else if (i == ml - 1 && j == 0) t = Assets.Atlas.getTexture("top_right");
					else if (i == ml - 1 && j == mil - 1) t = Assets.Atlas.getTexture("bot_right");
					else if(i>0 && j==0) t = Assets.Atlas.getTexture("wall_top");
					else if(i>0 && j==mil-1) t = Assets.Atlas.getTexture("wall_bot");
					else if(i == 0 && j>0) t = Assets.Atlas.getTexture("wall_left");
					else if (i == ml - 1 && j > 0) t = Assets.Atlas.getTexture("wall_right");
					
					_floor.push( { x:64 * i, y:64 * j, tile: t} );
				}
			}
		}
		var rand:int = int(Math.random() * 10);
		if (rand > 2) {
			t = Assets.Atlas.getTexture("door_left");
			i = 0;
			j = mil >> 1;
			_floor.push( { x:64 * i, y:64 * j, tile: t} );
		}
		if (rand > 4) {
			t = Assets.Atlas.getTexture("door_right");
			i = ml-1;
			j = mil >> 1;
			_floor.push( { x:64 * i, y:64 * j, tile: t} );
		}
		if (rand > 6) {
			t = Assets.Atlas.getTexture("door_top");
			j = 0;
			i = ml >> 1;
			_floor.push( { x:64 * i, y:64 * j, tile: t} );
		}
		if (rand > 8) {
			t = Assets.Atlas.getTexture("door_bot");
			j = mil-1;
			i = ml >> 1;
			_floor.push( { x:64 * i, y:64 * j, tile: t} );
		}
	}
	
	public override function draw(canvas:BitmapData):void {
		var mtrx:Matrix = new Matrix;
		for (var i:int = 0; i < _floor.length; i++) {
			canvas.copyPixels(Assets.Atlas.graph, new Rectangle(_floor[i].tile.x, _floor[i].tile.y, _floor[i].tile.w, _floor[i].tile.h), new Point(_floor[i].x, _floor[i].y),null,null,true);
		}
	}
	
}
}