package faceless.go {
	import core.Light;
	import faceless.global.GameVar;
	import faceless.state.DeadState;
	import faceless.state.FSM;
	import faceless.state.NormalState;
	import faceless.state.PoisonState;
	import faceless.state.SlowState;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class Player extends FlxGroup implements IActiveGO {
		private var _hp:Number = 100;
		
		private var _state:FSM;
		private var _hero:Hero;
		private var _light:Light;
		
		public function Player(X:int = 0, Y:int = 0) {
			_hero = new Hero(X, Y);
			add(_hero);
			
			_state = new FSM();
			_state.map(FSM.NORMAL, new NormalState(this));
			_state.map(FSM.POISON, new PoisonState(this));
			_state.map(FSM.SLOW, new SlowState(this));
			_state.map(FSM.DEAD, new DeadState(this));
			_state.add(FSM.NORMAL);
			
			_light = new Light(_hero.getScreenXY().x, _hero.getScreenXY().y, GameVar.DARKNESS);
			add(_light);
		}
		
		public function respawn():void {
			state.clear();
			_hp = 100;
			state.add(FSM.NORMAL);
		}
		
		public function set speed(s:Number):void {
			_hero.speed = s;
		}
		
		public function hit(d:Number):void {
			_hp -= d;
			if (_hp < 0) {
				state.clear();
				state.add(FSM.DEAD);
			}
		}
		
		public function get hp():Number {
			return _hp
		}
		
		public function get speed():Number {
			return _hero.speed;
		}
		
		public override function update():void {
			super.update();
			_state.update();
			
			if (hp > 0) {				
				var pos:FlxPoint = _hero.getMidpoint();
				_light.x = pos.x;
				_light.y = pos.y;
				
				if (FlxG.keys.Q){
					state.add(FSM.POISON);
				}
				if (FlxG.keys.E){
					state.add(FSM.SLOW);
				}
			}
		}
		
		public function get state():FSM {
			return _state;
		}
		
		public function get hero():Hero { return _hero; }
		public function get light():Light { return _light; }
		public function get x():Number { return _hero.x; }
		public function get y():Number { return _hero.y; }
		public function get sprite():FlxSprite { return _hero; }
	}
}