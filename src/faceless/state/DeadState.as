package faceless.state {
import faceless.go.IActiveGO;

public class DeadState implements IState {
	private var _target:IActiveGO;
	
	public function DeadState(target:IActiveGO) {
		_target = target;
	}
	
	public function focus():void {
	
	}
	
	public function apply():void {
		_target.sprite.color = 0xffffff;
		_target.sprite.play("die");
		_target.speed = 0;
	}
	
	public function refresh():void {
	
	}
	
	public function update():void {
	
	}
	
	public function end():void {
		_target.sprite.play("idle");
	}
	
	public function callback(param:Object = null):void {
	
	}

}
}