package app.map {
import assets.Assets;
import core.GameObj;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class Room extends GameObj{
	private var _floor:Array = [];
	private var _walls:Array = [];//карта проходимости
	
	public function Room(arr:Array, walls:Array) {
		fill(arr, walls);
	}
	
	public function fill(map:Array, walls:Array):void {
		clear();
		_walls = walls;
		var ml:int = map.length;
		var mil:int = map[0].length;
		var id:String;
		var t:Object;
		for (var i:int = 0; i < ml; i++) {
			for (var j:int = 0; j < mil; j++) {
				t = Assets.Atlas.getTexture(map[i][j]);
				_floor.push( { x:64 * i, y:64 * j, tile: t } );
				
				if (walls[i][j] == Tile.BLOCK) {
					if (i == 0 && j == 0) id = "top_left";
					else if (i == 0 && j == mil - 1) id = "bot_left";
					else if (i == ml - 1 && j == 0) id = "top_right";
					else if (i == ml - 1 && j == mil - 1) id = "bot_right";
					else if (i > 0 && j == 0) id = "wall_top";
					else if (i > 0 && j == mil - 1) id = "wall_bot";
					else if (i == 0 && j > 0) id = "wall_left";
					else if (i == ml - 1 && j > 0) id = "wall_right";
				}else if (walls[i][j] == Tile.DOOR) {
					if (i == 0) id = "door_left";
					else if (i == ml - 1) id = "door_right";
					else if (j == 0) id = "door_top";
					else if (j == mil - 1) id = "door_bot";
				}else {
					continue;
				}
				t = Assets.Atlas.getTexture(id);
				_floor.push( { x:64 * i, y:64 * j, tile: t } );
			}
		}
	}
	
	public override function draw(canvas:BitmapData):void {
		var mtrx:Matrix = new Matrix;
		for (var i:int = 0; i < _floor.length; i++) {
			canvas.copyPixels(Assets.Atlas.graph, new Rectangle(_floor[i].tile.x, _floor[i].tile.y, _floor[i].tile.w, _floor[i].tile.h), new Point(_floor[i].x, _floor[i].y),null,null, true);
		}
	}
	
	public function get map():Array { return _walls; }

	private function clear():void {
		_floor.splice(0);
	}
	
}
}