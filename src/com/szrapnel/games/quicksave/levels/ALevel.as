package com.szrapnel.games.quicksave.levels
{
	import com.szrapnel.games.quicksave.services.IGameLogic;
	import com.szrapnel.games.quicksave.services.IGameStage;
	import com.szrapnel.games.quicksave.services.ISimulation;
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
		
		public function ALevel()
		{
			isGenerated = false;
			delay = 0.01;
		}
		
		public function generate():void
		{
		
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
		
	}
}