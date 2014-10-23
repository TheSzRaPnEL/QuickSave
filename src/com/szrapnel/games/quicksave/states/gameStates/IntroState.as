package com.szrapnel.games.quicksave.states.gameStates 
{
	import com.szrapnel.games.quicksave.events.DisplayListEvent;
	import com.szrapnel.games.quicksave.events.IntroEvent;
	import com.szrapnel.games.quicksave.intro.IntroMovie;
	import com.szrapnel.games.quicksave.QuickSave;
	import com.szrapnel.games.quicksave.states.IState;
	import starling.core.Starling;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * Game IntroState state definition
	 * @author SzRaPnEL
	 */
	public class IntroState implements IState 
	{
		private var actor:*;
		private var _name:String;
		
		public function IntroState(actor:*) 
		{
			this.actor = actor;
			_name = "introState";
		}
		
		public function enter():void 
		{
			if (actor.introMovie == null)
			{
				actor.introMovie = new IntroMovie();
				actor.introMovie.touchable = false;
				actor.addChild(actor.introMovie);
			}
			
			actor.introMovie.generate();
			actor.introMovie.x = actor.offset;
			actor.introMovie.removeEventListener(IntroEvent.INTRO_FINISHED, onIntroFinished_handler);
			actor.introMovie.addEventListener(IntroEvent.INTRO_FINISHED, onIntroFinished_handler);
			
			actor.introMovie.play();
			
			actor.gameBackground.touchable = true;
			
			actor.gameBackground.removeEventListener(TouchEvent.TOUCH, onStageTouch_handler);
			actor.gameBackground.addEventListener(TouchEvent.TOUCH, onStageTouch_handler);
		}
		
		public function update():void 
		{
			
		}
		
		public function exit():void 
		{
			actor.introMovie.removeEventListener(IntroEvent.INTRO_FINISHED, onIntroFinished_handler);
			actor.gameBackground.removeEventListener(TouchEvent.TOUCH, onStageTouch_handler);
			
			if (actor.introMovie.isPlaying)
			{
				actor.introMovie.stop();
			}
			
			dispatchShowAdmobRequest();
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		private function onIntroFinished_handler(e:IntroEvent):void 
		{
			actor.stateMachine.setState(QuickSave.MAIN_MENU);
		}
		
		private function onStageTouch_handler(e:TouchEvent):void 
		{
			if (e.getTouch(actor.gameBackground))
			{
				var touch:Touch = e.getTouch(actor.gameBackground);
				if (touch.phase == TouchPhase.BEGAN)
				{
					if (actor.introMovie.isPlaying)
					{
						actor.introMovie.stop();
					}
					actor.introMovie.end();
				}
			}
		}
		
		private function dispatchShowAdmobRequest():void 
		{
			Starling.current.root.dispatchEvent(new DisplayListEvent(DisplayListEvent.SHOW_ADMOB));
		}
		
	}
}