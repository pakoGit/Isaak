package faceless.effect 
{
	import faceless.global.Assets;
	import org.flixel.FlxSprite;

public class Wave extends FlxSprite
{
	public function Wave(x:int, y:int) 
	{
		super(x, y);
		loadGraphic(Assets.getPng(Assets.STEP_IN_DARK), true, false, 102, 102);
		addAnimation("wave", [2, 1, 3, 0], 2);
		play("wave");
		//addAnimationCallback(function():void {  } );
		solid = false;
	}
	
}
}