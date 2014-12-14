package com.szrapnel.games.services 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.system.Capabilities;
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
			//if (Capabilities.os.search("Linux") == -1)
			//{
				var soundChannel:SoundChannel = new SoundChannel();
				var soundTransform:SoundTransform = new SoundTransform(volume);
				
				soundChannel = sound.play();
				soundChannel.soundTransform = soundTransform;
				
				soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			//}
			//else
			//{			
				
			//}
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
			
			musicChannels[musicChannels.length - 1].removeEventListener(Event.SOUND_COMPLETE, onMusicComplete);
			musicChannels[musicChannels.length - 1].addEventListener(Event.SOUND_COMPLETE, onMusicComplete);
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
			var volume:Number = soundChannel.soundTransform.volume;
			var indexofSoundChannel:int = musicChannels.indexOf(soundChannel);
			var music:Sound = musics[indexofSoundChannel];
			soundChannel = music.play();
			musicChannels.splice(indexofSoundChannel, 1);
			musicChannels.push(soundChannel);
			musics.splice(indexofSoundChannel, 1);
			musics.push(music);
			var soundTransform:SoundTransform = new SoundTransform(volume);
			musicChannels[musicChannels.length - 1].soundTransform = soundTransform;
			musicChannels[musicChannels.length - 1].removeEventListener(Event.SOUND_COMPLETE, onMusicComplete);
			musicChannels[musicChannels.length - 1].addEventListener(Event.SOUND_COMPLETE, onMusicComplete);
		}
		
	}
}