package com.szrapnel.games.quicksave.states.gameStates
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.events.DisplayListEvent;
	import com.szrapnel.games.quicksave.events.LevelEvent;
	import com.szrapnel.games.quicksave.levels.ILevel;
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.quicksave.services.GameLogic;
	import com.szrapnel.games.quicksave.services.GameStage;
	import com.szrapnel.games.quicksave.services.Symulation;
	import com.szrapnel.games.quicksave.states.IState;
	import com.szrapnel.games.services.Assets;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * Game MainMenu state definition
	 * @author SzRaPnEL
	 */
	public class EnteringInGameFromSelectionScreen implements IState
	{
		private var _name:String;
		private var actor:*;
		private var tween:TweenLite;
		private var level:ILevel;
		private var addingDelay:Number;
		
		public function EnteringInGameFromSelectionScreen(actor:*)
		{
			this.actor = actor;
			addingDelay = 0.1;
			_name = "enteringInGameFromSelectionScreenState";
		}
		
		public function enter():void
		{
			dispatchHideAdmobRequest();
			
			level = actor.levelPool.getLevel(actor.currentLevel);
			
			if (DisplayObject(level).parent == null)
			{
				DisplayObject(level).x = actor.offset;
				actor.addChildAt(level, actor.getChildIndex(actor.selectionScreen));
			}
			
			DisplayObject(level).removeEventListener(LevelEvent.READY, levelReady_handler);
			DisplayObject(level).addEventListener(LevelEvent.READY, levelReady_handler);
			
			level.generate();
		}
		
		private function levelReady_handler(e:Event):void 
		{
			checkStateReady();
		}
		
		private function checkStateReady():void 
		{
			tween = new TweenLite(actor.selectionScreen, 0.3, {x: actor.offset-actor.selectionScreen.width / 4, y: -actor.selectionScreen.height / 4, alpha: 0, scaleX: 1.5, scaleY: 1.5, onComplete: enterComplete_handler});
			tween.delay = addingDelay;
		}
		
		public function update():void
		{   
		
		}
		
		public function exit():void
		{
			tween.complete(true, true);
			tween = null;
			
			removeSelectionScreen();
		}
		
		public function get name():String
		{
			return _name;
		}
		
		private function enterComplete_handler():void
		{
			actor.stateMachine.setState(QuickSave.IN_GAME);
		}
		
		private function removeSelectionScreen():void
		{
			actor.selectionScreen.visible = false;
			actor.selectionScreen.touchable = false;
		}
		
		private function dispatchHideAdmobRequest():void 
		{
			Starling.current.root.dispatchEvent(new DisplayListEvent(DisplayListEvent.HIDE_ADMOB));
		}
		
	}
}