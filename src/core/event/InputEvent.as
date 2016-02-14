package core.event {
	import flash.events.Event;
	
	public class InputEvent extends Event {
		public static const CHANGE:String = "changed";
		public var result:String;
		
		public function InputEvent(type:String, result:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			this.result = result;
		}
		
		public override function clone():Event {
			return new InputEvent(type, result, bubbles, cancelable);
		}
		
		public override function toString():String {
			return formatToString("InputEvent", "type", "result", "bubbles", "cancelable", "eventPhase");
		}
	
	}

}