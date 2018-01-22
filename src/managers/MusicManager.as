package managers
{
	import core.Assets;
	
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import starling.errors.AbstractClassError;

	public class MusicManager
	{
		public static var musicMiracleChannel:SoundChannel
		private static var musicSpiritsChannel:SoundChannel;
		public static var musicFortressChannel:SoundChannel;
		private static var musicMiracleStingerChannel:SoundChannel;
	
		public function MusicManager()
		{
			init();
		}
		
		public function init():void
		{
			Assets.musicMiracle.load(new URLRequest("musicMiracle"));
			Assets.musicSpirits.load(new URLRequest("musicSpirits"));
			Assets.musicFortress.load(new URLRequest("musicFortress"));
			Assets.musicMiracleStinger.load(new URLRequest("musicMiracleStinger"));
		}
		
		public static function playMusicMiracle(isPlay:Boolean):void
		{
			if(isPlay)
			{
				musicMiracleChannel = Assets.musicMiracle.play(0,100,new SoundTransform(0.01));
				
			} 
			else 
			{
				musicMiracleChannel.stop();
				musicMiracleChannel = null;
				
			}
		}
		
		public static function playMusicSpirits(isPlay:Boolean):void
		{
			if(isPlay)
			{
				musicSpiritsChannel = Assets.musicSpirits.play(0,100,new SoundTransform(0.01));
				
			} else 
			{
				musicSpiritsChannel.stop();
			}
		}
		
		public static function playMusicFortress(isPlay:Boolean):void
		{
			if(isPlay)
			{
				musicFortressChannel = Assets.musicFortress.play(0,100,new SoundTransform(0.3));
				
			} else 
			{
				musicFortressChannel.stop();
			}
		}
		
		public static function playMusicMiracleStinger():void
		{
			musicMiracleStingerChannel = Assets.musicMiracleStinger.play(1800,1,new SoundTransform(0.01));
		}
		
	}
}