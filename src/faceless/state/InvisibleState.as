package faceless.state 
{
	import faceless.effect.Wave;
	import faceless.global.GameVar;
	import faceless.go.IActiveGO;

public class InvisibleState implements IState 
{
	private var _target:IActiveGO;
	public function InvisibleState(target:IActiveGO) 
	{
		_target = target;
	}
	
	/* INTERFACE faceless.state.IState */
	
	public function focus():void 
	{
		_target.sprite.color = 0x000000;
	}
	
	private var _wave:Wave;
	public function apply():void 
	{
		focus();
		_wave = new Wave(_target.sprite.x, _target.sprite.y);
		GameVar.UP_LAYER.add(_wave);
	}
	
	public function refresh():void {
		
	}
	
	public function update():void 
	{
		_wave.x = _target.sprite.x;
		_wave.y = _target.sprite.y;
	}
	
	public function end():void 
	{
		GameVar.UP_LAYER.remove(_wave);
	}
	
}
}