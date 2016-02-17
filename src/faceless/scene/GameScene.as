package faceless.scene {
	import faceless.global.GameVar;
	import faceless.go.Player;
	import faceless.go.traps.ColdTrap;
	import faceless.go.traps.PoisonTrap;
	import faceless.go.traps.Trap;
	import faceless.manager.TrapManager;
	import faceless.map.MapManager;
	import faceless.util.TestToolbox;
	import flash.display.BlendMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.plugin.photonstorm.FlxCollision;
	
	public class GameScene extends FlxState {
		[Embed(source = "../../../lib/tiles/idle1.png")]
		private var plPng:Class;
		
		private var _player:Player;
		private var _mapManager:MapManager;
		private var _traps:TrapManager;
		private var _active:FlxGroup;
		
		private var darkness:FlxSprite;
	
		public function GameScene() {
			
		}
		
		override public function create():void {
			var botLayer:FlxGroup = new FlxGroup;
			_mapManager = new MapManager;
			_traps = new TrapManager(botLayer);
			
			darkness = new FlxSprite(0,0);
			  darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
			  darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
			  darkness.blend = "multiply";
			  darkness.ID = 0xee000000;
			GameVar.DARKNESS = darkness;
			
			_active = new FlxGroup();
			_player = new Player(64*12, 64*22);
			var sp:FlxSprite = new FlxSprite(64 * 10, 64 * 10, plPng);
			_traps.add(TrapManager.POISON_TRAP, 64 * 6, 64 * 10);
			_traps.add(TrapManager.COLD_TRAP, 64 * 4, 64 * 12);
			_traps.add(TrapManager.POISON_TRAP, 64 * 17, 64 * 10);
			_traps.add(TrapManager.COLD_TRAP, 64 * 19, 64 * 12);
			_traps.add(TrapManager.COLD_TRAP, 64 * 8, 64 * 18);
			_traps.add(TrapManager.COLD_TRAP, 64 * 12, 64 * 5);

			add(_mapManager.buildRoom());
			add(botLayer);
			add(_active);
			_active.add(_player);
			_active.add(sp);
			add(darkness);
			FlxG.stage.addChild(new TestToolbox(_player, darkness, _mapManager.current.map));
			
			FlxG.worldBounds = new FlxRect(0, 0, _mapManager.current.map.width, _mapManager.current.map.height);
			FlxG.camera.setBounds(0, 0, _mapManager.current.map.width, _mapManager.current.map.height, true);
			FlxG.camera.follow(_player.hero);
			_player.cameras = new Array(FlxG.camera);
		}
		
		override public function update():void {
			_active.sort("y");
			super.update();
			FlxG.collide(_player.hero, _mapManager.current.walls);
			_traps.collide(_player);
		}
		
		override public function draw():void {
			darkness.fill(darkness.ID);
			super.draw();
		}
	}

}