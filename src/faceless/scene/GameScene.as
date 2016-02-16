package faceless.scene {
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
		[Embed(source = "../../../lib/tiles.png")]
		private var flootTiles:Class;
		[Embed(source = "../../../lib/tiles/idle1.png")]
		private var plPng:Class;
		
		private var _player:Hero;
		private var _map:FlxTilemap;
		private var _walls:FlxTilemap;
		private var _active:FlxGroup;
		
		private var darkness:FlxSprite;
		private var light:Light;
		
		public function GameScene() {
			
		}
		
		override public function create():void {
			//25 25
			var arr:Array = [];
			for (var i:int = 0; i < 25; i++)
				for (var j:int = 0; j < 25; j++)
					arr[i*25+ j] = int(Math.random()*6);
			_map = new FlxTilemap();
			_map.loadMap(FlxTilemap.arrayToCSV(arr, 25), flootTiles, 64, 64, 0, 0, 0);
			//_map.setTileProperties(3, FlxObject.NONE);
			add(_map);
			
			var arr2:Array = [];
			for (var i:int = 0; i < 25; i++)
				for (var j:int = 0; j < 25; j++) {
					if (i == 0 && j == 0) arr2[i * 25 + j] = 6;
					else if (i == 0 && j == 24) arr2[i * 25 + j] = 7;
					else if (i == 24 && j == 0) arr2[i * 25 + j] = 8;
					else if (i == 24 && j == 24) arr2[i * 25 + j] = 9;
					else if (i > 0 && j == 0) arr2[i * 25 + j] = 14;
					else if (i > 0 && j == 24) arr2[i * 25 + j] = 15;
					else if (i == 0 && j > 0) arr2[i * 25 + j] = 16;
					else if (i == 24 && j > 0) arr2[i * 25 + j] = 17;
				}
			_walls = new FlxTilemap();
			_walls.loadMap(FlxTilemap.arrayToCSV(arr2, 25), flootTiles, 64, 64);
			add(_walls);
			
			_active = new FlxGroup();
			add(_active);
			_player = new Hero(64*2, 64*2);
			//_player.drag.x = 240;
			
			_active.add(_player);
			
			var sp:FlxSprite = new FlxSprite(64*6, 64*6, plPng);
			_active.add(sp);
			
			FlxG.worldBounds = new FlxRect(0, 0, _map.width, _map.height);
			FlxG.camera.setBounds(0, 0, _map.width, _map.height, true);
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
			
			FlxG.stage.addChild(new TestToolbox(_player, light, darkness, _map));
		}
		
		override public function update():void {
			_active.sort("y");
			super.update();
			FlxG.collide(_player, _walls);
		}
		
		override public function draw():void {
			var pos:FlxPoint = _player.getMidpoint();
			light.x = pos.x;
			light.y = pos.y;
			darkness.fill(darkness.ID);
			super.draw();
			
			/*var darkness:Sprite = new Sprite();
			darkness.blendMode = BlendMode.MULTIPLY;
			var light:Shape = new Shape();
			light.blendMode = BlendMode.ERASE;
			darkness.addChild(light);
			darkness.graphics.clear();
			darkness.graphics.beginFill(0xFF000000);
			darkness.graphics.drawRect(0, 0, 640, 540);
			var pos:FlxPoint = _player.getScreenXY(new FlxPoint(_player.x, _player.y), FlxG.camera);
			darkness.graphics.drawCircle(pos.x +32, pos.y + 32, 140);
			FlxG.camera.buffer.draw(darkness);*/
		}
	}

}