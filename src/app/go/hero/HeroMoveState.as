package app.go.hero {
import app.input.CmdName;
import assets.Assets;
import core.IInput;
import app.go.hero.IState;

public class HeroMoveState implements IState{
	private var _hero:Hero;
	
	public function HeroMoveState(hero:Hero) {
		_hero = hero;
	}

	public function update(cmd:String):void {
		var id:int = cmd.charAt(0) == '+'?1:0; 
		cmd = cmd.slice(1);
		if (cmd == CmdName.UP) {
			_hero.moveDir[2] = -1*id;
		}else if (cmd == CmdName.DOWN) {
			_hero.moveDir[3] = 1*id;
		}
		if (cmd == CmdName.LEFT) {
			_hero.moveDir[0] = -1*id;
		}else if (cmd == CmdName.RIGHT) {
			_hero.moveDir[1] = 1*id;
		}
		
		_hero.scaleX = _hero.moveDir[1]!=0?-1:1;
		for (var i:int = 0; i < _hero.moveDir.length;i++)
			if (_hero.moveDir[i] != 0) return;
		_hero.scaleX = 1;
		_hero.changeState(new HeroIdleState(_hero));
	}
	
	public function getTexture():Object {
		return Assets.Atlas.getTexture("mov1");
	}
	public function getName():String { return "MOVE";}
}
}