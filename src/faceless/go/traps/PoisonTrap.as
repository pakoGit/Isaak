package faceless.go.traps 
{
	import faceless.go.IActiveGO;
	import faceless.state.FSM;

public class PoisonTrap extends Trap 
{
	
	public function PoisonTrap(X:int, Y:int) 
	{
		super(X, Y);
		color = 0x00ff00;
	}
	
	public override function action(target:IActiveGO):void {
		target.state.add(FSM.POISON);
	}
	
}
}