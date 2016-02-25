package faceless.map 
{

public class WallPattern 
{
	
	public static function crossWall(i:int, j:int):int {
		if (i == j && (j < 11 || j>13)) return 6;
		if (i == 24 - j && (i < 11 || i>13)) return 6;
		return 0;
	}
	
	public static function chessRandom(i:int, j:int):int {
		if (i > 2 && i < 23 && j > 2 && j < 23) {
			var ic:int = i % 2;
			var jc:int = j % 2;
			if ((ic == 0 && jc != 0) || (ic != 0 && jc == 0)) return int(Math.random() * 10) > 5?6:0;
		}
		return 0;
	}
	
	public static function middleButterfly(i:int, j:int):int {
		if (i == j && (j > 2 && j<22)) return 6;
		if (i == 24 - j && (i > 2 && i<22)) return 6;
		return 0;
	}
	
}
}