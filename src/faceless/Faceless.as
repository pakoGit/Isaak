package faceless 
{
	import faceless.scene.GameScene;
	import faceless.scene.MenuScene;
	import flash.ui.Mouse;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;

	public class Faceless extends FlxGame
	{
		
		public function Faceless() 
		{
			//super(640, 480, MenuScene);
			super(640, 480, GameScene);
			//FlxGame pause screen _focus
			Mouse.show();
			FlxG.mouse.show();
		}
		
	}

}