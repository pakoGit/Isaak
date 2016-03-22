package {
import faceless.global.GameVar;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.utils.getDefinitionByName;

public class Preloader extends MovieClip {
	private var _mc:mcLoadbar;
	
	public function Preloader() {
		if (stage) {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		addEventListener(Event.ENTER_FRAME, checkFrame);
		loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
		loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
		
		_mc = new mcLoadbar;
		_mc.loadbar.scaleX = 0;
		_mc.x = (GameVar.SCREEN_W >> 1) - (_mc.width >> 1);
		_mc.y = (GameVar.SCREEN_H >> 1) - (_mc.height >> 1);
		addChild(_mc);
	}
	
	private function ioError(e:IOErrorEvent):void {
		trace(e.text);
	}
	
	private function progress(e:ProgressEvent):void {
		_mc.loadbar.scaleX = (e.bytesLoaded / e.bytesTotal);
	}
	
	private function checkFrame(e:Event):void {
		if (currentFrame == totalFrames) {
			stop();
			loadingFinished();
		}
	}
	
	private function loadingFinished():void {
		removeEventListener(Event.ENTER_FRAME, checkFrame);
		loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
		loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
		
		removeChild(_mc);
		_mc = null;
		
		startup();
	}
	
	private function startup():void {
		var mainClass:Class = getDefinitionByName("Main") as Class;
		addChild(new mainClass() as DisplayObject);
	}

}
}