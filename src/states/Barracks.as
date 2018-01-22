package states
{
	import com.greensock.TweenMax;
	
	import core.Assets;
	import core.Game;
	
	import flash.media.SoundTransform;
	
	import interfaces.IState;
	
	import managers.MusicManager;
	
	import objects.BackgroundBarracks;
	
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	public class Barracks extends Sprite implements IState
	{
		private var game:Game;
		private var background:BackgroundBarracks;
		private var maleSelectbtn:Button;
		private var femaleSelectbtn:Button;
		private var femaleSelected:Boolean = false;
		private var maleSelected:Boolean = false;
		private var confirmbtn:Button;
		private var pleasetxt:TextField;
		
		
		public function Barracks(game:Game)
		{
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			background = new BackgroundBarracks();
			addChild(background);
			
			MusicManager.playMusicSpirits(true);
			
			maleSelectbtn = new Button(Assets.ta.getTexture("Male_Head_Button"),"",Assets.ta.getTexture("Male_Head_Button_Down"));
			maleSelectbtn.pivotX = maleSelectbtn.width * 0.5;
			maleSelectbtn.pivotY = maleSelectbtn.height * 0.5;
			maleSelectbtn.x = 250;
			maleSelectbtn.y = 250;
			maleSelectbtn.scaleX = 0.7;
			maleSelectbtn.scaleY = 0.7;
			maleSelectbtn.addEventListener(Event.TRIGGERED, onMaleSelect);
			addChild(maleSelectbtn);
			
			femaleSelectbtn = new Button(Assets.ta.getTexture("Female_Head_Button"),"",Assets.ta.getTexture("Female_Head_Button_Down"));
			femaleSelectbtn.pivotX = femaleSelectbtn.width * 0.5;
			femaleSelectbtn.pivotY = femaleSelectbtn.height * 0.5;
			femaleSelectbtn.x = 700;
			femaleSelectbtn.y = 250;
			femaleSelectbtn.scaleX = 0.7;
			femaleSelectbtn.scaleY = 0.7;
			femaleSelectbtn.addEventListener(Event.TRIGGERED, onFemaleSelect);
			addChild(femaleSelectbtn);
			
			confirmbtn = new Button(Assets.ta.getTexture("btnConfirm_Up"),"",Assets.ta.getTexture("btnConfirm_Down"));
			confirmbtn.pivotX = confirmbtn.width * 0.5;
			confirmbtn.pivotY = confirmbtn.height * 0.5;
			confirmbtn.x = 475;
			confirmbtn.y = 475;
			confirmbtn.scaleX = 0.5;
			confirmbtn.scaleY = 0.5;
			confirmbtn.addEventListener(Event.TRIGGERED, onConfirm);
			addChild(confirmbtn);
			
			pleasetxt = new TextField(400, 100, "Please Select a Gender", Game.FONT_VCR, 40, 0xf0f8ff, false);
			pleasetxt.autoScale = true;
			pleasetxt.pivotX = pleasetxt.width * 0.5;
			pleasetxt.pivotY = pleasetxt.height * 0.5;
			pleasetxt.x = 475;
			pleasetxt.y = 50;
			addChild(pleasetxt);
		}
		
		private function onConfirm():void
		{
			if(maleSelected)
			{
				Assets.sfxMaleSelectSound.play(0,1, new SoundTransform(0.2));
				Game.genderSelect = Game.MALE_SELECTED;
				TweenMax.allTo([background,pleasetxt,confirmbtn,femaleSelectbtn,maleSelectbtn], 0.2, {y: 600, onComplete: goToConfirm});
			} 
			else if(femaleSelected)
			{
				Assets.sfxMaleSelectSound.play(0,1, new SoundTransform(0.2));
				Game.genderSelect = Game.FEMALE_SELECTED;
				TweenMax.allTo([background,pleasetxt,confirmbtn,femaleSelectbtn,maleSelectbtn], 0.2, {y: 600, onComplete: goToConfirm});
			}
		}
		
		private function goToConfirm():void
		{
			game.changeState(Game.BATTLE_STATE);
		}
		
		private function onMaleSelect():void
		{
			Assets.sfxMaleSelectSound.play(0,1, new SoundTransform(0.2));
			femaleSelectbtn.upState = Assets.ta.getTexture("Female_Head_Button");
			maleSelectbtn.upState = maleSelectbtn.downState;
			
			femaleSelected = false;
			maleSelected = true;
		}
		
		private function onFemaleSelect():void
		{
			Assets.sfxFemaleSelectSound.play(0,1, new SoundTransform(0.2));
			maleSelectbtn.upState = Assets.ta.getTexture("Male_Head_Button");
			femaleSelectbtn.upState = femaleSelectbtn.downState;
			
			maleSelected = false;
			femaleSelected = true;
		}
		
		public function update():void
		{
			
		}
		
		public function destroy():void
		{
			MusicManager.playMusicSpirits(false);
			
			background.removeFromParent(true);
			background = null;
			
			femaleSelectbtn.removeFromParent(true);
			femaleSelectbtn = null;
			
			maleSelectbtn.removeFromParent(true);
			maleSelectbtn = null;
			
			pleasetxt.removeFromParent(true);
			pleasetxt = null;
			
			confirmbtn.removeFromParent(true);
		}
	}
}