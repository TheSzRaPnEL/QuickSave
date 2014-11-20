package com.szrapnel.games.quicksave.states.gameStates
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.events.DisplayListEvent;
	import com.szrapnel.games.quicksave.levels.ILevel;
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.quicksave.states.IState;
	import com.szrapnel.games.services.Assets;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	
	/**
	 * Game MainMenu state definition
	 * @author SzRaPnEL
	 */
	public class EnteringSelectionScreenFromInGame implements IState
	{
		private var _name:String;
		private var actor:*;
		private var tween:TweenLite;
		
		public function EnteringSelectionScreenFromInGame(actor:*)
		{
			this.actor = actor;
			_name = "enteringSelectionScreenFromInGameState";
		}
		
		public function enter():void
		{
			var currLevel:ILevel = actor.levelPool.getLevel(actor.currentLevel);
			currLevel.gameLogic.stop();
			
			actor.selectionScreen.visible = true;
			
			if (actor.sharedObject.data.saved < 1111)
			{
				actor.selectionScreen.bannerText.texture = Assets.getTexture("CowFall_SScreen_level7_baner_TXT1");
				actor.selectionScreen.bannerText.x = 42;
				actor.selectionScreen.bannerNumber.text = String(1111 - actor.sharedObject.data.saved);
				actor.selectionScreen.bannerNumber.x = 81;
				actor.selectionScreen.bannerNumber.y = 27;
			}
			else
			{
				actor.selectionScreen.bannerText.texture = Assets.getTexture("CowFall_SScreen_level7_baner_TXT2");
				actor.selectionScreen.bannerText.x = 32;
				actor.selectionScreen.bannerNumber.text = String(actor.sharedObject.data.saved);
				actor.selectionScreen.bannerNumber.x = 190;
				actor.selectionScreen.bannerNumber.y = 32;
			}
			
			actor.selectionScreen.alpha = 0;
			actor.selectionScreen.touchable = false;
			
			var levelActiveListLength:int = actor.sharedObject.data.levels != null ? actor.sharedObject.data.levels.length : 0;
			for (var i:int = 0; i < levelActiveListLength; i++)
			{
				if (actor.sharedObject.data.levels[i])
				{
					actor.selectionScreen.activateLevel(i);
				}
				else
				{
					actor.selectionScreen.deactivateLevel(i);
				}
			}
			
			tween = new TweenLite(actor.selectionScreen, 0.3, {x: actor.offset, y: 0, alpha: 1, scaleX: 1, scaleY: 1, onComplete: enterComplete_handler});
			tween.play();
		}
		
		public function update():void
		{
		
		}
		
		public function exit():void
		{
			tween.complete(true, true);
			tween = null;
			
			DisplayObject(actor.levelPool.getLevel(actor.currentLevel)).removeFromParent();
			
			dispatchShowAdmobRequest();
		}
		
		public function get name():String
		{
			return _name;
		}
		
		private function enterComplete_handler():void
		{
			actor.stateMachine.setState(QuickSave.SELECTION_SCREEN);
		}
		
		private function dispatchShowAdmobRequest():void 
		{
			Starling.current.root.dispatchEvent(new DisplayListEvent(DisplayListEvent.SHOW_ADMOB));
		}
		
	}
}