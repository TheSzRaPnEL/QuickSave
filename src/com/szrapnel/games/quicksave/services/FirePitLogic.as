package com.szrapnel.games.quicksave.services
{
	import com.szrapnel.games.quicksave.events.LevelEvent;
	import com.szrapnel.games.quicksave.items.Banner;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import nape.geom.Vec2;
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
		private var level:int;
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
			playBtn.removeEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
			playBtn.addEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
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
					
					init();
				}
			}
		}
		
		public function init():void
		{
			startTime = new Date().time;
			score = 0;
			level = 1;
			Banner(gameStage.getObject("Banner")).savedTxtf.text = "" + score + "/" + (level * 10);
			
			removeEventListener(Event.ENTER_FRAME, onEFrame);
			addEventListener(Event.ENTER_FRAME, onEFrame);
			
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
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
						lastMaxVelocity -= 300;
						symulation.getBody("Platform").velocity.x = lastMaxVelocity;
					}
					else if (symulation.getBody("Platform").velocity.x > -500)
					{
						symulation.getBody("Platform").velocity.x = -500;
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
		}
		
		private function onEFrame(e:Event):void
		{
			var cow:Sprite = gameStage.getObject("Cow");
			cow.x = symulation.getBody("Ball").position.x;
			cow.y = symulation.getBody("Ball").position.y;
			cow.rotation = symulation.getBody("Ball").rotation;
			
			var platform:Sprite = gameStage.getObject("Platform");
			platform.x = symulation.getBody("Platform").position.x;
			
			if (cow.y > 960)
			{
				theend();
			}
			else if (cow.x > 540 || cow.x < -110)
			{
				dispatchEvent(new LevelEvent(LevelEvent.WON));
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
			score++;
			if (score >= 10)
			{
				level++;
				symulation.space.gravity = Vec2.weak(0, 500 + 100 * level);
			}
			Banner(gameStage.getObject("Banner")).savedTxtf.text = "" + score + "/" + (level * 10);
			
			symulation.dropNewCow();
		}
		
		public function theend():void
		{
			symulation.reset();
			symulation.update(0.1);
			
			gameStage.getObject("Cow").x = symulation.getBody("Ball").position.x;
			gameStage.getObject("Cow").y = symulation.getBody("Ball").position.y;
			gameStage.getObject("Platform").x = symulation.getBody("Platform").position.x;
			
			removeEventListener(Event.ENTER_FRAME, onEFrame);
			removeEventListener(TouchEvent.TOUCH, onTouch);
			
			playBtn.removeEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
			playBtn.addEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
			playBtn.alpha = 1;
			playBtn.touchable = true;
		}
		
	}
}