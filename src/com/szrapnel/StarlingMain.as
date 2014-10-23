package com.szrapnel
{
	import com.szrapnel.games.IGame;
	import com.szrapnel.games.quicksave.events.DisplayListEvent;
	import com.szrapnel.games.quicksave.intro.IntroMovie;
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.quicksave.screens.SelectionScreen;
	import com.szrapnel.games.quicksave.services.Assets;
	import com.szrapnel.games.quicksave.services.GameLogic;
	import com.szrapnel.games.quicksave.services.GameStage;
	import com.szrapnel.games.quicksave.services.Symulation;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class StarlingMain extends Sprite
	{
		private var game:IGame;
		private var assetManager:AssetManager;
		private var gameStage:GameStage;
		private var symulation:Symulation;
		private var gameLogic:GameLogic;
		private var gameBackground:Quad;
		private var introMovie:IntroMovie;
		private var offset:int;
		private var selectionScreen:SelectionScreen;
		
		public function StarlingMain()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			game = new QuickSave();
			
			assetManager = new AssetManager();
			for each (var asset:String in game.assetsList)
			{
				assetManager.enqueue(asset);
			}
			assetManager.loadQueue(onProgress);
		}
		
		private function onProgress(ratio:Number):void
		{
			if (ratio == 1)
			{
				core();
			}
		}
		
		private function core():void
		{
			Assets.assetManager = assetManager;
			
			addChild(DisplayObject(game));
			
			game.stateMachine.setState(QuickSave.INTRO);
			
			Starling.current.root.dispatchEvent(new DisplayListEvent(DisplayListEvent.HIDE_PRELOADER_OVERLAY));
		}
		
	}
}