package core {
import core.IInput;

public interface IState {
	function update(input:IInput):void;
}
}