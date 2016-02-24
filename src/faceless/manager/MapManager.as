package faceless.manager 
{
	import com.greensock.TweenLite;
	import faceless.go.Player;
	import faceless.map.Room;
	import faceless.map.LevelBuilder;
	import faceless.map.RoomBuilder;
	import flash.utils.setTimeout;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
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
		FlxG.collide(player.hero, current.walls);
		current.traps.collide(player);
	}
	
	public function nextMap(dir:int):void {
		_bSwapAnim = true;
		
		var map:Room = _builder.build();
		_cont.add(map);
		var X:int;
		var Y:int;
		if (dir == 0) {//left
			X = 640;
			Y = 0;
			map.x = -64*25;
		}else if (dir == 1) {//right
			X = -640;
			Y = 0;
			map.x = 64*25;
		}else if(dir == 2){//bot
			X = 0;
			Y = 480;
			map.y = -64*25;
		}else if(dir == 3){//top
			X = 0;
			Y = -480;
			map.y = 64*25;
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
	
}
}