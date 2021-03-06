package faceless.map {
	import faceless.global.Assets;
	import faceless.manager.TrapManager;
	import faceless.util.ExternalPng;
	import flash.geom.Point;
	import org.flixel.FlxGroup;

public class RoomBuilder {	
	
	public function RoomBuilder() {
		
	}
	
	public var current:Room;
	public function build(w:int = 25, h:int = 25):Room {
		//var map:Object = current?generate(w, h):testMap();
		var map:Object = generate(w, h);
		current = new Room(map.m, map.p, map.w, map.h, Assets.getPng(Assets.TILES));
		var _traps:TrapManager = current.traps;
		/*_traps.add(TrapManager.POISON_TRAP, TILE_W * 6, 	TILE_W * 10);
		_traps.add(TrapManager.COLD_TRAP, 	TILE_W * 4, 	TILE_W * 12);
		_traps.add(TrapManager.POISON_TRAP, TILE_W * 17, 	TILE_W * 10);
		_traps.add(TrapManager.COLD_TRAP, 	TILE_W * 19, 	TILE_W * 12);
		_traps.add(TrapManager.COLD_TRAP, 	TILE_W * 8, 	TILE_W * 18);
		_traps.add(TrapManager.COLD_TRAP, 	TILE_W * 12, 	TILE_W * 5);*/
		return current;
	}
	
	private function generate(w:int, h:int):Object {
		var i:int;
		var j:int;
		var m:Array = [];//floor
		for (i = 0; i < w; i++)
			for (j = 0; j < h; j++)
				m[i * w + j] = 25 + int(Math.random() * 11);
		var p:Array = [];//проходимость
		var patterns:Array = [WallPattern.crossWall, WallPattern.middleButterfly, WallPattern.chessRandom, WallPattern.none];
		var pattern:Function = patterns[int(Math.random() * patterns.length)];
		pattern = WallPattern.none;
		for (i = 0; i < w; i++)
			for (j = 0; j < h; j++) {
				if (i == 0 && j == 0) {	//top left
					p[i * w + j] = 1 + int(Math.random() * 5);
					m[(i + 2) * w + j + 1] = 18; 
				}else if (i == 0 && j == h - 1) { //top right
					p[i * w + j] = 1 + int(Math.random() * 5);		
					m[(i + 2) * w + j - 1] = 20;
				}
				else if (i == w-1 && j == 0) p[i * w + j] = 1 + int(Math.random() * 5);		//bot left
				else if (i == w-1 && j == h-1) p[i * w + j] = 1 + int(Math.random() * 5);	//bot right
				else if (i > 0 && j == 0) { //left line
					p[i * w + j] = 1 + int(Math.random() * 5);
					if(i!=2) m[i * w + j + 1] = 21; 
				}
				else if (i > 0 && j == h - 1) { //right line
					p[i * w + j] = 1 + int(Math.random() * 5); 
					if(i!=2) m[i * w + j - 1] = 22; 
				}else if (i == 0 && j > 0) {//top line
					p[i * w + j] = 6 + int(Math.random() * 3);
				}else if (i == 1 && j > 0) {
					p[i * w + j] = 12 + int(Math.random() * 3);
					if(j!=1 && j!=h-2) m[(i+1) * w + j] = 19; 
				}
				else if (i == w - 1 && j > 0) p[i * w + j] = 1 + int(Math.random() * 5);	//bot line
				else p[i * w + j] = pattern(i, j);
			}
		//doors
		/*var rand:int = int(Math.random() * 10);
		rand = 9;
		if (rand > 2) {
			i = 0;
			j = h >> 1;
			p[i*w + j] = 12;
		}
		if (rand > 4) {
			i = w-1;
			j = h >> 1;
			p[i*w+j] = 13;
		}
		if (rand > 6) {
			i = w >> 1;
			j = 0;
			p[i*w+j] = 10;
		}
		if (rand > 8) {
			i = w >> 1;
			j = h-1;
			p[i*w+j] = 11;
		}*/

		return {m:m, p:p, w:w, h:h};
	}
	
	public function rebuild():void {
		var map:Object = generate(current.W, current.H);
		current.fill(map.m, map.p, map.w, map.h);
	}
		
	/*private function testMap():Object {
		var i:int;
		var j:int;
		var w:int = 25; var h:int = 25;
		var m:Array = [];//floor
			for (i = 0; i < w; i++)
				for (j = 0; j < h; j++)
					m[i * w + j] = int(Math.random() * 6);
		var p:Array = [];//проходимость
			for (i = 0; i < w; i++)
				for (j = 0; j < h; j++) {
					if (i == 0 && j == 0) p[i * w + j] = 6;
					else if (i == 0 && j == h-1) p[i * w + j] = 7;
					else if (i == w-1 && j == 0) p[i * w + j] = 8;
					else if (i == w-1 && j == h-1) p[i * w + j] = 9;
					else if (i > 0 && j == 0) p[i * w + j] = 14;
					else if (i > 0 && j == h-1) p[i * w + j] = 15;
					else if (i == 0 && j > 0) p[i * w + j] = 16;
					else if (i == w-1 && j > 0) p[i * w + j] = 17;
				}

		var p1:Array = [[4, 4], [18,4], [4,18],[18,18]];// 4 колоны
		while (p1.length > 0) {
			var p2:Array = p1.pop();
			p[p2[0] * w + p2[1]] = 6;
			p[p2[0] * w + p2[1] + 1] = 16;
			p[p2[0] * w + p2[1] + 2] = 7;
			p[(p2[0] + 1) * w + p2[1]] = 14;
			p[(p2[0] + 1) * w + p2[1] + 2] = 15;
			p[(p2[0] + 2) * w + p2[1]] = 8;
			p[(p2[0] + 2) * w + p2[1] + 1] = 17;
			p[(p2[0] + 2) * w + p2[1] + 2] = 9;
		}	
		return {m:m, p:p, w:w, h:h};
	}*/
	
}
}