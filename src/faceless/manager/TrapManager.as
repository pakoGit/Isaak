package faceless.manager 
{
	import faceless.go.IActiveGO;
	import faceless.go.traps.ColdTrap;
	import faceless.go.traps.PoisonTrap;
	import faceless.go.traps.Trap;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxCollision;

public class TrapManager
{
	public static const POISON_TRAP:String = "poison";
	public static const COLD_TRAP:String = "slow";
	
	private var _cont:FlxGroup;
	private var _traps:Vector.<Trap>;
	private var _map:Object = { };
	
	private var _x:Number = 0;
	private var _y:Number = 0;
	
	public function TrapManager(cont:FlxGroup) 
	{
		_map[POISON_TRAP] = PoisonTrap;
		_map[COLD_TRAP] = ColdTrap;
		_cont = cont;
		_traps = new Vector.<Trap>();
	}
	
	public function add(id:String, X:int, Y:int):void {
		if (_map[id]) {
			var trap:Trap = new _map[id](X, Y);
			_cont.add(trap);
			_traps.push(trap);
		}
	}
	
	public function clear():void {
		var i:int = _traps.length;
		while (i--) {
			_cont.remove(_traps.pop());
		}
	}
	
	public function collide(target:IActiveGO):void {
		var i:int = _traps.length;
		while (i--) {
			if (FlxCollision.pixelPerfectCheck(target.sprite, _traps[i])) _traps[i].action(target);
		}
	}
	
	public function set x(X:Number):void {
		var off:Number = _x;
		_x = X;
		for each(var t:Trap in _traps)
			t.x = (t.x - off) + _x;
		
	}
	
	public function set y(Y:Number):void {
		var off:Number = _y;
		_y = Y;
		for each(var t:Trap in _traps)
			t.y = (t.y - off) + _y;
		
	}
}
}