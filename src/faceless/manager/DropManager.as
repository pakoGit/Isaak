package faceless.manager 
{
	import faceless.go.Hero;
	import faceless.go.drop.Soul;
	import faceless.go.Player;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;

public class DropManager 
{
	public static const SOUL:String = "soul";
	
	private var _parent:FlxGroup;
	private var _cont:FlxGroup;
	private var _map:Object;
	private var _active:Array;
	
	public function DropManager(cont:FlxGroup) 
	{
		_map = { };
		_map[SOUL] = Soul;
		_active = [];
		_parent = cont;
		_cont = new FlxGroup;
		_parent.add(_cont);
	}
	
	public function collide(target:Player):void {
		FlxG.overlap(_cont, target, onCollide);
	}
	
	public function add(type:String, param:Object):void {
		if (!_map.hasOwnProperty(type)) return;
		var loot:Soul = new Soul(param.x, param.y);
		_cont.add(loot);
		_active.push(loot);
		loot.velocity.x = param.sv.x * 120;
		loot.velocity.y = param.sv.y * 120;
	}
	
	public function remove(obj:FlxObject):void {
		for (var i:int = 0; i < _active.length; i++)
			if (_active[i] == obj) {
				_cont.remove(obj, true);
				break;
			}
		_active.splice(i, 1);
	}
	
	public function removeAll():void {
		for (var i:int = 0; i < _active.length; i++)
			_cont.remove(_active[i], true);
		_active.splice(0);
	}
	
	private function onCollide(obj1:FlxObject, obj2:FlxObject):void {
		if(obj2 is Hero){
			(obj1 as Soul).onHit(obj2 as Hero);
			remove(obj1);
		}
	}
	
}
}