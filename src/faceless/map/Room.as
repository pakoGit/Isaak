package faceless.map {
import core.GameObj;
import faceless.global.GameVar;
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
import org.yyztom.pathfinding.astar.AStar;
import org.yyztom.pathfinding.astar.AStarNodeVO;

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
	
	public var enemySpawnArea:Object = [[1,8],[23,8]];
	public var trapSpawnArea:Object = [];
	
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
		_map.loadMap(FlxTilemap.arrayToCSV(map, W), tiles, GameVar.TILE_W, GameVar.TILE_H, 0, 0, 0);
		_walls.loadMap(FlxTilemap.arrayToCSV(walls, H), tiles, GameVar.TILE_W, GameVar.TILE_H);
		_walls.setTileProperties(10, FlxObject.ANY, function(tile:FlxTile, obj:FlxObject):void { doorSignal.dispatch(0, obj); } );
		_walls.setTileProperties(11, FlxObject.ANY, function(tile:FlxTile, obj:FlxObject):void { doorSignal.dispatch(1, obj); } );
		_walls.setTileProperties(12, FlxObject.ANY, function(tile:FlxTile, obj:FlxObject):void { doorSignal.dispatch(2, obj); } );
		_walls.setTileProperties(13, FlxObject.ANY, function(tile:FlxTile, obj:FlxObject):void { doorSignal.dispatch(3, obj); } );
		initNodesForAStar();
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
	
	private var _aStarNodes : Vector.<Vector.<AStarNodeVO>>;
	private var _astar : AStar;
	private function initNodesForAStar() : void {
		_aStarNodes = new Vector.<Vector.<AStarNodeVO>>();
		var _previousNode : AStarNodeVO;
		
		var x : uint = 0;
		var z : uint = 0;
		
		while ( x < 25 ) {
			_aStarNodes[x] = new Vector.<AStarNodeVO>();
			
			while ( z < 25 ){
				var node :AStarNodeVO  = new AStarNodeVO();
				node.next = _previousNode;
				node.h = 0;
				node.f = 0;
				node.g = 0;
				node.visited = false;
				node.parent = null;
				node.closed = false;
				node.isWall = _walls.getTile(x,z) !=0;
				node.position = new Point(x, z);
				_aStarNodes[x][z]  = node;
				_previousNode = node;
				
				z++;
			}
			z=0;
			x++;
		}
		_astar = new AStar(_aStarNodes);
	}
	
	public function findPath(xx:int, yy:int, tx:int, ty:int):Vector.<AStarNodeVO> { return _astar.search(_aStarNodes[int(xx / GameVar.TILE_W)][int(yy / GameVar.TILE_H)], _aStarNodes[int(tx / GameVar.TILE_W)][int(ty / GameVar.TILE_H)]); }
	public function get map():FlxTilemap { return _map; }
	public function get walls():FlxTilemap { return _walls; }
	public function get traps():TrapManager { return _traps; }
	public function get x():Number { return _x };
	public function get y():Number { return _y };
}
}