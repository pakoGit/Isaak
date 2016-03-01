package faceless.go.heroMask 
{
	import faceless.go.IActiveGO;
	import faceless.manager.BulletManager;
	import org.flixel.FlxSprite;

public class BaseMask extends FlxSprite
{
	protected const _fullRecharge:Number = 50;
	protected var _target:IActiveGO;
	protected var _recharge:Number = 0.0;
	protected var _bullets:BulletManager;
	
	public function BaseMask(target:IActiveGO) 
	{
		_target = target;
		_bullets = new BulletManager;
		super(_target.sprite.x, _target.sprite.y);
	}
	
	public override function update():void {
		if (_recharge > 0) _recharge--;
		super.update();
	}
	
	protected function isReadyToFire():Boolean {
		return _recharge <= 0;
	}
	
}
}