package faceless.state {
	import faceless.effect.Wave;
	import faceless.global.GameVar;
	import faceless.go.IActiveGO;
	
	public class InvisibleSilenceState implements IState {
		protected var _target:IActiveGO;
		
		public function InvisibleSilenceState(target:IActiveGO) {
			_target = target;
		}
		
		/* INTERFACE faceless.state.IState */
		
		public function focus():void {
			_target.sprite.color = 0x000000;
		}
		
		public function apply():void {
			focus();
		}
		
		public function refresh():void {
		
		}
		
		public function update():void {
		
		}
		
		public function end():void {
		
		}
		
		public function callback(param:Object = null):void {
		
		}
	
	}
}