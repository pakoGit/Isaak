package faceless.go.enemy {
	import faceless.go.IActiveGO;
	import faceless.go.Player;
	import faceless.state.FSM;
	import faceless.state.InvisibleSilenceState;
	import faceless.state.IState;
	import faceless.state.NormalState;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class Ghost extends FlxSprite implements IActiveGO {
		[Embed(source = "../../../../lib/tiles/idle1.png")]
		private var plPng:Class;
		private var _target:Player;
		private var _distance:Number = 200;
		private var _state:FSM;
		private var _speed:Number = 2.0;
		private var _hp:Number = 100;
		private var _targetPoint:FlxPoint = new FlxPoint;
		private var patrol:Array = [];
		
		public function Ghost(x:int, y:int, target:Player) {
			super(x, y);
			loadGraphic(plPng, true, true);
			addAnimation("move", [0]);
			addAnimation("move_up", [0]);
			addAnimation("idle", [0]);
			addAnimation("die", [0]);
			play("idle");
			_target = target;
			_state = new FSM();
			_state.map(FSM.NORMAL, new NormalState(this, {speed: _speed}));
			_state.map(FSM.HIDEN, new InvisibleSilenceState(this));
			_state.add(FSM.NORMAL);
			
			patrol.push([x, y]);
			patrol.push([x, y + 12 * 64]);
			moveTo(x, y + 12 * 64);
		}
		
		public override function update():void {
			super.update();
			acceleration.x = acceleration.y = 0;
			var tx:Number = _target.x + (_target.x > x ? -32 : 32);
			var ty:Number = _target.y;
			var angle:Number = Math.atan2(_targetPoint.y - y, _targetPoint.x - x);
			var dist:Number = Math.sqrt(Math.pow(tx - x, 2) + Math.pow(ty - y, 2));
			if (Math.abs(tx - x) > _speed || Math.abs(ty - y) > _speed) {
				x += Math.cos(angle) * _speed;
				y += Math.sin(angle) * _speed;
				if (dist < _distance && _target.hp > 0) {
					moveTo(tx, ty);
				} else if (Math.abs(_targetPoint.x - x) <= _speed && Math.abs(_targetPoint.y - y) <= _speed) {
					var i:int;
					i = _targetPoint.y == patrol[0][1] ? 1 : 0;
					moveTo(patrol[i][0], patrol[i][1]);
				}
			}
			_state.update();
		}
		
		public override function destroy():void {
			_state.clear();
			super.destroy();
		}
		
		public function moveTo(x:int, y:int):void {
			_targetPoint.x = x;
			_targetPoint.y = y;
		}
		
		/* INTERFACE faceless.go.IActiveGO */
		
		public function set speed(value:Number):void {
			_speed = value;
		}
		
		public function get speed():Number {
			return _speed;
		}
		
		public function get hp():Number {
			return _hp;
		}
		
		public function hit(d:Number):void {
		
		}
		
		public function get state():FSM {
			return _state;
		}
		
		public function get condition():FSM {
			return null;
		}
		
		public function get sprite():FlxSprite {
			return this;
		}
		
		//public function get x():Number { return this.x; }
		//public function get y():Number { return this.y; }
		
		public function set target(target:Player):void {
			_target = target;
		}
	
	}
}