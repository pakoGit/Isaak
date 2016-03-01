package faceless.go.heroMask 
{
	
public interface IHeroMask 
{
	/**
	 * 
	 * @param	X
	 * @param	Y
	 * @param	speedX 1:right, -1:left
	 * @param	speedY 1:up, -1:down
	 * @param	distance
	 */
	function fire(x:int, y:int, speedX:Number = 0, speedY:Number = 0):void;
	function passive():void;
	function ulti():void;
}
	
}