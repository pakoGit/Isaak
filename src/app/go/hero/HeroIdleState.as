package app.go.hero {
import app.go.hero.IState;
import assets.Assets;
	
public class HeroIdleState implements IState {
	private var _hero:Hero;
	
	public function HeroIdleState(hero:Hero) {
		_hero = hero;
	}

	public function update(cmd:String):void {
		_hero.changeState(new HeroMoveState(_hero));
		_hero.state.update(cmd);
	}
	
	public function getTexture():Object {
		return Assets.Atlas.getTexture("idle1");
	}
	public function getName():String { return "IDLE";}
}
}