package faceless.state 
{
	import faceless.global.GameVar;
	import faceless.go.IActiveGO;
	import faceless.state.IState;
	

public class PoisonState implements IState 
{
	private var duration:Number;
	
	private var _target:IActiveGO;
	public function PoisonState(target:IActiveGO) 
	{
		_target = target;
	}
	
	public function focus():void {
		_target.sprite.color = 0x00ff00;
	}
	
	public function apply():void 
	{
		refresh();
		focus();
	}
	
	public function refresh():void {
		duration = GameVar.POISON_DURATION;
	}
	
	public function update():void 
	{
		duration--;
		_target.hit(1);
		if (duration <= 0) {
			_target.state.remove(FSM.POISON);
		}
	}
	
	public function end():void {
		
	}
}
}