package faceless.state 
{
	import faceless.global.GameVar;
	import faceless.go.IActiveGO;

public class NormalState implements IState 
{
	private var _target:IActiveGO;
	private var _param:Object;
	public function NormalState(target:IActiveGO, param:Object = null) 
	{
		_target = target;
		if (!param) {
			param = { };
			param.speed = GameVar.BASE_HERO_SPEED;
		}
		_param = param;
	}
	
	/* INTERFACE faceless.state.IState */
	
	public function focus():void {
		_target.sprite.color = 0xffffff;
		_target.speed = _param.speed;
	}
	
	public function apply():void 
	{
		focus();
	}
	
	public function update():void 
	{
		
	}
	
	public function refresh():void {
		
	}
	
	public function end():void {
		
	}
}
}