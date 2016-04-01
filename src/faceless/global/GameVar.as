package faceless.global {
	import faceless.manager.BulletManager;
	import faceless.manager.MapManager;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class GameVar {
		public static const ZOOM:Number = 1.5;
		public static const SCREEN_W:int = 800;
		public static const SCREEN_H:int = 600;
		
		public static const TILE_W:int = 32;
		public static const TILE_H:int = 32;
		
		public static var ACTIVE_LAYER:FlxGroup;//zsort here
		public static var DARKNESS:FlxSprite;
		public static var UP_LAYER:FlxGroup;//draw after darkness layer;
		
		public static var BULLETS_MANAGER:BulletManager;
		public static var MAP_MANAGER:MapManager;
		
		public static const BASE_HERO_SPEED:Number = 160;
		public static const MIN_HERO_SPEED:Number = 50;
		
		public static const POISON_DURATION:Number = 400;
		public static const SLOW_DURATION:Number = 200;
		
		public static function get GAME_SCREEN_W():int { return SCREEN_W / ZOOM; }
		public static function get GAME_SCREEN_H():int { return SCREEN_H / ZOOM; }
	}
}