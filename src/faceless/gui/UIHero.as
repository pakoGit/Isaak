package faceless.gui 
{
	import org.flixel.FlxText;

public class UIHero extends FlxText
{
	
	public function UIHero(x:int, y:int, width:int, hp:int) 
	{
		super(x, y, width, "Health: ");
		font = 'Nokia';
		size = 18;
		color = 0xff0000;
		setHp(hp);
	}
	
	public function setHp(hp:int):void {
		text = "Health: " + hp;
	}
	
	public function updateUI(o:Object):void {
		text = "Health: "+o.hp+"\nSouls: "+o.souls;
	}
	
}
}