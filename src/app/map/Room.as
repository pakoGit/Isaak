package app.map {
import assets.Assets;
import core.GameObj;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

public class Room extends Sprite{
	private var _floor:Array = [];
	private var _walls:Array = [];//карта проходимости
	
	private var _bmp:Bitmap;
	private var _allMap:Bitmap;
	
	public function Room(arr:Array, walls:Array) {
		_bmp = new Bitmap(new BitmapData(640, 480, true, 0));
		_allMap = new Bitmap(new BitmapData(arr.length*Tile.SIZE, arr[0].length*Tile.SIZE));
		addChild(_bmp);
		fill(arr, walls);
	}
	
	public function clear():void {
		_allMap.bitmapData.dispose();
		_allMap = null;
		_bmp.bitmapData.dispose();
		removeChild(_bmp);
		_bmp = null;
		clearRoom();
	}
	
	public function fill(map:Array, walls:Array):void {
		clearRoom();
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
		draw();
	}
	
	public function scroll(sx:int, sy:int):void {
		//_bmp.bitmapData.scroll(sx, sy);
		if (sx < 640) sx = 640;
		if (sy < 480) sy = 480;
		_bmp.bitmapData.draw(_allMap.bitmapData, new Matrix(1, 0, 0, 1, 640 - sx, 480 - sy));
	}
	
	public function get map():Array { return _walls; }
	
	private function draw():void {
		var bd:BitmapData = _allMap.bitmapData;
		bd.lock();
		var mtrx:Matrix = new Matrix;
		for (var i:int = 0; i < _floor.length; i++) {
			bd.copyPixels(Assets.Atlas.graph, new Rectangle(_floor[i].tile.x, _floor[i].tile.y, _floor[i].tile.w, _floor[i].tile.h), new Point(_floor[i].x, _floor[i].y),null,null, true);
		}
		bd.unlock();
	}
	
	private function clearRoom():void {
		_bmp.bitmapData.fillRect(_bmp.bitmapData.rect, 0);
		_bmp.bitmapData.scroll(0, 0);
		_floor.splice(0);
	}
	
}
}