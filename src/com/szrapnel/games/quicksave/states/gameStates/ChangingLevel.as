package com.szrapnel.games.quicksave.states.gameStates
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.events.LevelEvent;
	import com.szrapnel.games.quicksave.levels.ILevel;
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.quicksave.states.IState;
	import com.szrapnel.games.services.Assets;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
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
		private var loseBannerTop:Sprite;
		private var loseBannerBot:Sprite;
		
		public function ChangingLevel(actor:*)
		{
			this.actor = actor;
			addingDelay = 0.1;
			_name = "changinLevel";
		}
		
		public function enter():void
		{
			if (loseBannerTop == null)
			{
				loseBannerTop = new Sprite();
				var image:Image = new Image(Assets.getTexture("CowFall_levelCOMPLETE_top"));
				loseBannerTop.addChild(image);
				loseBannerTop.x = actor.offset;
				loseBannerTop.y = -loseBannerTop.height;
				actor.addChild(loseBannerTop);
			}
			
			if (loseBannerBot == null)
			{
				loseBannerBot = new Sprite();
				image = new Image(Assets.getTexture("CowFall_levelCOMPLETE_bottom"));
				loseBannerBot.addChild(image);
				loseBannerBot.x = actor.offset;
				loseBannerBot.y = 960 + loseBannerBot.height;
				actor.addChild(loseBannerBot);
			}
			
			TweenLite.to(loseBannerTop, 0.3, {y: 0});
			TweenLite.to(loseBannerBot, 0.3, {y: 960 - loseBannerBot.height, onComplete: loseBannerClosed_handler});
		}
		
		private function loseBannerClosed_handler():void
		{
			actor.currentLevel++;
			
			if (actor.levelPool.length > actor.currentLevel)
			{
				level = actor.levelPool.getLevel(actor.currentLevel);
				
				var prevLevel:DisplayObject = actor.levelPool.getLevel(actor.currentLevel - 1);
				prevLevel.visible = false;
				prevLevel.touchable = false;
				
				if (DisplayObject(level).parent == null)
				{
					actor.addChildAt(level, actor.getChildIndex(prevLevel));
				}
				
				DisplayObject(level).visible = true;
				DisplayObject(level).x = actor.offset;
				DisplayObject(level).y = 0;
				
				DisplayObject(level).removeEventListener(LevelEvent.READY, levelReady_handler);
				DisplayObject(level).addEventListener(LevelEvent.READY, levelReady_handler);
				
				level.generate();
			}
			else
			{
				TweenLite.killTweensOf(loseBannerTop);
				TweenLite.killTweensOf(loseBannerBot);
				loseBannerTop.y = -loseBannerTop.height;
				loseBannerBot.y = 960;
				actor.stateMachine.setState(QuickSave.MAIN_MENU);
			}
		}
		
		public function update():void
		{
		
		}
		
		private function levelReady_handler(e:Event):void
		{
			DisplayObject(level).removeEventListener(LevelEvent.READY, levelReady_handler);
			TweenLite.delayedCall(1, checkStateReady);
		}
		
		private function checkStateReady():void
		{
			TweenLite.to(loseBannerTop, 0.3, {y: -loseBannerTop.height});
			TweenLite.to(loseBannerBot, 0.3, {y: 960, onComplete: enterComplete_handler});
		}
		
		public function exit():void
		{
			TweenLite.killTweensOf(loseBannerTop);
			TweenLite.killTweensOf(loseBannerBot, true);
		}
		
		public function get name():String
		{
			return _name;
		}
		
		private function enterComplete_handler():void
		{
			actor.stateMachine.setState(QuickSave.IN_GAME);
		}
	
	}
}