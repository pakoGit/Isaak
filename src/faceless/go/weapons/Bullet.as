package faceless.go.weapons 
{
	import faceless.global.GameVar;
	import org.flixel.FlxSprite;

public class Bullet extends FlxSprite
{
	private const speed:Number = 6;
	private var _maxDistance:Number;
	private var _distance:Number;
	public var type:String;
	/**
	 * 
	 * @param	X
	 * @param	Y
	 * @param	speedX 1:right, -1:left
	 * @param	speedY 1:up, -1:down
	 * @param	distance
	 */
	public function Bullet(X:int = 0, Y:int = 0, speedX:Number = 0, speedY:Number = 0, distance:Number = 300){
		super(X - 16, Y - 16);
		makeGraphic(32, 32, 0xffff0000);
		speedXY(speedX, speedY);
		maxDistance = distance;
		Reset();
	}
	
	public function speedXY(speedX:Number = 0, speedY:Number = 0):void {
		velocity.x = speedX * speed;
		velocity.y = -speedY * speed;
	}
	
	public function set maxDistance(distance:Number):void {
		_maxDistance = distance;
	}
	
	public override function update():void {
		x += velocity.x;
		y += velocity.y;
		_distance += Math.abs(velocity.x||velocity.y);
		super.update();
	}
	
	public function isValid():Boolean {
		return _distance < _maxDistance;
	}
	
	public function Reset():void {
		_distance = 0;
	}
	
}
}