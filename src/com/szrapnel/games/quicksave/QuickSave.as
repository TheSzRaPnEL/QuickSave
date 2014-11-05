package com.szrapnel.games.quicksave
{
	import com.szrapnel.games.IGame;
	import com.szrapnel.games.quicksave.intro.IntroMovie;
	import com.szrapnel.games.quicksave.levels.Level1;
	import com.szrapnel.games.quicksave.levels.Level2;
	import com.szrapnel.games.quicksave.levels.Level3;
	import com.szrapnel.games.quicksave.levels.Level4;
	import com.szrapnel.games.quicksave.levels.Level5;
	import com.szrapnel.games.quicksave.levels.Level6;
	import com.szrapnel.games.quicksave.levels.Level7;
	import com.szrapnel.games.quicksave.levels.LevelPool;
	import com.szrapnel.games.quicksave.screens.SelectionScreen;
	import com.szrapnel.games.quicksave.states.gameStates.EnteringInGameFromSelectionScreen;
	import com.szrapnel.games.quicksave.states.gameStates.EnteringMainMenuFromSelectionScreen;
	import com.szrapnel.games.quicksave.states.gameStates.EnteringSelectionScreenFromInGame;
	import com.szrapnel.games.quicksave.states.gameStates.EnteringSelectionScreenFromMainMenu;
	import com.szrapnel.games.quicksave.states.gameStates.InGameState;
	import com.szrapnel.games.quicksave.states.gameStates.InitState;
	import com.szrapnel.games.quicksave.states.gameStates.IntroState;
	import com.szrapnel.games.quicksave.states.gameStates.MainMenuState;
	import com.szrapnel.games.quicksave.states.gameStates.SelectionScreenState;
	import com.szrapnel.games.services.StateMachine;
	import flash.desktop.NativeApplication;
	import flash.events.KeyboardEvent;
	import flash.net.SharedObject;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * CowFall game states definition
	 * @author SzRaPnEL
	 */
	public class QuickSave extends Sprite implements IGame
	{
		public static const INIT:String = "initState";
		public static const INTRO:String = "introState";
		public static const MAIN_MENU:String = "mainMenu";
		public static const ENTERING_SELECTION_SCREEN_FROM_MAIN_MENU:String = "enteringSelectionScreenFromMainMenu";
		public static const SELECTION_SCREEN:String = "selectionScreen";
		public static const ENTERING_MAIN_MENU_FROM_SELECTION_SCREEN:String = "enteringMainMenuFromSelectionScreen";
		public static const ENTERING_IN_GAME_FROM_SELECTION_SCREEN:String = "enteringInGameFromSelectionScreen";
		public static const IN_GAME:String = "inGame";
		public static const ENTERING_SELECTION_SCREEN_FROM_IN_GAME:String = "enteringSelectionScreenFromInGame";
		
		private var _fsm:StateMachine;
		private var _assetsList:Vector.<String>;
		private var _introMovie:IntroMovie;
		private var _levelPool:LevelPool;
		private var _selectionScreen:SelectionScreen;
		private var _gameBackground:Quad;
		private var _offset:int;
		private var _currentLevel:int;
		private var _sharedObject:SharedObject;
		
		public function QuickSave()
		{
			_sharedObject = SharedObject.getLocal("CowFallSO", "/");
			if (sharedObject.data.levels == null)
			{
				sharedObject.data.levels = new <Boolean>[true,false,false,false,false,false,false];
				sharedObject.flush();
			}
			
			_fsm = new StateMachine();
			
			_levelPool = new LevelPool();
			levelPool.addLevel(new Level1());
			levelPool.addLevel(new Level2());
			levelPool.addLevel(new Level3());
			levelPool.addLevel(new Level4());
			levelPool.addLevel(new Level5());
			levelPool.addLevel(new Level6());
			levelPool.addLevel(new Level7());
			
			stateMachine.addState(INIT, new InitState(this), new <String>[]);
			stateMachine.addState(INTRO, new IntroState(this), new <String>[INIT]);
			stateMachine.addState(MAIN_MENU, new MainMenuState(this), new <String>[INTRO, ENTERING_MAIN_MENU_FROM_SELECTION_SCREEN]);
			stateMachine.addState(ENTERING_SELECTION_SCREEN_FROM_MAIN_MENU, new EnteringSelectionScreenFromMainMenu(this), new <String>[MAIN_MENU]);
			stateMachine.addState(SELECTION_SCREEN, new SelectionScreenState(this), new <String>[ENTERING_SELECTION_SCREEN_FROM_MAIN_MENU, ENTERING_SELECTION_SCREEN_FROM_IN_GAME]);
			stateMachine.addState(ENTERING_MAIN_MENU_FROM_SELECTION_SCREEN, new EnteringMainMenuFromSelectionScreen(this), new <String>[SELECTION_SCREEN]);
			stateMachine.addState(ENTERING_IN_GAME_FROM_SELECTION_SCREEN, new EnteringInGameFromSelectionScreen(this), new <String>[SELECTION_SCREEN]);
			stateMachine.addState(IN_GAME, new InGameState(this), new <String>[ENTERING_IN_GAME_FROM_SELECTION_SCREEN]);
			stateMachine.addState(ENTERING_SELECTION_SCREEN_FROM_IN_GAME, new EnteringSelectionScreenFromInGame(this), new <String>[IN_GAME]);
			
			stateMachine.setState(INIT);
			
			_assetsList = new <String>["SS0.xml", "SS0.png", "SS1.xml", "SS1.png", "font.fnt", "font.png", "music.mp3", "bounce.mp3"];
			
			_offset = int(Starling.current.stage.stageWidth - 540) / 2;
			
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			e.preventDefault();
			e.stopImmediatePropagation();
			
			if (stateMachine.currState == QuickSave.INIT || stateMachine.currState == QuickSave.MAIN_MENU)
			{
				NativeApplication.nativeApplication.exit();
			}
			if (stateMachine.currState == QuickSave.SELECTION_SCREEN)
			{
				stateMachine.setState(QuickSave.ENTERING_MAIN_MENU_FROM_SELECTION_SCREEN);
			}
			if (stateMachine.currState == QuickSave.IN_GAME)
			{
				stateMachine.setState(QuickSave.ENTERING_SELECTION_SCREEN_FROM_IN_GAME);
			}
			if (stateMachine.currState == QuickSave.INTRO)
			{
				stateMachine.setState(QuickSave.MAIN_MENU);
			}
		}
		
		public function get assetsList():Vector.<String>
		{
			return _assetsList;
		}
		
		public function get stateMachine():StateMachine
		{
			return _fsm;
		}
		
		public function get introMovie():IntroMovie
		{
			return _introMovie;
		}
		
		public function get selectionScreen():SelectionScreen
		{
			return _selectionScreen;
		}
		
		public function get offset():int
		{
			return _offset;
		}
		
		public function get gameBackground():Quad
		{
			return _gameBackground;
		}
		
		public function set gameBackground(value:Quad):void
		{
			_gameBackground = value;
		}
		
		public function set introMovie(value:IntroMovie):void
		{
			_introMovie = value;
		}
		
		public function set selectionScreen(value:SelectionScreen):void
		{
			_selectionScreen = value;
		}
		
		public function get currentLevel():int
		{
			return _currentLevel;
		}
		
		public function set currentLevel(value:int):void
		{
			_currentLevel = value;
		}
		
		public function get levelPool():LevelPool
		{
			return _levelPool;
		}
		
		public function set levelPool(value:LevelPool):void
		{
			_levelPool = value;
		}
		
		public function get sharedObject():SharedObject 
		{
			return _sharedObject;
		}
		
	}
}