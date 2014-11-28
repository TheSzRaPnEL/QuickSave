package com.szrapnel.games.quicksave.levels
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.events.LevelEvent;
	import com.szrapnel.games.quicksave.services.IGameLogic;
	import com.szrapnel.games.quicksave.services.IGameStage;
	import com.szrapnel.games.quicksave.services.ISimulation;
	import com.szrapnel.games.quicksave.states.levelStates.InitState;
	import com.szrapnel.games.quicksave.states.levelStates.LoseState;
	import com.szrapnel.games.quicksave.states.levelStates.PlayingState;
	import com.szrapnel.games.quicksave.states.levelStates.WinState;
	import com.szrapnel.games.services.StateMachine;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class ALevel extends DisplayObjectContainer implements ILevel
	{
		private var _gameStage:IGameStage;
		private var _symulation:ISimulation;
		private var _gameLogic:IGameLogic;
		protected var isGenerated:Boolean;
		protected var delay:Number;
		protected var fsm:StateMachine;
		
		public function ALevel()
		{
			isGenerated = false;
			delay = 0.01;
			fsm = new StateMachine();
			fsm.addState("InitState", new InitState(this), new <String>["LoseState", "WinState", "PlayingState"]);
			fsm.addState("LoseState", new LoseState(this), new <String>["PlayingState"]);
			fsm.addState("WinState", new WinState(this), new <String>["PlayingState"]);
			fsm.addState("PlayingState", new PlayingState(this), new <String>["InitState"]);
			fsm.setState("InitState");
		}
		
		public function generate():void
		{
			symulation.eventDispatcher.removeEventListener(LevelEvent.LOST, onLevelLost_handler);
			symulation.eventDispatcher.addEventListener(LevelEvent.LOST, onLevelLost_handler);
		}
		
		private function onLevelLost_handler(e:LevelEvent):void 
		{
			gameLogic.endGame();
		}
		
		public function get gameStage():IGameStage
		{
			return _gameStage;
		}
		
		public function get symulation():ISimulation
		{
			return _symulation;
		}
		
		public function get gameLogic():IGameLogic
		{
			return _gameLogic;
		}
		
		public function set gameStage(value:IGameStage):void
		{
			_gameStage = value;
		}
		
		public function set symulation(value:ISimulation):void
		{
			_symulation = value;
		}
		
		public function set gameLogic(value:IGameLogic):void
		{
			_gameLogic = value;
		}
		
		public override function dispose():void
		{
			TweenLite.killDelayedCallsTo = dispatchLevelReady;
			
			if (gameLogic != null)
			{
				gameLogic.endGame();
			}
		}
		
		protected function dispatchLevelReady():void
		{
			isGenerated = true;
			dispatchEvent(new LevelEvent(LevelEvent.READY));
		}
		
	}
}