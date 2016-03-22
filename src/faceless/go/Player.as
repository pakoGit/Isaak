package faceless.go {
	import core.Light;
	import faceless.global.GameVar;
	import faceless.go.heroMask.BaseMask;
	import faceless.go.heroMask.DefaultMask;
	import faceless.go.heroMask.IHeroMask;
	import faceless.manager.BulletManager;
	import faceless.state.AttackState;
	import faceless.state.DeadState;
	import faceless.state.FSM;
	import faceless.state.NormalCondition;
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
		private var _condition:FSM;
		
		private var _heroMask:IHeroMask;
		private var _hero:Hero;
		private var _light:Light;
		
		public var souls:int = 0;
		
		public function Player(X:int = 0, Y:int = 0) {
			_hero = new Hero(X, Y);
			add(_hero);
			_hero.parent = this;
			
			_state = new FSM();
			_state.map(FSM.NORMAL, new NormalState(this));
			_state.map(FSM.ATTACK, new AttackState(this));
			_state.map(FSM.DEAD, new DeadState(this));
			_condition = new FSM();
			_condition.map(FSM.NORMAL_CONDITION, new NormalCondition(this));
			_condition.map(FSM.POISON, new PoisonState(this));
			_condition.map(FSM.SLOW, new SlowState(this));
			
			_state.add(FSM.NORMAL);
			_condition.add(FSM.NORMAL_CONDITION);
			
			_light = new Light(_hero.getScreenXY().x, _hero.getScreenXY().y, GameVar.DARKNESS);
			add(_light);
			
			_heroMask = new DefaultMask(this);
			add(_heroMask as FlxSprite);
			
			AttackState.onAttack.add(onAttack);
		}
		
		public function respawn():void {
			state.clear();
			_condition.clear();
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
				condition.clear();
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
			_state.updateOnlyCurrent();
			_condition.update();
			
			if (hp > 0) {
				var pos:FlxPoint = _hero.getMidpoint();
				_light.x = pos.x;
				_light.y = pos.y;
				(_heroMask as BaseMask).x = pos.x;
				(_heroMask as BaseMask).y = pos.y;
				
				if (FlxG.keys.Q){
					condition.add(FSM.POISON);
				}
				if (FlxG.keys.E){
					condition.add(FSM.SLOW);
				}
				if (FlxG.keys.RIGHT || FlxG.keys.LEFT || FlxG.keys.UP || FlxG.keys.DOWN) {
					state.add(FSM.ATTACK);
					state.current.callback( {r:FlxG.keys.RIGHT, l:FlxG.keys.LEFT, u:FlxG.keys.UP, d:FlxG.keys.DOWN } );
				}else {
					state.remove(FSM.ATTACK);
				}
			}
		}
		
		private function onAttack(param:Object):void {
			var pos:FlxPoint = _hero.getMidpoint();
			if(param.r || param.l)
				_heroMask.fire(pos.x, pos.y, param.r?1:-1);
			else if(param.u || param.d)
				_heroMask.fire(pos.x, pos.y, 0, param.u?1:-1);
		}
		
		public function get state():FSM {
			return _state;
		}
		
		public function get condition():FSM {
			return _condition;
		}
		
		public function get hero():Hero { return _hero; }
		public function get light():Light { return _light; }
		public function get x():Number { return _hero.x; }
		public function get y():Number { return _hero.y; }
		public function get sprite():FlxSprite { return _hero; }
	}
}