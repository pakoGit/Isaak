package faceless.scene {
	import app.go.hero.Hero;
	import faceless.manager.BulletManager;
	import faceless.manager.MapManager;
	import faceless.global.GameVar;
	import faceless.go.enemy.Ghost;
	import faceless.go.Player;
	import faceless.go.traps.ColdTrap;
	import faceless.go.traps.PoisonTrap;
	import faceless.go.traps.Trap;
	import faceless.gui.UIHero;
	import faceless.manager.EnemyManager;
	import faceless.manager.TrapManager;
	import faceless.map.Room;
	import faceless.map.RoomBuilder;
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
		private var _player:Player;
		private var _map:MapManager;
		//private var _roomBuilder:RoomBuilder;
		//private var _traps:TrapManager;
		private var _enemys:EnemyManager;
		private var _bullets:BulletManager;
		
		private var _active:FlxGroup;
		
		private var ui:UIHero;
		
		private var darkness:FlxSprite;
	
		public function GameScene() {
			
		}
		
		override public function create():void {
			var mapLayer:FlxGroup = new FlxGroup;
			var upLayer:FlxGroup = new FlxGroup;
			_map = new MapManager(mapLayer);
			darkness = new FlxSprite(0,0);
				darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
				darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
				darkness.blend = "multiply";
				darkness.ID = 0xee000000;
			_active = new FlxGroup();
			_bullets = new BulletManager;
			
			GameVar.DARKNESS = darkness;
			GameVar.UP_LAYER = upLayer;
			GameVar.ACTIVE_LAYER = _active;
			GameVar.BULLETS_MANAGER = _bullets;
			
			_player = new Player(64*12, 64*22);
			_enemys = new EnemyManager(_active, upLayer, _player, 200);
			ui = new UIHero(10, 10, 200, _player.hp);
			ui.scrollFactor.x = ui.scrollFactor.y = 0;
			
			_map.create();
			add(mapLayer);
			add(_active);
			_active.add(_player);
			//_enemys.add(64 * 2, 64 * 2, "ghost");
			//_enemys.add(64 * 22, 64 * 2, "ghost");
			add(darkness);
			add(upLayer);
			add(ui);
			FlxG.stage.addChild(new TestToolbox(_player, darkness));
			
			FlxG.worldBounds = new FlxRect(0, 0, _map.current.map.width, _map.current.map.height);
			FlxG.camera.setBounds(0, 0, _map.current.map.width, _map.current.map.height, true);
			FlxG.camera.follow(_player.hero);
			_player.cameras = new Array(FlxG.camera);
			
			Room.doorSignal.add(onDoorHit);
			MapManager.MAP_CHANGED.add(onMapChanged);
		}
		
		override public function update():void {
			super.update();
			if (_player.hp > 0) {
				_map.collide(_player);
			}
			_enemys.update();
			_bullets.update();
			_bullets.collide(_map.current.walls);
			_active.sort("y");
			ui.setHp(_player.hp);
		}
		
		override public function draw():void {
			darkness.fill(darkness.ID);
			super.draw();
		}
		
		private var _dir:int;
		private function onDoorHit(dir:int, obj:FlxObject):void {
			if(obj != _player.hero) return
			_dir = dir;
			_active.remove(_player);
			_player.hero.active = false;
			if (_dir == 0) {
				_player.hero.x = 64 * 1; 
				_player.hero.y = 64 * 12;
			}else if (_dir == 1) {
				_player.hero.x = 64 * 24; 
				_player.hero.y = 64 * 12;
			}else if (_dir == 2) {
				_player.hero.x = 64 * 12; 
				_player.hero.y = 64 * 1;
			}else if (_dir == 3) {
				_player.hero.x = 64 * 12; 
				_player.hero.y = 64 * 24;
			}
			_bullets.removeAll();
			_map.nextMap(dir);
		}
		
		private function onMapChanged():void {
			_map.current.x = 0;
			_map.current.y = 0;
			_player.hero.velocity.x = 0;
			_player.hero.velocity.y = 0;
			if (_dir == 0) {
				_player.hero.x = 64 * 23; 
				_player.hero.y = 64 * 12;
			}else if (_dir == 1) {
				_player.hero.x = 64 * 1; 
				_player.hero.y = 64 * 12;
			}else if (_dir == 2) {
				_player.hero.x = 64 * 12; 
				_player.hero.y = 64 * 23;
			}else if (_dir == 3) {
				_player.hero.x = 64 * 12; 
				_player.hero.y = 64 * 1;
			}
			_active.add(_player);
			_player.hero.active = true;
		}
	}

}