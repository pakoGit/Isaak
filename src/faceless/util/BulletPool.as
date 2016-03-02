package faceless.util 
{
	import faceless.global.GameVar;
	import faceless.go.weapons.Bullet;
	import org.flixel.FlxGroup;

public class BulletPool 
{
	private var _size:int;
	private var _pool:Object = { };//id: [obj, obj, ...]
	private var _active:Object = {};
	private var _cont:FlxGroup;
	
	public function BulletPool(cont:FlxGroup, size:int = 20) {
		_cont = cont;
		_size = size;
	}
	
	public function getObj(type:String, base:Class, param:Object):Bullet {
		var bul:Bullet;
		if (_pool.hasOwnProperty(type)) {
			var pl:int = _pool[type].length;
			if (pl > 0)	{
				bul = _pool[type].pop();
				bul.Reset();
				bul.x = param.x;
				bul.y = param.y;
				bul.speedXY(param.sx, param.sy);
			}
		}
		if (!bul) {
			_pool[type] = [];
			bul = new base(param.x, param.y, param.sx, param.sy);
			bul.type = type;
		}
		if (_active.hasOwnProperty(type))	_active[type].push(bul) else _active[type] = [bul];
		return bul;
	}
	
	public function remove(type:String, bul:Bullet):void {
		var arr:Array = _active[type];
		var i:int;
		for (i = 0; i < _active[type].length; i++)
			if (_active[type][i] == bul) break;
		_cont.remove(arr[i], true);
		_pool[type].push(arr[i]);
		arr.splice(i, 1)
	}
	
	public function removeAll():void {		
		for (var p:* in _active) {
			var i:int = _active[p].length;
			while(i--){
				remove(p, _active[p][i]);
			}
		}
	}
	
	public function clear():void {
		removeAll();
		for(var _p:* in _pool){
			for (var i:int = 0; i < _pool[_p].length; i++)
				_pool[_p][i].clear();
			_pool[_p].splice(0);
			delete _pool[_p];
		}
	}
	
	public function get active():Object { return _active;}
	
}
}