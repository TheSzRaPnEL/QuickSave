package com.szrapnel.games.quicksave.states.gameStates
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.events.LevelEvent;
	import com.szrapnel.games.quicksave.levels.ILevel;
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.quicksave.states.IState;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	/**
	 * Game MainMenu state definition
	 * @author SzRaPnEL
	 */
	public class ChangingLevel implements IState
	{
		private var _name:String;
		private var actor:*;
		private var tween:TweenLite;
		private var level:ILevel;
		private var addingDelay:Number;
		
		public function ChangingLevel(actor:*)
		{
			this.actor = actor;
			addingDelay = 0.1;
			_name = "changinLevel";
		}
		
		public function enter():void
		{
			actor.currentLevel++;
			
			if (actor.levelPool.length > actor.currentLevel)
			{
				level = actor.levelPool.getLevel(actor.currentLevel);
				
				if (DisplayObject(level).parent == null)
				{
					var prevLevel:DisplayObject = actor.levelPool.getLevel(actor.currentLevel - 1);
					actor.addChildAt(level, actor.getChildIndex(prevLevel));
				}
				
				DisplayObject(level).visible = true;
				DisplayObject(level).alpha = 1;
				DisplayObject(level).scaleX = 1;
				DisplayObject(level).scaleY = 1;
				DisplayObject(level).x = actor.offset;
				DisplayObject(level).y = 0;
				
				DisplayObject(level).removeEventListener(LevelEvent.READY, levelReady_handler);
				DisplayObject(level).addEventListener(LevelEvent.READY, levelReady_handler);
				
				level.generate();
			}
			else
			{
				actor.stateMachine.setState(QuickSave.MAIN_MENU);
			}
		}
		
		private function levelReady_handler(e:Event):void
		{
			checkStateReady();
		}
		
		private function checkStateReady():void
		{
			tween = new TweenLite(actor.levelPool.getLevel(actor.currentLevel-1), 0.3, {x: actor.offset - actor.levelPool.getLevel(actor.currentLevel-1).width / 4, y: -actor.levelPool.getLevel(actor.currentLevel-1).height / 4, alpha: 0, scaleX: 1.5, scaleY: 1.5, onComplete: enterComplete_handler});
			tween.delay = addingDelay;
		}
		
		public function update():void
		{
		
		}
		
		public function exit():void
		{
			tween.complete(true, true);
			tween = null;
			
			removePrevLevel();
		}
		
		public function get name():String
		{
			return _name;
		}
		
		private function enterComplete_handler():void
		{
			actor.stateMachine.setState(QuickSave.IN_GAME);
		}
		
		private function removePrevLevel():void
		{
			var prevLevel:ILevel = actor.levelPool.getLevel(actor.currentLevel - 1);
			DisplayObject(prevLevel).visible = false;
			DisplayObject(prevLevel).touchable = false;
			DisplayObject(level).scaleX = 1;
			DisplayObject(level).scaleY = 1;
			DisplayObject(level).x = actor.offset;
			DisplayObject(level).y = 0;
		}
		
	}
}