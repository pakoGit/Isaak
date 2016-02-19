package faceless.state 
{
	import faceless.global.GameVar;
	import faceless.go.IActiveGO;

public class SlowState implements IState 
{
	private var duration:Number;
	private const strength:Number = 100;
	
	private var _target:IActiveGO;
	public function SlowState(target:IActiveGO) 
	{
		_target = target;
	}
	
	/* INTERFACE faceless.state.IState */
	
	public function focus():void {
		_target.sprite.color = 0x0000ff;
	}
	
	public function apply():void 
	{
		refresh();
		focus();
	}
	
	public function refresh():void {
		duration = GameVar.SLOW_DURATION;
		_target.speed = Math.max(_target.speed - strength, GameVar.MIN_HERO_SPEED);
	}
	
	public function update():void 
	{
		duration--;
		if (duration <= 0) {
			_target.state.remove(FSM.SLOW);
		}
	}
	
	public function end():void {
		_target.speed += strength;//!TODO опасно при достижении GameVar.MIN_HERO_SPEED
	}
}
}