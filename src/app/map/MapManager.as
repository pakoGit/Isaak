package app.map {

public class MapManager {
	private static const w:int = 10;
	private static const h:int = 8;
	
	public function MapManager() {
		
	}
	
	public static var current:Room;
	public static function buildRoom():Room {
		var map:Object = generate();
		current = new Room(map.m, map.p);
		return current;
	}
	
	private static function generate():Object {
		var m:Array = new Array;//floor
		var p:Array = [];//проходимость
		var id:int;
		for (var i:int = 0; i < w; i++) {
			m[i] = [];
			p[i] = [];
			for (var j:int = 0; j < h; j++) {
				m[i][j] = int(Math.random() * 6 + 1);
				p[i][j] = Tile.FREE;
				if (i == 0 || i == w - 1 || j == 0 || j == h - 1) {					
					p[i][j] = Tile.BLOCK;
				}
			}
		}
		var rand:int = int(Math.random() * 10);
		if (rand > 2) {
			i = 0;
			j = h >> 1;
			p[i][j] = Tile.DOOR;
		}
		if (rand > 4) {
			i = w-1;
			j = h >> 1;
			p[i][j] = Tile.DOOR;
		}
		if (rand > 6) {
			i = w >> 1;
			j = 0;
			p[i][j] = Tile.DOOR;
		}
		if (rand > 8) {
			i = w >> 1;
			j = h-1;
			p[i][j] = Tile.DOOR;
		}
		return {m:m, p:p};
	}
	
	public static function rebuild():void {
		var map:Object = generate();
		current.fill(map.m, map.p);
	}
	
}
}