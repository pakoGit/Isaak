package assets {

import core.TextureAtlas;
import flash.display.Bitmap;
import flash.utils.Dictionary;

public class Assets {
	private static var textures:Dictionary = new Dictionary;//словарик для хранения текстур
	private static var atlas:TextureAtlas;

	[Embed(source="../../lib/sprites.png")]
	private static var atlasPng:Class;

	[Embed(source="../../lib/sprites.xml", mimeType="application/octet-stream")]
	private static var atlasXml:Class;

	public static function init():void {
		//TextField.registerBitmapFont(new BitmapFont(Texture.fromBitmap(new fontPng), XML(new fontXml)), "Comic");
	}

	public static function get Atlas():TextureAtlas {
		if (!atlas) {
			//var texture:Texture = getTexture("atlasPng");
			var texture:Bitmap = new atlasPng;
			var xml:XML = XML(new atlasXml);
			atlas = new TextureAtlas(texture.bitmapData, xml);
		}
		return atlas;
	}

	/*public static function getTexture(name:String):Texture {
		if (!textures[name]) {
			var bitmap:Bitmap = new Assets[name]();
			textures[name] = Texture.fromBitmap(bitmap);
		}
		return textures[name];
	}*/
	
}
}