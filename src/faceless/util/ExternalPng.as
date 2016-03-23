package faceless.util 
{
	import flash.display.BitmapData;

public class ExternalPng 
{
	
	private static var data_to_load:BitmapData;
    private static var unique_id:String;
    
    public function ExternalPng():void {}
    
    public static function setData(data:BitmapData, id:String):void {
      data_to_load = data;
      unique_id    = id;
    }
    
    public static function toString():String {
      return unique_id;
    }
    
    public function get bitmapData():BitmapData {
      return data_to_load;
    }
    
  }
	
}