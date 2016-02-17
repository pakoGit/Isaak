package faceless.state 
{
	
public interface IState 
{
	function focus():void;
	function apply():void;
	function update():void;
	function end():void;
}
}