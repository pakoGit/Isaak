package app.manager {
	import app.map.Tile;
	import app.util.World2MapXY;
	import flash.geom.Point;
	
public class CollisionManager {
	
	public function CollisionManager() {
	
	}
	
	public static function check(obj1:*, obj2:*):Boolean {
		return false;
	}
	
	public static function checkByCoord(x:Number, y:Number, map:Array):Boolean {
		var p:Point = World2MapXY.calc(x, y);
		return map[p.x][p.y] == Tile.FREE;
	}

}
}