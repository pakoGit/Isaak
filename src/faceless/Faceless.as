package faceless {
import faceless.global.Assets;
import faceless.global.GameVar;
import faceless.scene.GameScene;
import faceless.scene.MenuScene;
import flash.ui.Mouse;
import org.flixel.FlxG;
import org.flixel.FlxGame;

public class Faceless extends FlxGame {
	
	public function Faceless() {
		if (CONFIG::debug) {
			super(GameVar.GAME_SCREEN_W, GameVar.GAME_SCREEN_H, GameScene, GameVar.ZOOM);
			//FlxG.visualDebug = true;
		} else {
			super(GameVar.GAME_SCREEN_W, GameVar.GAME_SCREEN_H, MenuScene, GameVar.ZOOM);
		}
		//FlxGame pause screen _focus
		useSystemCursor = true;
		Mouse.show();
		FlxG.mouse.show();
	}
}
}