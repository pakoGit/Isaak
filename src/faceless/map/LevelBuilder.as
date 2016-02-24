package faceless.map 
{
	import faceless.manager.TrapManager;
	import org.flixel.FlxGroup;

public class LevelBuilder 
{
	private var _roomBuilder:RoomBuilder;
		
	public function LevelBuilder() 
	{
		_roomBuilder = new RoomBuilder;
	}
	
	public function build():Room {
		return _roomBuilder.build();
	}
	
}
}