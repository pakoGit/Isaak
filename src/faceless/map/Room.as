package faceless.map {
import assets.Assets;
import core.GameObj;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import org.flixel.FlxGroup;
import org.flixel.FlxTilemap;

public class Room extends FlxGroup {
	private var tiles:Class;
	private var _map:FlxTilemap;
	private var _walls:FlxTilemap;
	
	public var W:int;
	public var H:int;
		
	public function Room(arr:Array, walls:Array, w:int, h:int, tiles:Class) {
		this.tiles = tiles;
		_map = new FlxTilemap();
		_walls = new FlxTilemap();
		add(_map);
		add(_walls);
		fill(arr, walls, w, h);
	}
	
	public override function destroy():void {
		_map.destroy();
		_walls.destroy();
	}
	
	public function fill(map:Array, walls:Array, w:int, h:int):void {
		W = w;
		H = h;
		_map.loadMap(FlxTilemap.arrayToCSV(map, W), tiles, MapManager.TILE_W, MapManager.TILE_H, 0, 0, 0);
		//_map.setTileProperties(3, FlxObject.NONE);
		_walls.loadMap(FlxTilemap.arrayToCSV(walls, H), tiles, MapManager.TILE_W, MapManager.TILE_H);
	}
	
	public function get map():FlxTilemap { return _map; }
	public function get walls():FlxTilemap { return _walls; }
}
}