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
			if (CONFIG::debug) {
				super(GameVar.SCREEN_W, GameVar.SCREEN_H, GameScene);
				FlxG.visualDebug = true;
			}else {
				super(GameVar.SCREEN_W, GameVar.SCREEN_H, MenuScene);
			}
			//FlxGame pause screen _focus
			useSystemCursor = true;
			Mouse.show();
			FlxG.mouse.show();
		}
		
	}

}