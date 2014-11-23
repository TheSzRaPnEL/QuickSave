package com.szrapnel.games.quicksave.services
{
	import com.greensock.easing.Bounce;
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.events.LevelEvent;
	import com.szrapnel.games.quicksave.events.SimulationEvent;
	import com.szrapnel.games.quicksave.items.Banner;
	import com.szrapnel.games.quicksave.items.Cow;
	import com.szrapnel.games.quicksave.items.CowDeath;
	import com.szrapnel.games.quicksave.items.TelescopicSpring;
	import com.szrapnel.games.services.Assets;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import nape.geom.Vec2;
	import nape.phys.BodyType;
	import starling.display.DisplayObject;
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
		protected var gameStage:IGameStage;
		protected var symulation:ISimulation;
		protected var score:int;
		protected var isBull:Boolean;
		protected var bullCounter:int;
		private var now:Number;
		private var playBtn:Sprite;
		private var clickTime:Number;
		private var lastMaxVelocity:Number;
		private var timerId:uint;
		private var deadCowIcon:Sprite;
		private var startTime:Number;
		
		public function FirePitLogic(gameStage:IGameStage, symulation:ISimulation)
		{
			this.gameStage = gameStage;
			this.symulation = symulation;
			clickTime = 0;
			lastMaxVelocity = -500;
			
			playBtn = gameStage.getObject("PlayBtn");
			
			isBull = false;
			
			symulation.eventDispatcher.removeEventListener(SimulationEvent.COW_GRABBED, onCowGrabbed_handler);
			symulation.eventDispatcher.addEventListener(SimulationEvent.COW_GRABBED, onCowGrabbed_handler);
		}
		
		protected function onCowGrabbed_handler(e:SimulationEvent):void
		{
			symulation.getBody("RightWall").position.x = 535;
			
			if (isBull)
			{
				bullCounter++;
				if (bullCounter < 4)
				{
					symulation.grabbed = false;
					
					symulation.getBody("Ball").type = BodyType.DYNAMIC;
					symulation.getBody("Ball").velocity = Vec2.weak(0, -1000 * Math.random() - 150);
					symulation.getBody("Ball").angularVel = -40 * Math.random() + 20;
					
					symulation.space.listeners.add(symulation.interactionListener);
				}
				else
				{
					bullCounter = 0;
					isBull = false;
				}
			}
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
			isBull = false;
			bullCounter = 0;
			
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
		
		protected function onEFrame(e:Event):void
		{
			var platform:Sprite = gameStage.getObject("Platform");
			platform.x = symulation.getBody("Platform").position.x;
			
			var cow:Sprite = gameStage.getObject("Cow");
			cow.x = symulation.getBody("Ball").position.x;
			cow.y = symulation.getBody("Ball").position.y;
			cow.rotation = symulation.getBody("Ball").rotation;
			
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
		
		protected function dropNewCow():void
		{
			stop();
			
			dispatchEvent(new LevelEvent(LevelEvent.COW_SAVED));
			bullCounter = 0;
			isBull = false;
			symulation.getBody("RightWall").position.x = 535;
			
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
			gameStage.getObject("Death").removeEventListener(Event.COMPLETE, onDeathComplete_handler);
			TweenLite.killTweensOf(gameStage.getObject("DeadCowIcon"));
			gameStage.getObject("DeadCowIcon").visible = false;
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
			
			var cow:Sprite = gameStage.getObject("Cow");
			
			if (isBull)
			{
				Cow(cow).image.texture = Assets.getTexture("CowFall_Cow");
				isBull = false;
			}
			bullCounter = 0;
			
			symulation.getBody("RightWall").position.x = 535;
			
			var death:Sprite = gameStage.getObject("Death");
			death.x = cow.x;
			death.y = cow.y;
			death.rotation = cow.rotation;
			death.visible = true;
			death.removeEventListener(Event.COMPLETE, onDeathComplete_handler);
			death.addEventListener(Event.COMPLETE, onDeathComplete_handler);
			CowDeath(death).play();
			
			cow.visible = false;
			
			TelescopicSpring(gameStage.getObject("Hand")).setWidth(460 - gameStage.getObject("Platform").x);
		}
		
		private function onDeathComplete_handler(e:Event):void
		{
			gameStage.getObject("Death").visible = false;
			gameStage.getObject("Death").removeEventListener(Event.COMPLETE, onDeathComplete_handler);
			
			deadCowIcon = gameStage.getObject("DeadCowIcon");
			deadCowIcon.visible = true;
			TweenLite.to(deadCowIcon, 0, {x: 270, y: 480, scaleX: 3, scaleY: 3, alpha: 0});
			TweenLite.to(deadCowIcon, 1, {scaleX: 1, scaleY: 1, alpha: 1, ease: Bounce.easeOut, onComplete: onDeadIconAnimationComplete_handler});
			
			DisplayObject(gameStage).removeEventListener(TouchEvent.TOUCH, onDeadCowIconTouch);
			DisplayObject(gameStage).addEventListener(TouchEvent.TOUCH, onDeadCowIconTouch);
		}
		
		private function onDeadIconAnimationComplete_handler():void
		{
			init();
			
			playBtn.removeEventListener(TouchEvent.TOUCH, onPlayBtnTouch);
			playBtn.alpha = 0;
			playBtn.touchable = false;
		}
		
		private function onDeadCowIconTouch(e:TouchEvent):void
		{
			if (e.getTouch(stage))
			{
				var touch:Touch = e.getTouch(stage);
				if (touch.phase == TouchPhase.BEGAN)
				{
					TweenLite.killTweensOf(deadCowIcon, true);
					
					DisplayObject(gameStage).removeEventListener(TouchEvent.TOUCH, onDeadCowIconTouch);
					deadCowIcon.alpha = 0;
					deadCowIcon.touchable = false;
					
					start();
				}
			}
		}
		
	}
}