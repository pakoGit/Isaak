package faceless.go.traps {
	import faceless.go.IActiveGO;
	import faceless.state.FSM;
	import org.flixel.FlxSprite;
	
	public class Trap extends FlxSprite {
		[Embed(source = "../../../../lib/tiles/trap.png")]private var trapPng:Class;
		
		public function Trap(X:int, Y:int) {
			super(X, Y);
			loadGraphic(trapPng);
		}
		
		public function action(target:IActiveGO):void {	}
		
		private function recharge():void { }
	
	}
}