package faceless.go.drop {
	import faceless.go.Hero;
	import faceless.go.Player;
	import org.flixel.FlxSprite;
	
	public class Soul extends FlxSprite {
		
		public function Soul(X:int, Y:int) {
			super(X, Y);
			makeGraphic(32, 32, 0xdd00ff00);
		}
		
		public function onHit(hero:Hero):void {
			hero.parent.souls++;
		}
	
	}
}