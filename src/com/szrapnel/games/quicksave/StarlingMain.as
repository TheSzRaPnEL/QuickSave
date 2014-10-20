package com.szrapnel.games.quicksave 
{
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.events.DisplayListEvent;
	import com.szrapnel.games.quicksave.events.GameEvent;
	import com.szrapnel.games.quicksave.events.IntroEvent;
	import com.szrapnel.games.quicksave.intro.IntroMovie;
	import com.szrapnel.games.quicksave.screens.SelectionScreen;
	import com.szrapnel.games.quicksave.services.Assets;
	import com.szrapnel.games.quicksave.services.GameLogic;
	import com.szrapnel.games.quicksave.services.GameStage;
	import com.szrapnel.games.quicksave.services.Symulation;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Quad;
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
			gameBackground = new Quad(Starling.current.viewPort.width, Starling.current.viewPort.height, 0x1A1A1A);
			gameBackground.blendMode = BlendMode.NONE;
			gameBackground.touchable = false;
			addChild(gameBackground);
			
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
			
			offset = int(Starling.current.stage.stageWidth - 540) / 2;
			
			gameStage = new GameStage();
			gameStage.clipRect = new Rectangle(0, 0, 540, 960);
			gameStage.x = offset;
			addChild(gameStage);
			gameStage.visible = false;
			
			symulation = new Symulation();
			
			gameLogic = new GameLogic(gameStage, symulation);
			addChild(gameLogic);
			
			selectionScreen = new SelectionScreen();
			selectionScreen.x = offset;
			addChild(selectionScreen);
			selectionScreen.visible = false;
			
			introMovie = new IntroMovie();
			introMovie.x = offset;
			introMovie.addEventListener(IntroEvent.INTRO_FINISHED, onIntroFinished_handler);
			introMovie.addEventListener(IntroEvent.START_BTN_CLICKED, onStartBtnClicked_handler);
			addChild(introMovie);
			introMovie.play();
			
			gameBackground.touchable = true;
			addEventListener(TouchEvent.TOUCH, onStageTouch_handler);
			
			Starling.current.root.dispatchEvent(new DisplayListEvent(DisplayListEvent.HIDE_PRELOADER_OVERLAY));
			
			Starling.current.root.addEventListener(GameEvent.START_GAME, onStartGame_handler);
		}
		
		private function onStartBtnClicked_handler(e:Event):void 
		{
			gotoSelectionScreen();
		}
		
		private function gotoSelectionScreen():void 
		{
			selectionScreen.visible = true;
			TweenLite.to(introMovie, 0.3, { x: -introMovie.width / 4, y: -introMovie.height / 4, alpha:0, scaleX:1.5, scaleY:1.5, onComplete: removeIntroScreen } );
		}
		
		private function removeIntroScreen():void 
		{
			removeChild(introMovie);
		}
		
		private function onStartGame_handler(e:GameEvent):void 
		{
			startGame();
		}
		
		private function startGame():void
		{
			Starling.current.root.dispatchEvent(new DisplayListEvent(DisplayListEvent.HIDE_ADMOB));
			
			gameBackground.touchable = false;
			removeEventListener(TouchEvent.TOUCH, onStageTouch_handler);
			
			gameStage.visible = true;
			
			TweenLite.to(selectionScreen, 0.3, { x: -selectionScreen.width / 4, y: -selectionScreen.height / 4, alpha:0, scaleX:1.5, scaleY:1.5, onComplete: removeSelectionScreen } );
		}
		
		private function removeSelectionScreen():void 
		{
			//removeChild(selectionScreen);
			selectionScreen.visible = false;
			selectionScreen.touchable = false;
		}
		
		private function stopGame():void
		{
			gameBackground.touchable = true;
			
			gameStage.removeFromParent(true);
			gameStage = null;
			gameLogic.removeFromParent(true);
			gameLogic = null;
			symulation = null;
		}
		
		private function onIntroFinished_handler(e:IntroEvent):void 
		{
			Starling.current.root.dispatchEvent(new DisplayListEvent(DisplayListEvent.SHOW_ADMOB));
		}
		
		private function onStageTouch_handler(e:TouchEvent):void 
		{
			if (e.getTouch(stage))
			{
				var touch:Touch = e.getTouch(stage);
				if (touch.phase == TouchPhase.BEGAN)
				{
					if (introMovie.isPlaying)
					{
						introMovie.stop();
					}
					introMovie.end();
				}
			}
		}
		
	}
}