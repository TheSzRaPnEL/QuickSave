package com.szrapnel
{
	import com.szrapnel.games.IGame;
	import com.szrapnel.games.events.DisplayListEvent;
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.services.Assets;
	import starling.core.Starling;
	import starling.display.DisplayObject;
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