package com.szrapnel.games.services 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author SzRaPnEL
	 */
	public class SoundController 
	{
		private static var musics:Vector.<Sound>;
		private static var musicChannels:Vector.<SoundChannel>;
		
		public function SoundController() 
		{
			
		}
		
		public static function playSound(sound:Sound, volume:Number = 0.5):void
		{
			var soundChannel:SoundChannel = new SoundChannel();
			var soundTransform:SoundTransform = new SoundTransform(volume);
			
			soundChannel = sound.play();
			soundChannel.soundTransform = soundTransform;
			
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
		}
		
		private static function onSoundComplete(e:Event):void 
		{
			var soundChannel:SoundChannel = SoundChannel(e.target);
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			soundChannel = null;
		}
		
		public static function playMusic(music:Sound, volume:Number = 0.5):void
		{
			if (musics == null)
			{
				musics = new Vector.<Sound>;
			}
			
			if (musicChannels == null)
			{
				musicChannels = new Vector.<SoundChannel>;
			}
			
			var soundChannel:SoundChannel = new SoundChannel();
			var soundTransform:SoundTransform = new SoundTransform(volume);
			
			soundChannel = music.play();
			soundChannel.soundTransform = soundTransform;
			
			musics.push(music);
			musicChannels.push(soundChannel);
			
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, onMusicComplete);
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onMusicComplete);
		}
		
		public static function stopMusic(music:Sound):void
		{
			var soundChannel:SoundChannel = musicChannels[musics.indexOf(music)];
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, onMusicComplete);
			soundChannel.stop();
			musics.splice(musics.indexOf(music), 1);
			music = null;
			musicChannels.splice(musicChannels.indexOf(soundChannel), 1);
			soundChannel = null;
		}
		
		private static function onMusicComplete(e:Event):void 
		{
			var soundChannel:SoundChannel = SoundChannel(e.target);
			soundChannel.removeEventListener(Event.SOUND_COMPLETE, onMusicComplete);
			soundChannel = musics[musicChannels.indexOf(soundChannel)].play();
			soundChannel.soundTransform = soundChannel.soundTransform;
			soundChannel.addEventListener(Event.SOUND_COMPLETE, onMusicComplete);
		}
		
	}
}