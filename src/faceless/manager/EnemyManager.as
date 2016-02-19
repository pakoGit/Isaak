package faceless.manager 
{
	import faceless.go.enemy.Ghost;
	import faceless.go.IActiveGO;
	import faceless.go.Player;
	import faceless.state.FSM;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;

public class EnemyManager 
{	
	private var _cont:FlxGroup;
	private var _waveLayer:FlxGroup;
	private var _distance:Number;
	private var _hero:Player;
	private var _enemys:Array = [];
	
	public function EnemyManager(cont:FlxGroup, waveLayer:FlxGroup, hero:Player, distance:Number = 100) 
	{
		_em = this;
		_cont = cont;
		_waveLayer = waveLayer;
		_distance = distance;
		_hero = hero;
	}
	
	public function set distance(n:Number):void {
		_distance = n;
	}
	public function get distance():Number { return _distance;}
	
	public function add(x:int, y:int, type:String):void {
		var sprite:Ghost = new Ghost(x,y, _hero);
		_cont.add(sprite);
		_enemys.push(sprite);
	}
	
	public function update():void {
		for (var i:int = 0; i < _enemys.length; i++) {
			var en:IActiveGO = _enemys[i];
			var dist:Number = Math.sqrt(Math.pow(_hero.x - en.sprite.x, 2) + Math.pow(_hero.y - en.sprite.y, 2));
			if (dist > _distance) {
				en.state.add(FSM.HIDEN);
			}else {
				en.state.remove(FSM.HIDEN);
			}
		}
	}
	
	private static var _em:EnemyManager;
	public static function Get():EnemyManager {
		return _em;
	}
}
}