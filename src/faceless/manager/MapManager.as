package faceless.manager 
{
	import com.greensock.TweenLite;
	import faceless.global.GameVar;
	import faceless.go.Player;
	import faceless.map.Room;
	import faceless.map.LevelBuilder;
	import faceless.map.RoomBuilder;
	import flash.utils.setTimeout;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.osflash.signals.Signal;

public class MapManager 
{
	public static var MAP_CHANGED:Signal = new Signal;
	
	private var _builder:LevelBuilder;
	private var _cont:FlxGroup;
	private var _current:Room;
	
	private var _bSwapAnim:Boolean = false;
	
	public function MapManager(cont:FlxGroup) 
	{
		_cont = cont;
		_builder = new LevelBuilder();
	}
	
	public function create():void {
		_current = _builder.build();
		_cont.add(_current);
	}
	
	public function get current():Room {
		return _current;
	}
	
	public function collide(player:Player):void {
		if (_bSwapAnim) return;
		if (FlxG.collide(player.hero, current.walls)) {
			var ox:int = 20;//offset x
			var oy:int = 20;//offset y
			var speed:int = 64;
			var mock:FlxSprite = new FlxSprite(player.hero.x, player.hero.y);
			mock.width = player.hero.width;
			mock.height = player.hero.height;
			var xx:Number = player.hero.x;
			var yy:Number = player.hero.y;
			if (FlxG.keys.W) {
				if (!FlxG.keys.A && !FlxG.keys.D && !checkSide(ox, -oy, xx, yy, mock)) player.hero.velocity.x = speed;
				if (!FlxG.keys.A && !FlxG.keys.D && !checkSide( -ox, -oy, xx, yy, mock)) player.hero.velocity.x = -speed;
			}if (FlxG.keys.S) {
				if (!FlxG.keys.A && !FlxG.keys.D && !checkSide(ox, oy, xx, yy, mock)) player.hero.velocity.x = speed;
				if (!FlxG.keys.A && !FlxG.keys.D && !checkSide( -ox, oy, xx, yy, mock)) player.hero.velocity.x = -speed;
			}else if (FlxG.keys.A) {
				if (!FlxG.keys.W && !FlxG.keys.S && !checkSide(-ox, oy, xx, yy, mock)) player.hero.velocity.y = speed;
				if (!FlxG.keys.W && !FlxG.keys.S && !checkSide(-ox, -oy, xx, yy, mock)) player.hero.velocity.y = -speed;
			}if (FlxG.keys.D) {
				if (!FlxG.keys.W && !FlxG.keys.S && !checkSide(ox, oy, xx, yy, mock)) player.hero.velocity.y = speed;
				if (!FlxG.keys.W && !FlxG.keys.S && !checkSide(ox, -oy, xx, yy, mock)) player.hero.velocity.y = -speed;
			}
			mock = null;
			//проверка по карте проходимости движение вправо D = hero.x%32 >0.8 проверить нижнюю клетку, <0.2 верхнюю. 
		}
		current.traps.collide(player);
	}
	
	public function nextMap(dir:int):void {
		if (_bSwapAnim) return;
		_bSwapAnim = true;
		
		var map:Room = _builder.build();
		_cont.add(map);
		var X:int;
		var Y:int;
		if (dir == 0) {//left
			X = GameVar.GAME_SCREEN_W;
			Y = 0;
			map.x = -GameVar.TILE_W * 25;
		}else if (dir == 1) {//right
			X = -GameVar.GAME_SCREEN_W;
			Y = 0;
			map.x = GameVar.TILE_W * 25;
		}else if(dir == 2){//bot
			X = 0;
			Y = GameVar.GAME_SCREEN_H;
			map.y = -GameVar.TILE_H * 25;
		}else if(dir == 3){//top
			X = 0;
			Y = -GameVar.GAME_SCREEN_H;
			map.y = GameVar.TILE_H * 25;
		}
		TweenLite.to(_current, 0.4, { x:X, y: Y } );
		TweenLite.to(map, 0.4, {x:map.x+X, y:map.y + Y } );
		
		setTimeout(function():void {
			TweenLite.killTweensOf(_current);
			TweenLite.killTweensOf(map);
			_current.destroy();
			_cont.remove(_current);
			_current = map;
			MAP_CHANGED.dispatch();
			_bSwapAnim = false;
		}, 400);
	}
	
	private function checkSide(sx:Number, sy:Number, xx:Number, yy:Number, hero:FlxSprite):Boolean {
		hero.x += sx;
		hero.y += sy;
		var b:Boolean = FlxG.collide(hero, current.walls);
		hero.x = xx;
		hero.y = yy;
		return b;
	}
}
}