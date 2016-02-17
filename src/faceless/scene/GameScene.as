package faceless.scene {
	import faceless.map.MapManager;
	import faceless.util.TestToolbox;
	import core.Light;
	import faceless.go.Hero;
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
	import org.flixel.FlxTilemap;
	
	public class GameScene extends FlxState {
		[Embed(source = "../../../lib/tiles/idle1.png")]
		private var plPng:Class;
		
		private var _player:Hero;
		//private var _map:FlxTilemap;
		//private var _walls:FlxTilemap;
		private var _mapManager:MapManager;
		private var _active:FlxGroup;
		
		private var darkness:FlxSprite;
		private var light:Light;
		
		public function GameScene() {
			
		}
		
		override public function create():void {
			_mapManager = new MapManager;
			add(_mapManager.buildRoom());
			
			_active = new FlxGroup();
			add(_active);
			_player = new Hero(64*2, 64*2);
			//_player.drag.x = 240;
			
			_active.add(_player);
			
			var sp:FlxSprite = new FlxSprite(64*10, 64*10, plPng);
			_active.add(sp);
			
			FlxG.worldBounds = new FlxRect(0, 0, _mapManager.current.map.width, _mapManager.current.map.height);
			FlxG.camera.setBounds(0, 0, _mapManager.current.map.width, _mapManager.current.map.height, true);
			FlxG.camera.follow(_player);
			
			_player.cameras = new Array(FlxG.camera);
			
			darkness = new FlxSprite(0,0);
			  darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
			  darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
			  darkness.blend = "multiply";
			  darkness.ID = 0xee000000;
			
			
			light = new Light(_player.getScreenXY().x, _player.getScreenXY().y, darkness);
			add(light);
			add(darkness);
			
			FlxG.stage.addChild(new TestToolbox(_player, light, darkness, _mapManager.current.map));
		}
		
		override public function update():void {
			_active.sort("y");
			super.update();
			FlxG.collide(_player, _mapManager.current.walls);
		}
		
		override public function draw():void {
			var pos:FlxPoint = _player.getMidpoint();
			light.x = pos.x;
			light.y = pos.y;
			darkness.fill(darkness.ID);
			super.draw();
		}
	}

}