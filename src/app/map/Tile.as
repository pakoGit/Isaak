package app.map {
	
public class Tile {
	public static const FREE:int = 0;
	public static const DOOR:int = 10;
	public static const BLOCK:int = 20;
	
	public static const SIZE:int = 64;
	
	public var state:int = FREE;
	
	public function Tile() {
	
	}

}
}