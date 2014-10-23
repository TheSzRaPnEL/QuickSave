package com.szrapnel.games.quicksave.states.gameStates
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.events.DisplayListEvent;
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.quicksave.services.GameLogic;
	import com.szrapnel.games.quicksave.services.GameStage;
	import com.szrapnel.games.quicksave.services.Symulation;
	import com.szrapnel.games.quicksave.states.IState;
	import com.szrapnel.games.services.Assets;
	import flash.geom.Rectangle;
	import starling.core.Starling;
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
		private var gameStageReady:Boolean;
		private var gameLogicReady:Boolean;
		private var addingDelay:Number;
		
		public function EnteringInGameFromSelectionScreen(actor:*)
		{
			this.actor = actor;
			gameStageReady = false;
			gameLogicReady = false;
			addingDelay = 0.1;
			_name = "enteringInGameFromSelectionScreenState";
		}
		
		public function enter():void
		{
			if (actor.gameStage == null)
			{
				actor.gameStage = new GameStage();
				actor.gameStage.clipRect = new Rectangle(0, 0, 540, 960);
				actor.gameStage.x = actor.offset;
				actor.gameStage.removeEventListener(Event.ADDED_TO_STAGE, gameStageAddedToStage_handler);
				actor.gameStage.addEventListener(Event.ADDED_TO_STAGE, gameStageAddedToStage_handler);
				actor.addChildAt(actor.gameStage, 1);
				addingDelay += 0.1;
			}
			
			switch(actor.currentLevel)
			{
				case 0:
					actor.gameStage.background.image.texture = Assets.getTexture("CowFall_bckg1");
					break;
				case 1:
					actor.gameStage.background.image.texture = Assets.getTexture("CowFall_bckg3");
					break;
				default:
					break;
			}
			
			if (actor.symulation == null)
			{
				actor.symulation = new Symulation();
				addingDelay += 0.1;
			}
			
			if (actor.gameLogic == null)
			{
				actor.gameLogic = new GameLogic(actor.gameStage, actor.symulation);
				actor.gameLogic.removeEventListener(Event.ADDED_TO_STAGE, gameLogicAddedToStage_handler);
				actor.gameLogic.addEventListener(Event.ADDED_TO_STAGE, gameLogicAddedToStage_handler);
				actor.addChild(actor.gameLogic);
				actor.gameLogic.touchable = false;
				addingDelay += 0.1;
			}
			else
			{
				addingDelay = 0.1;
				checkStateReady();
			}
		}
		
		private function gameStageAddedToStage_handler(e:Event):void 
		{
			actor.gameStage.removeEventListener(Event.ADDED_TO_STAGE, gameStageAddedToStage_handler);
			
			gameStageReady = true;
			
			checkStateReady();
		}
		
		private function gameLogicAddedToStage_handler(e:Event):void 
		{
			actor.gameLogic.removeEventListener(Event.ADDED_TO_STAGE, gameLogicAddedToStage_handler);
			
			gameLogicReady = true;
			
			checkStateReady();
		}
		
		private function checkStateReady():void 
		{
			if (gameStageReady && gameLogicReady)
			{
				tween = new TweenLite(actor.selectionScreen, 0.3, {x: actor.offset-actor.selectionScreen.width / 4, y: -actor.selectionScreen.height / 4, alpha: 0, scaleX: 1.5, scaleY: 1.5, onComplete: enterComplete_handler});
				tween.delay = addingDelay;
			}
		}
		
		public function update():void
		{
		
		}
		
		public function exit():void
		{
			tween.complete(true, true);
			tween = null;
			
			removeSelectionScreen();
			
			dispatchHideAdmobRequest();
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