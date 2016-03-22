package faceless 
{
	import faceless.global.Assets;
	import faceless.global.GameVar;
	import faceless.scene.GameScene;
	import faceless.scene.MenuScene;
	import flash.ui.Mouse;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;

	public class Faceless extends FlxGame
	{
		
		public function Faceless() 
		{
			new Assets();
			//super(640, 480, MenuScene);
			super(GameVar.SCREEN_W, GameVar.SCREEN_H, MenuScene);
			//super(GameVar.SCREEN_W, GameVar.SCREEN_H, GameScene);
			//FlxGame pause screen _focus
			//FlxG.visualDebug = true;
			useSystemCursor = true;
			Mouse.show();
			FlxG.mouse.show();
		}
		
	}

}