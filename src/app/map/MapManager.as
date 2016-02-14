package app.map {

public class MapManager {
	
	public function MapManager() {
		
	}
	
	public function buildRoom():Array {
		var m:Array = new Array;
		for (var i:int = 0; i < 10; i++) {
			m[i] = [];
			for (var j:int = 0; j < 8; j++) {
				m[i][j] = int(Math.random() * 6 + 1);
			}
		}
		return m;
	}
	
}
}