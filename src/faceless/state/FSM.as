package faceless.state {
	
	public class FSM {
		public static const POISON:String = "poison";
		public static const SLOW:String = "slow";
		public static const NORMAL:String = "normal";
		
		private var _current:IState;
		private var _map:Object;
		private var _activeSet:Object;
		private var _active:Vector.<IState>;
		
		public function FSM() {
			_map = { };
			_active = new Vector.<IState>();
			_activeSet = { };
		}
		
		public function map(id:String, state:IState):void {
			if (_map[id]) return;
			_map[id] = state;
		}
		
		public function add(id:String):void {
			if (_map[id]) {
				if (!_activeSet[id]) {//добавить, если эффект еще нет. Иначе обновить
					_active.push(_map[id]);
					_activeSet[id] = 1;
				}
				_map[id].apply();
			}
		}
		
		public function remove(id:String):void {
			if (_map[id] && _activeSet[id]) {
				delete _activeSet[id];
				_active.splice(_active.indexOf(_map[id]), 1)
				_map[id].end();
				_active[_active.length-1].focus();
			}
		}
		
		public function update():void {
			for (var i:int = 0; i < _active.length; i++)
				_active[i].update();
		}
		
		public function get current():IState { return _current;}
	
	}
}