package com.szrapnel.games.quicksave.levels 
{
	import com.szrapnel.games.quicksave.services.GameLogic;
	import com.szrapnel.games.quicksave.services.Symulation;
	import com.szrapnel.games.quicksave.services.GameStage;
	import flash.events.IEventDispatcher;
	import starling.display.DisplayObjectContainer;
	import starling.events.EnterFrameEvent;
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class ALevel extends DisplayObjectContainer implements ILevel
	{
		private var _gameStage:GameStage;
		private var _symulation:Symulation;
		private var _gameLogic:GameLogic;
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
		
		public function get gameStage():GameStage 
		{
			return _gameStage;
		}
		
		public function get symulation():Symulation 
		{
			return _symulation;
		}
		
		public function get gameLogic():GameLogic 
		{
			return _gameLogic;
		}
		
		public function set gameStage(value:GameStage):void 
		{
			_gameStage = value;
		}
		
		public function set symulation(value:Symulation):void 
		{
			_symulation = value;
		}
		
		public function set gameLogic(value:GameLogic):void 
		{
			_gameLogic = value;
		}
		
	}
}