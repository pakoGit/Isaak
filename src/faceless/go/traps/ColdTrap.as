package faceless.go.traps 
{
	import faceless.go.IActiveGO;
	import faceless.state.FSM;

public class ColdTrap extends Trap 
{
	
	public function ColdTrap(X:int, Y:int) 
	{
		super(X, Y);
		color = 0x0000ff;
	}
	
	public override function action(target:IActiveGO):void {
		target.state.add(FSM.SLOW);
	}
	
}
}