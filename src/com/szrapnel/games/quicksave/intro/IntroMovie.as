package com.szrapnel.games.quicksave.intro
{
	import com.greensock.easing.Bounce;
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.szrapnel.games.quicksave.components.SimpleButton;
	import com.szrapnel.games.quicksave.events.IntroEvent;
	import com.szrapnel.games.services.Assets;
	import flash.net.SharedObject;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * CowFall intro animation
	 * @author SzRaPnEL
	 */
	public class IntroMovie extends Sprite
	{
		private var container:Sprite;
		private var background:Image;
		private var background2:Image;
		private var eyes:Image;
		private var logo:SimpleButton;
		private var cloud:Image;
		private var cloudText:Image;
		private var cow:Image;
		private var cowFallLogo:Image;
		private var playBtn:SimpleButton;
		private var _isPlaying:Boolean;
		private var timelineAnimation:TimelineLite;
		
		public function IntroMovie()
		{
			_isPlaying = false;
			
			container = new Sprite();
			addChild(container);
			
			background = new Image(Texture.fromColor(Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, 0x1A1A1A));
			container.addChild(background);
		}
		
		public function generate():void
		{
			eyes = new Image(Assets.getTexture("CowFall_INTRO_eye1"));
			eyes.x = 112;
			eyes.y = 356;
			container.addChild(eyes);
			eyes.visible = false;
			
			cloud = new Image(Assets.getTexture("CowFall_INTRO_cloud"));
			cloud.x = 112;
			cloud.y = 80;
			container.addChild(cloud);
			cloud.visible = false;
			
			cloudText = new Image(Assets.getTexture("CowFall_INTRO_myNAME"));
			cloudText.x = 141;
			cloudText.y = 112;
			container.addChild(cloudText);
			cloudText.visible = false;
			
			cow = new Image(Assets.getTexture("CowFall_INTRO_cow"));
			cow.x = 55;
			cow.y = 305;
			cow.rotation = -6 * Math.PI / 180;
			container.addChild(cow);
			cow.visible = false;
			
			cowFallLogo = new Image(Assets.getTexture("CowFall_INTRO_logo"));
			cowFallLogo.pivotX = cowFallLogo.width / 2;
			cowFallLogo.pivotY = cowFallLogo.height / 2;
			cowFallLogo.x = 276;
			cowFallLogo.y = 564;
			container.addChild(cowFallLogo);
			cowFallLogo.visible = false;
			
			logo = new SimpleButton(Assets.getTexture("CowFall_szrapnel"));
			logo.x = 136;
			logo.y = 880;
			container.addChild(logo);
			
			playBtn = new SimpleButton(Assets.getTexture("CowFall_button_PLAY"));
			playBtn.x = 193;
			playBtn.y = 567;
			container.addChild(playBtn);
			playBtn.visible = false;
		}
		
		private function onLogoTriggered_handler(e:Event):void
		{
			var sharedObject:SharedObject = SharedObject.getLocal("CowFallSO", "/");
			sharedObject.data.levels = new <Boolean>[true, false, false, false, false, false, false];
			sharedObject.flush();
		}
		
		private function onPlayBtnTriggered_handler(e:Event):void
		{
			touchable = false;
			dispatchEvent(new IntroEvent(IntroEvent.START_BTN_CLICKED));
		}
		
		public function play():void
		{
			_isPlaying = true;
			
			timelineAnimation = new TimelineLite();
			timelineAnimation.append(TweenLite.delayedCall(3 / 4, function():void
				{
					eyes.visible = true;
					eyes.alpha = 0
				}));
			timelineAnimation.append(TweenLite.to(eyes, 3 / 30, {alpha: 1}));
			timelineAnimation.append(TweenLite.delayedCall(3 / 20, function():void
				{
					cloud.visible = true;
					cloud.alpha = 0
				}));
			timelineAnimation.append(TweenLite.to(cloud, 3 / 20, {alpha: 1}));
			timelineAnimation.append(TweenLite.delayedCall(0, function():void
				{
					eyes.texture = Assets.getTexture("CowFall_INTRO_eye2");
					cloudText.visible = true;
					cloudText.alpha = 0;
				}));
			timelineAnimation.appendMultiple([TweenLite.to(eyes, 3 / 60, {alpha: 1}), TweenLite.delayedCall(3 / 60, function():void
				{
					TweenLite.to(eyes, 3 / 60, {alpha: 0})
				}), TweenLite.delayedCall(6 / 60, function():void
				{
					eyes.texture = Assets.getTexture("CowFall_INTRO_eye1");
				}), TweenLite.delayedCall(7 / 60, function():void
				{
					TweenLite.to(eyes, 3 / 60, {alpha: 1})
				}), TweenLite.to(cloudText, 3 / 10, {alpha: 1})]);
			timelineAnimation.appendMultiple([TweenLite.to(eyes, 24 / 60, {alpha: 0}), TweenLite.to(cloud, 24 / 60, {alpha: 0}), TweenLite.to(cloudText, 24 / 60, {alpha: 0})], 33 / 60);
			
			timelineAnimation.append(TweenLite.delayedCall(0, function():void
				{
					eyes.visible = false;
					cloud.visible = false;
					cloudText.visible = false;
					cow.visible = true;
					cow.x = 55;
					cow.y = -100;
					cow.rotation = 14 * Math.PI / 180;
				}));
			timelineAnimation.append(TweenLite.to(cow, 15 / 60, {rotation: -6 * Math.PI / 180, y: 375}));
			timelineAnimation.appendMultiple([TweenLite.to(cow, 6 / 60, {y: 300}), TweenLite.delayedCall(7 / 60, function():void
				{
					TweenLite.to(cow, 6 / 60, {y: 340})
				}), TweenLite.delayedCall(0, function():void
				{
					cowFallLogo.visible = true;
					cowFallLogo.alpha = 0;
					cowFallLogo.scaleX = 1.5;
					cowFallLogo.scaleY = cowFallLogo.scaleX;
				}), TweenLite.delayedCall(1 / 60, function():void
				{
					TweenLite.to(cowFallLogo, 0.6, {scaleX: 1, scaleY: 1, alpha: 1, ease: Bounce.easeOut})
				})]);
			timelineAnimation.appendMultiple([TweenLite.to(cow, 15 / 60, {y: cow.y - 180}), TweenLite.to(cowFallLogo, 15 / 60, {y: cowFallLogo.y - 200})], 30 / 60);
			
			timelineAnimation.append(TweenLite.delayedCall(0, function():void
				{
					background2 = new Image(Assets.getTexture("CowFall_bckg_U"));
					container.addChildAt(background2, 0);
				}));
			timelineAnimation.append(TweenLite.to(background, 30 / 60, {alpha: 0}));
			timelineAnimation.append(TweenLite.delayedCall(0, function():void
				{
					playBtn.visible = true;
					playBtn.alpha = 0
				}));
			timelineAnimation.append(TweenLite.to(playBtn, 15 / 60, {alpha: 1}));
			timelineAnimation.append(TweenLite.delayedCall(0, function():void
				{
					logo.removeEventListener(Event.TRIGGERED, onLogoTriggered_handler);
					logo.addEventListener(Event.TRIGGERED, onLogoTriggered_handler);
					playBtn.removeEventListener(Event.TRIGGERED, onPlayBtnTriggered_handler);
					playBtn.addEventListener(Event.TRIGGERED, onPlayBtnTriggered_handler);
					dispatchEvent(new IntroEvent(IntroEvent.INTRO_FINISHED));
				}));
			
			timelineAnimation.play();
		}
		
		public function stop():void
		{
			if (timelineAnimation != null)
			{
				timelineAnimation.stop();
			}
			_isPlaying = false;
			
			logo.removeEventListener(Event.TRIGGERED, onLogoTriggered_handler);
			logo.addEventListener(Event.TRIGGERED, onLogoTriggered_handler);
			playBtn.removeEventListener(Event.TRIGGERED, onPlayBtnTriggered_handler);
			playBtn.addEventListener(Event.TRIGGERED, onPlayBtnTriggered_handler);
			dispatchEvent(new IntroEvent(IntroEvent.INTRO_FINISHED));
		}
		
		public function end():void
		{
			if (isPlaying == false)
			{
				timelineAnimation.gotoAndStop(0);
				
				background.visible = false;
				
				if (background2 == null)
				{
					background2 = new Image(Assets.getTexture("CowFall_bckg_U"));
					container.addChildAt(background2, 0);
				}
				
				cow.visible = true;
				cow.alpha = 1;
				cow.rotation = -6 * Math.PI / 180;
				cow.x = 55;
				cow.y = 125;
				
				cowFallLogo.visible = true;
				cowFallLogo.alpha = 1;
				cowFallLogo.scaleX = 1;
				cowFallLogo.scaleY = cowFallLogo.scaleX;
				cowFallLogo.x = 276;
				cowFallLogo.y = 364;
				
				playBtn.visible = true;
				playBtn.alpha = 1;
				playBtn.x = 193;
				playBtn.y = 567;
				
				logo.removeEventListener(Event.TRIGGERED, onLogoTriggered_handler);
				logo.addEventListener(Event.TRIGGERED, onLogoTriggered_handler);
				playBtn.removeEventListener(Event.TRIGGERED, onPlayBtnTriggered_handler);
				playBtn.addEventListener(Event.TRIGGERED, onPlayBtnTriggered_handler);
				dispatchEvent(new IntroEvent(IntroEvent.INTRO_FINISHED));
			}
		}
		
		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}
		
	}
}