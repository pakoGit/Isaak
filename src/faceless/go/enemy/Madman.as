package faceless.go.enemy 
{
	import faceless.global.GameVar;
	import faceless.go.IActiveGO;
	import faceless.go.Player;
	import faceless.state.FSM;
	import faceless.state.InvisibleState;
	import faceless.state.IState;
	import faceless.state.NormalState;
	import flash.geom.Point;
	import org.flixel.FlxPath;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.yyztom.pathfinding.astar.AStar;
	import org.yyztom.pathfinding.astar.AStarNodeVO;
	import org.yyztom.test.ui.SpriteTile;
	

public class Madman extends FlxSprite implements IActiveGO
{
	[Embed(source="../../../../lib/tiles/idle1.png")]
	private var plPng:Class;
	private var _target:Player;
	private var _distance:Number = 300;
	private var _state:FSM;
	private var _speed:Number = 2.0;
	private var _hp:Number = 100;
	private var _targetPoint:FlxPoint = new FlxPoint;
	private var patrol:Array = [];
	
	public function Madman(x:int, y:int, target:Player) 
	{
		super(x, y);
		loadGraphic(plPng, true, true);
		addAnimation("move", [0]);
		addAnimation("move_up", [0]);
		addAnimation("idle", [0]);
		addAnimation("die", [0]);
		play("idle");
		_target = target;
		_state = new FSM();
		_state.map(FSM.NORMAL, new NormalState(this, {speed:_speed}));
		_state.map(FSM.HIDEN, new InvisibleState(this));
		_state.add(FSM.NORMAL);
		
		patrol.push([x, y]);
		patrol.push([x, y + 12 * GameVar.TILE_H]);
		moveTo(x, y + 12 * GameVar.TILE_H);
		
		width = height = 32;
	}
	
	private var _currentPos : Point = new Point(0,0);
	private var astarRes:Vector.<AStarNodeVO> = new Vector.<AStarNodeVO>();
		
	public override function update():void {
		super.update();
		acceleration.x = acceleration.y = 0;
		var tx:Number = _target.x + (_target.x>x?-0:0);
		var ty:Number = _target.y;
		var angle:Number = Math.atan2(_targetPoint.y - y, _targetPoint.x - x);
		var dist:Number = Math.sqrt(Math.pow(tx - x, 2) + Math.pow(ty - y, 2));
		if (Math.abs(_targetPoint.x - x)>_speed || Math.abs(_targetPoint.y - y)>_speed) {
			x += Math.cos(angle) * _speed;
			y += Math.sin(angle) * _speed;
			/*if (dist < _distance && _target.hp > 0) {
				//moveTo(tx, ty);
				//if (Math.abs(x - _currentPos.x) > 64 && Math.abs(y - _currentPos.y) < 64) {
					if(int(tx/64)!=_currentPos.x && int(ty/64)!=_currentPos.y){
						_currentPos.x = int(tx/64);
						_currentPos.y = int(ty/64);
						astarRes = _astar.search(_aStarNodes[int(x / 64)][int(y / 64)], _aStarNodes[int(tx / 64)][int(ty / 64)]);
						if (astarRes.length > 0) {
							moveTo(astarRes[0].position.x * 64, astarRes[0].position.y * 64);	
							astarRes.splice(0, 1);
						}
						//getNextPoint();
					}
					//trace(_aStarNodes[int(x / 64)][int(y / 64)].isWall, _aStarNodes[int(tx / 64)][int(ty / 64)].isWall);
					//trace(int(x / 64), int(y / 64));
					//trace(int(tx / 64), int(ty / 64));
					//trace(astarRes.length);
				//}
				//if(astarRes.length>0) moveTo(astarRes[0].position.x * 64, astarRes[0].position.y *64);
			}else if (Math.abs(_targetPoint.x - x) <= _speed && Math.abs(_targetPoint.y - y) <= _speed) {
				var i:int = 0;
				if (astarRes.length > 0) {
					if (astarRes[astarRes.length - 1].position.y * 64 == _targetPoint.y ){
						i = _targetPoint.y == patrol[0][1]?1:0;
						astarRes = _astar.search(_aStarNodes[int(x / 64)][int(y / 64)], _aStarNodes[int(patrol[i][0] / 64)][int(patrol[i][1] / 64)]);
						if (astarRes.length > 0) {
							moveTo(astarRes[0].position.x * 64, astarRes[0].position.y * 64);	
							astarRes.splice(0, 1);
						}
					}
					//i = _targetPoint.y == patrol[0][1]?1:0;
				}else
					astarRes = _astar.search(_aStarNodes[int(x / 64)][int(y / 64)], _aStarNodes[int(patrol[i][0] / 64)][int(patrol[i][1] / 64)]);
					if (astarRes.length > 0) {
						moveTo(astarRes[0].position.x * 64, astarRes[0].position.y * 64);	
						astarRes.splice(0, 1);
					}
				//getNextPoint();
			}
			//if(astarRes.length>0) moveTo(astarRes[0].position.x * 64, astarRes[0].position.y *64);*/
		}else {
			if (astarRes.length > 0) {
				moveTo(astarRes[0].position.x * GameVar.TILE_W, astarRes[0].position.y * GameVar.TILE_H);
				astarRes.splice(0, 1);
			}
		}
		if (dist < _distance && _target.hp > 0) {
			if(_currentPos.x != int(tx/GameVar.TILE_W) || _currentPos.y != int(ty/GameVar.TILE_H)){
				astarRes = GameVar.MAP_MANAGER.current.findPath(x, y, tx, ty);
				if (astarRes.length > 0) {
					_currentPos.x = int(tx/GameVar.TILE_W);
					_currentPos.y = int(ty/GameVar.TILE_H);
					moveTo(astarRes[0].position.x * GameVar.TILE_W, astarRes[0].position.y * GameVar.TILE_H);
					astarRes.splice(0, 1);
				}
			}
		}
		_state.update();
	}
	
	private function getNextPoint():void {
		if (astarRes.length > 0) moveTo(astarRes[0].position.x * GameVar.TILE_W, astarRes[0].position.y * GameVar.TILE_H);
		if (astarRes.length > 0) astarRes.splice(0, 1);
	}
	
	public override function destroy():void {
		_state.clear();
		super.destroy();
	}
	
	public function moveTo(x:int, y:int):void {
		_targetPoint.x = x;
		_targetPoint.y = y;
	}
	
	public function set speed(value:Number):void {_speed = value;}
	
	public function get speed():Number {return _speed;}
	
	public function get hp():Number {return _hp;}
	
	public function hit(d:Number):void 
	{
		
	}
	
	public function get state():FSM { return _state; }
	public function get condition():FSM { return null; }
	public function get sprite():FlxSprite	{ return this; }
	
	//public function get x():Number { return this.x; }
	//public function get y():Number { return this.y; }
	
	public function set target(target:Player):void { _target = target; }
	
}
}