package faceless.state {
	import faceless.global.GameVar;
	import faceless.go.IActiveGO;
	
	public class NormalCondition implements IState {
		
		private var _target:IActiveGO;
		private var _param:Object;
		
		public function NormalCondition(target:IActiveGO, param:Object = null) {
			_target = target;
			if (!param) {
				param = {};
				param.speed = GameVar.BASE_HERO_SPEED;
			}
			_param = param;
		}
		
		public function focus():void {
			_target.sprite.color = 0xffffff;
			_target.speed = _param.speed;
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