package faceless.go.heroMask {
import faceless.global.GameVar;
import faceless.go.IActiveGO;
import faceless.go.weapons.Bullet;
import faceless.manager.BulletManager;

public class DefaultMask extends BaseMask implements IHeroMask {
	
	public function DefaultMask(target:IActiveGO) {
		super(target);
		//makeGraphic(1, 1, 0xffff0000);
		visible = false;
	}
	
	public function fire(x:int, y:int, speedX:Number = 0, speedY:Number = 0):void {
		if (isReadyToFire() == false) return;
		_recharge = _fullRecharge;
		GameVar.BULLETS_MANAGER.spawn(BulletManager.DEFAULT, {x: x + speedY*2, y: y - 20, sx: speedX, sy: speedY});
	}
	
	public function passive():void {
	
	}
	
	public function ulti(x:int, y:int, speedX:Number = 0, speedY:Number = 0):void {
		if (isReadyToFire() == false) return;
		_recharge = _fullRecharge;
		for (var i:int = 0; i < 20; i++)//12
			GameVar.BULLETS_MANAGER.spawn(BulletManager.FIRE, { x: x + speedY * 2, y: y - 20, sx: Math.cos(i), sy: Math.sin(i) } );
	}
	
	public function callback(param:Object = null):void {
	
	}

}
}