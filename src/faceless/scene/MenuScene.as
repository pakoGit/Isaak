package faceless.scene {
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	
	public class MenuScene extends FlxState {
		private var startbtn:FlxButton;
		
		public function MenuScene() {
		
		}
		
		override public function create():void {
			//FlxG.mouse.show();
			startbtn = new FlxButton(FlxG.width>>1, FlxG.height>>1, "start game", onStartBtn);
			add(startbtn);
		}
		
		private function onStartBtn():void {
			//FlxG.mouse.hide();
			FlxG.switchState(new GameScene);
		}
	
	}

}