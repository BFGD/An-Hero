package core
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.sampler.Sample;
	
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		[Embed(source="assets/Backgrounds/bkgHills.png")]
		private static var bkgHills:Class;
		public static var bkgHillsTexture:Texture; 
		
		[Embed(source="assets/Backgrounds/bkgBarracks.png")]
		private static var bkgBarracks:Class;
		public static var bkgBarracksTexture:Texture; 
		
		[Embed(source="assets/Backgrounds/bkgCastle.png")]
		private static var bkgCastle:Class;
		public static var bkgCastleTexture:Texture; 
		
		[Embed(source="assets/InstructionsSlate.png")]
		private static var slateInstructions:Class;
		public static var slateInstructionsTexture:Texture;
		
		[Embed(source="assets/CreditsSlate.png")]
		private static var slateCredits:Class;
		public static var slateCreditsTexture:Texture;
		
		// Sounds
		[Embed(source="assets/Music/miracle_park_long.mp3", mimeType="audio/mpeg")]
		private static var miracleParkLongSound:Class;
		public static var musicMiracle:Sound;
		
		[Embed(source="assets/Music/miracle_park_stinger.mp3", mimeType="audio/mpeg")]
		private static var miracleParkStingerSound:Class;
		public static var musicMiracleStinger:Sound;
		
		[Embed(source="assets/Music/spirits_dance_long.mp3", mimeType="audio/mpeg")]
		private static var spiritsDanceLongSound:Class;
		public static var musicSpirits:Sound;
		
		[Embed(source="assets/Music/fortress_long.mp3", mimeType="audio/mpeg")]
		private static var fortressLongSound:Class;
		public static var musicFortress:Sound;
		
		[Embed(source="assets/SFX/hit1.mp3", mimeType="audio/mpeg")]
		private static var hit1Sound:Class;
		public static var sfxHit1:Sound;
		
		[Embed(source="assets/SFX/sfxSelect_Sound.mp3", mimeType="audio/mpeg")]
		private static var selectSound:Class;
		public static var sfxSelectSound:Sound;
		
		[Embed(source="assets/SFX/sfxMaleSelect.mp3", mimeType="audio/mpeg")]
		private static var maleSelectSound:Class;
		public static var sfxMaleSelectSound:Sound;
		
		[Embed(source="assets/SFX/sfxFemaleSelect.mp3", mimeType="audio/mpeg")]
		private static var femaleSelectSound:Class;
		public static var sfxFemaleSelectSound:Sound;
		
		// Embedded texture atlas
		[Embed(source="assets/anHeroAtlas.png")]
		private static var anHeroAtlas:Class;
		
		public static var ta:TextureAtlas;
		
		[Embed(source="assets/anHeroAtlas.xml", mimeType="application/octet-stream")]
		private static var anHeroAtlasXML:Class;
		//
		
		// Embedded custom font
		[Embed(source="assets/VCR_OSD_FONT.png")]
		private static var vcrFont:Class;
		
		[Embed(source="assets/VCR_OSD_FONT_XML.xml", mimeType="application/octet-stream")]
		private static var vcrFontXML:Class;
		//
		
		public static function init():void
		{
			// Initialise non-texture atlas textures
			bkgHillsTexture = Texture.fromBitmap(new bkgHills());
			bkgBarracksTexture = Texture.fromBitmap(new bkgBarracks());
			bkgCastleTexture = Texture.fromBitmap(new bkgCastle());
			
			slateInstructionsTexture = Texture.fromBitmap(new slateInstructions());
			slateCreditsTexture = Texture.fromBitmap(new slateCredits());
			
			// Initialise texture atlas
			ta = new TextureAtlas(Texture.fromBitmap(new anHeroAtlas()),
				XML(new anHeroAtlasXML()));
			
			// Initialise custom font
			TextField.registerBitmapFont(new BitmapFont(Texture.fromBitmap(new vcrFont()),
				XML(new vcrFontXML())));
			
			// Intialise sound and music + force play on start
			musicMiracle = new miracleParkLongSound();
			musicMiracle.play(0,0, new SoundTransform(0));
			
			musicMiracleStinger = new miracleParkStingerSound();
			musicMiracleStinger.play(0,0, new SoundTransform(0));
			
			musicSpirits = new spiritsDanceLongSound();
			musicSpirits.play(0,0, new SoundTransform(0));
			
			musicFortress = new fortressLongSound();
			musicFortress.play(0,0, new SoundTransform(0));
			
			sfxHit1 = new hit1Sound();
			sfxHit1.play(0,0, new SoundTransform(0));
			
			sfxSelectSound = new selectSound();
			sfxSelectSound.play(0,0, new SoundTransform(0));
			
			sfxMaleSelectSound = new selectSound();
			sfxMaleSelectSound.play(0,0, new SoundTransform(0));
			
			sfxFemaleSelectSound = new selectSound();
			sfxFemaleSelectSound.play(0,0, new SoundTransform(0));
		}
	}
}