package faceless.manager 
{
	import faceless.global.GameVar;
	import faceless.go.weapons.Bullet;
	import faceless.util.BulletPool;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;

public class BulletManager 
{
	public static var DEFAULT:String = "def";
	public static var FIRE:String = "fire";
	public static var ICE:String = "ice";
	
	private var _bullet:Bullet;
	private var _pool:BulletPool;
	private var _map:Object;
	private var _cont:FlxGroup;
	
	public function BulletManager(cont:FlxGroup) {
		_cont = cont;
		_map = { };
		_map[DEFAULT] = Bullet;
		_map[FIRE] = Bullet;
		_map[ICE] = Bullet;
		
		_pool = new BulletPool(cont);
	}
	
	public function spawn(type:String, param:Object):void {
		var bullet:* = _pool.getObj(type, _map[type], param);
		_cont.add(bullet);
	}
	
	public function remove(obj:*):void {
		_pool.remove(obj.type, obj);
	}
	
	public function collide(target:FlxBasic):void {
		FlxG.collide(_cont, target, onCollide);
		/*var pool:Object = _pool.active;
		for(var p:* in pool){
			var i:int = pool[p].length;
			while (i--) {
				FlxG.collide(pool[p][i], target, onCollide);
			}
		}*/
	}
	
	public function update():void {
		var pool:Object = _pool.active;
		for(var p:* in pool){
			var i:int = pool[p].length;
			while(i--){
				if (!pool[p][i].isValid()) {
					_pool.remove(p, pool[p][i]);
				}
			}
		}
	}
	
	public function removeAll():void {
		_pool.removeAll();
	}
	
	public function get cont():FlxGroup { return _cont;}
	
	private function onCollide(obj1:*, obj2:FlxObject):void {
		if (obj1 is Bullet) _pool.remove(obj1.type, obj1);
	}
	
}
}