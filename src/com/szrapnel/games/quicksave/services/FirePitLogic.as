package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.events.LevelEvent;
	import com.szrapnel.games.quicksave.items.Banner;
	import com.szrapnel.games.quicksave.items.CowDeath;
	import com.szrapnel.games.quicksave.items.TelescopicSpring;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import nape.phys.Body;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class FirePitLogic extends Sprite implements IGameLogic
	{
		private var gameStage:IGameStage;
		private var symulation:ISimulation;
		private var startTime:Number;
		private var score:int;
		private var now:Number;
		private var playBtn:Sprite;
		private var clickTime:Number;
		private var lastMaxVelocity:Number;
		private var timerId:uint;
		
		public function FirePitLogic(gameStage:IGameStage, symulation:ISimulation)
		{
			this.gameStage = gameStage;
			this.symulation = symulation;
			clickTime = 0;
			lastMaxVelocity = -500;
			
			playBtn = gameStage.getObject("PlayBtn");
		}
		
		private function onPlayBtnTouch(e:TouchEvent):void
		{
			if (e.getTouch(stage))
			{
				var touch:Touch = e.getTouch(stage);
				if (touch.phase == TouchPhase.BEGAN)
				{
					playBtn.removeEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
					playBtn.alpha = 0;
					playBtn.touchable = false;
					
					start();
				}
			}
		}
		
		public function init():void
		{
			startTime = new Date().time;
			score = 0;
			Banner(gameStage.getObject("Banner")).savedTxtf.text = "" + score + "/10";
			
			symulation.reset();
			
			playBtn.removeEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
			playBtn.addEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
			playBtn.alpha = 1;
			playBtn.touchable = true;
		}
		
		private function onTouch(e:TouchEvent):void
		{
			if (e.getTouch(stage))
			{
				var touch:Touch = e.getTouch(stage);
				if (touch.phase == TouchPhase.BEGAN)
				{
					stopResetVelocityTimer();
					
					var now:Number = new Date().time;
					if (clickTime == 0)
					{
						clickTime = now;
					}
					
					if (now - clickTime < 250)
					{
						if (lastMaxVelocity > -1200)
						{
							lastMaxVelocity -= 300;
						}
						symulation.getBody("Platform").velocity.x = lastMaxVelocity;
						symulation.getBody("PlatformInner").velocity.x = lastMaxVelocity;
					}
					else if (symulation.getBody("Platform").velocity.x > -500)
					{
						symulation.getBody("Platform").velocity.x = -500;
						symulation.getBody("PlatformInner").velocity.x = -500;
						lastMaxVelocity = -500;
					}
					
					clickTime = now;
				}
				else if (touch.phase == TouchPhase.ENDED)
				{
					startResetVelocityTimer();
				}
			}
		}
		
		private function startResetVelocityTimer():void
		{
			timerId = setTimeout(resetVelocityTimer, 250);
		}
		
		private function stopResetVelocityTimer():void
		{
			clearTimeout(timerId);
		}
		
		private function resetVelocityTimer():void
		{
			if (symulation.getBody("Platform").velocity.x <= -500)
			{
				symulation.getBody("Platform").velocity.x = -500;
				lastMaxVelocity = -500;
			}
			if (symulation.getBody("PlatformInner").velocity.x <= -500)
			{
				symulation.getBody("PlatformInner").velocity.x = -500;
				lastMaxVelocity = -500;
			}
		}
		
		private function onEFrame(e:Event):void
		{
			var cow:Sprite = gameStage.getObject("Cow");
			cow.x = symulation.getBody("Ball").position.x;
			cow.y = symulation.getBody("Ball").position.y;
			cow.rotation = symulation.getBody("Ball").rotation;
			
			var platform:Sprite = gameStage.getObject("Platform");
			platform.x = symulation.getBody("Platform").position.x;
			
			var hand:Sprite = gameStage.getObject("Hand");
			TelescopicSpring(hand).setWidth(460 - platform.x);
			
			if (cow.y < 0)
			{
				gameStage.getObject("Indicator").visible = true;
				gameStage.getObject("Indicator").x = cow.x;
			}
			else
			{
				gameStage.getObject("Indicator").visible = false;
			}
			
			if (cow.y > 900)
			{
				theend();
			}
			else if (cow.x > 580 || cow.x < -110)
			{
				dropNewCow();
			}
			else
			{
				now = new Date().time;
				var delta:Number = now - startTime;
				if (delta <= 0)
				{
					delta = 1;
				}
				symulation.update(delta / 1000);
				startTime = now;
			}
		}
		
		private function dropNewCow():void
		{
			stop();
			
			score++;
			if (score >= 10)
			{
				dispatchEvent(new LevelEvent(LevelEvent.WON));
			}
			else
			{
				Banner(gameStage.getObject("Banner")).savedTxtf.text = "" + score + "/10";
				symulation.dropNewCow();
				start();
			}
		}
		
		public function stop():void
		{
			removeEventListener(Event.ENTER_FRAME, onEFrame);
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function start():void
		{
			gameStage.getObject("Cow").visible = true;
			startTime = new Date().time;
			
			removeEventListener(Event.ENTER_FRAME, onEFrame);
			addEventListener(Event.ENTER_FRAME, onEFrame);
			
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function theend():void
		{
			stop();
			
			gameStage.getObject("Death").x = gameStage.getObject("Cow").x;
			gameStage.getObject("Death").y = gameStage.getObject("Cow").y;
			gameStage.getObject("Death").rotation = gameStage.getObject("Cow").rotation;
			gameStage.getObject("Death").visible = true;
			gameStage.getObject("Death").removeEventListener(Event.COMPLETE, onDeathComplete_handler);
			gameStage.getObject("Death").addEventListener(Event.COMPLETE, onDeathComplete_handler);
			CowDeath(gameStage.getObject("Death")).play();
			
			gameStage.getObject("Cow").visible = false;
			
			TelescopicSpring(gameStage.getObject("Hand")).setWidth(460 - gameStage.getObject("Platform").x);
		}
		
		private function onDeathComplete_handler(e:Event):void 
		{
			gameStage.getObject("Death").visible = false;
			gameStage.getObject("Death").removeEventListener(Event.COMPLETE, onDeathComplete_handler);
			
			init();
		}
		
	}
}