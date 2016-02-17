package faceless.state 
{
	import faceless.global.GameVar;
	import faceless.go.IActiveGO;

public class NormalState implements IState 
{
	private var _target:IActiveGO;
	public function NormalState(target:IActiveGO) 
	{
		_target = target;
	}
	
	/* INTERFACE faceless.state.IState */
	
	public function focus():void {
		_target.sprite.color = 0xffffff;
		_target.speed = GameVar.BASE_HERO_SPEED;
	}
	
	public function apply():void 
	{
		focus();
	}
	
	public function update():void 
	{
		
	}
	
	public function end():void {
		
	}
}
}