package faceless.state 
{
	import faceless.effect.Wave;
	import faceless.global.GameVar;
	import faceless.go.IActiveGO;

public class InvisibleState extends InvisibleSilenceState 
{
	public function InvisibleState(target:IActiveGO) 
	{
		super(target);
	}
	
	private var _wave:Wave;
	public override function apply():void 
	{
		super.apply();
		_wave = new Wave(_target.sprite.x, _target.sprite.y);
		GameVar.UP_LAYER.add(_wave);
	}
	
	public override function update():void 
	{
		_wave.x = _target.sprite.x;
		_wave.y = _target.sprite.y;
	}
	
	public override function end():void 
	{
		GameVar.UP_LAYER.remove(_wave);
	}
	
}
}