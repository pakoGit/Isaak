package faceless.global {
import faceless.util.ExternalPng;
import flash.display.Bitmap;
import flash.display.Loader;
import flash.events.Event;
import flash.net.URLRequest;
import flash.text.Font;
import org.osflash.signals.Signal;

public class Assets {
	[Embed(source = "../../../lib/font/nokiafc22.ttf", fontName = "Nokia", fontStyle = "normal", fontWeight = "bold", mimeType = "application/x-font-truetype", advancedAntiAliasing = "true", embedAsCFF = "false")]
	private var uiFont:Class;
	CONFIG::release {
		[Embed(source = "../../../lib/effects.png")] private var effectsPNG:Class;
		[Embed(source="../../../bin/data/fire.png")] private var firePNG:Class;
		[Embed(source = "../../../lib/hero_beta.png")] private var heroPng:Class;
		//[Embed(source = "../../../lib/tiles.png")] private var tilesPng:Class;
		[Embed(source="../../../bin/data/1_tiles.png")] private var tilesPng:Class;
	}
	public static const HERO:String = "hero";
	public static const STEP_IN_DARK:String = "stepInDark";
	public static const TILES:String = "tiles";
	public static const FIRE:String = "fire";
	
	public static var READY:Signal = new Signal;
	
	private static var _map:Object = {};
	
	public function Assets() {
		Font.registerFont(uiFont);
		if (CONFIG::debug) {
			localLoad([ { id:HERO, url:"data/hero_beta.png" }, 
						{ id:TILES, url:"data/1_tiles.png" },
						{ id:FIRE, url:"data/fire.png" },
						{ id:STEP_IN_DARK, url:"data/stepDark.png" } ]);
		}else{
			_map[HERO] = heroPng;
			_map[TILES] = tilesPng;
			_map[FIRE] = firePNG;
			_map[STEP_IN_DARK] = effectsPNG;
			READY.dispatch();
		}
	}
	
	public static function getPng(id:String):* {
		if (CONFIG::debug) {
			var t:* = _map[id];
			ExternalPng.setData(t.content.bitmapData, t.id);
			return ExternalPng;
		}
		return _map[id];
	}
	
	private var ld:Object = { };
	private function localLoad(urls:Array):void {
		var i:int = urls.length;
		var count:int = 0;
		while(i--){
			var loader:Loader = new Loader();
			ld[urls[i].url] = { id:urls[i].id };
			loader.load(new URLRequest(urls[i].url));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
				var s:String = e.target.url;
				var id:String = s.slice(s.indexOf("data"));
				_map[ld[id].id] = {content:e.target.content, id:e.target.url};
				
				count++;
				if (count >= urls.length) 
					READY.dispatch();
			});
		}
	}
}
}