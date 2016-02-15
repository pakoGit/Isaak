package core {
	import assets.Assets;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BmpAnimation {
		private var _anim:Object = {};
		private var _bd:BitmapData;
		public var current:*;
		
		public function BmpAnimation(bd:BitmapData) {
			_bd = bd;
		}
		
		public function add(id:String, prefix:String, speed:int, range:Array = null):void {
			var textures:Array = Assets.Atlas.getTextures(prefix);
			if (!range) range = [0, textures.length];
			var ID:String = id.toLowerCase();
			_anim[ID] = {id:ID, frame:range[0], speed:speed, start:range[0], total:range[1] ,source:textures};
		}
		
		public function setAnim(id:String):void {
			var nid:String = id.toLowerCase();
			if (current && current.id == nid) return;
			current = _anim[nid];
			frameCount = current.speed - 1;
		}
		
		private var frameCount:int = 0;
		public function next():void {
			if (!current) return;
			frameCount++;
			if (frameCount % current.speed != 0) return;
			frameCount = 0;
			_bd.lock();
			_bd.fillRect(_bd.rect, 0);
			var cur:Object = current.source[current.frame];
			_bd.copyPixels(Assets.Atlas.graph, new Rectangle(cur.x, cur.y, cur.w, cur.h), new Point(0, 0));//bd.copyPixels(, );
			_bd.unlock();
			
			current.frame++;
			if (current.frame >= current.total) current.frame = current.start;
		}
	
	}

}