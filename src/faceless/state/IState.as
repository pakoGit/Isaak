package faceless.state 
{
	
public interface IState 
{
	function focus():void;
	function apply():void;
	function refresh():void;
	function update():void;
	function end():void;
	function callback(param:Object = null):void;
}
}