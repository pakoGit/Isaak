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
		GameVar.BULLETS_MANAGER.spawn(BulletManager.DEFAULT, {x: x + speedY*2, y: y - 11, sx: speedX, sy: speedY});
	}
	
	public function passive():void {
	
	}
	
	public function ulti():void {
	
	}
	
	public function callback(param:Object = null):void {
	
	}

}
}