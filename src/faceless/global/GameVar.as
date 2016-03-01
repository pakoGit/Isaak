package faceless.global {
	import faceless.manager.BulletManager;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class GameVar {
		public static var ACTIVE_LAYER:FlxGroup;//zsort here
		public static var DARKNESS:FlxSprite;
		public static var UP_LAYER:FlxGroup;//draw after darkness layer;
		
		public static var BULLETS_MANAGER:BulletManager;
		
		public static const BASE_HERO_SPEED:Number = 160;
		public static const MIN_HERO_SPEED:Number = 50;
		
		public static const POISON_DURATION:Number = 400;
		public static const SLOW_DURATION:Number = 200;
	}
}