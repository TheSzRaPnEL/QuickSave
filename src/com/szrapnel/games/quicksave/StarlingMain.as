package com.szrapnel.games.quicksave 
{
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class StarlingMain extends Sprite
	{
		private var assetManager:AssetManager;
		private var gameStage:GameStage;
		private var symulation:Symulation;
		private var gameLogic:GameLogic;
		
		public function StarlingMain() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			assetManager = new AssetManager();
			assetManager.enqueue("SS0.xml");
			assetManager.enqueue("SS0.png");
			assetManager.enqueue("SS1.xml");
			assetManager.enqueue("SS1.png");
			assetManager.enqueue("font.fnt");
			assetManager.enqueue("font.png");
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
			
			gameStage = new GameStage();
			addChild(gameStage);
			
			symulation = new Symulation();
			
			gameLogic = new GameLogic(gameStage, symulation);
			addChild(gameLogic);
		}
		
	}
}