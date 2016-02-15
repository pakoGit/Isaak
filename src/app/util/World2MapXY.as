package app.util {
	import app.map.Tile;
	import flash.geom.Point;
	
	public class World2MapXY {
		
		public static function calc(x:Number, y:Number):Point {
			return new Point(int(x/Tile.SIZE), int(y/Tile.SIZE));
		}
	
	}

}