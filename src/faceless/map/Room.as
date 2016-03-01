package faceless.map {
import assets.Assets;
import core.GameObj;
import faceless.manager.TrapManager;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;
import org.flixel.FlxGroup;
import org.flixel.FlxObject;
import org.flixel.FlxTilemap;
import org.flixel.system.FlxTile;
import org.osflash.signals.Signal;

public class Room extends FlxGroup {
	public static var doorSignal:Signal = new Signal(int, FlxObject);
	
	private var tiles:Class;
	private var _map:FlxTilemap;
	private var _walls:FlxTilemap;
	
	private var _traps:TrapManager;
	private var _upL:FlxGroup;
	
	public var W:int;
	public var H:int;
	private var _x:Number = 0;
	private var _y:Number = 0;
		
	public function Room(arr:Array, walls:Array, w:int, h:int, tiles:Class) {
		this.tiles = tiles;
		_map = new FlxTilemap();
		_walls = new FlxTilemap();
		add(_map);
		add(_walls);
		fill(arr, walls, w, h);
		
		_upL = new FlxGroup;
		add(_upL);
		_traps = new TrapManager(_upL);
	}
	
	public override function destroy():void {
		_traps.clear();
		remove(_upL);
		remove(_map);
		remove(_walls);
		super.destroy();
	}
	
	public function fill(map:Array, walls:Array, w:int, h:int):void {
		W = w;
		H = h;
		_map.loadMap(FlxTilemap.arrayToCSV(map, W), tiles, RoomBuilder.TILE_W, RoomBuilder.TILE_H, 0, 0, 0);
		_walls.loadMap(FlxTilemap.arrayToCSV(walls, H), tiles, RoomBuilder.TILE_W, RoomBuilder.TILE_H);
		_walls.setTileProperties(10, FlxObject.ANY, function(tile:FlxTile, obj:FlxObject):void { doorSignal.dispatch(0, obj); } );
		_walls.setTileProperties(11, FlxObject.ANY, function(tile:FlxTile, obj:FlxObject):void { doorSignal.dispatch(1, obj); } );
		_walls.setTileProperties(12, FlxObject.ANY, function(tile:FlxTile, obj:FlxObject):void { doorSignal.dispatch(2, obj); } );
		_walls.setTileProperties(13, FlxObject.ANY, function(tile:FlxTile, obj:FlxObject):void { doorSignal.dispatch(3, obj); } );
	}
	
	public function set x(X:Number):void { 
		_x = X;
		_map.x = _x;
		_walls.x = _x;
		_traps.x = _x;
	};
	public function set y(Y:Number):void { 
		_y = Y;
		//setAll("y", { y:_y } );
		_map.y = _y;
		_walls.y = _y;
		_traps.y = _y;
	};
	
	public function get map():FlxTilemap { return _map; }
	public function get walls():FlxTilemap { return _walls; }
	public function get traps():TrapManager { return _traps; }
	public function get x():Number { return _x };
	public function get y():Number { return _y };
}
}