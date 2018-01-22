package states
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.events.TweenEvent;
	
	import core.Assets;
	import core.Game;
	
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	import interfaces.IState;
	
	import managers.MusicManager;
	
	import objects.BackgroundHills;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	
	public class Splash extends Sprite implements IState
	{
		private var game:Game;
		private var background:BackgroundHills;
		private var logo:Image;
		public var selectTxt:TextField;
		
		public function Splash(game:Game)
		{
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			background = new BackgroundHills();
			addChild(background)
			
			logo = new Image(Assets.ta.getTexture("An_Hero_logo"));
			logo.pivotX = logo.width * 0.5;
			logo.pivotY = logo.height * 0.5;
			logo.y = -50;
			logo.x = 475;
			TweenMax.to(logo, 2, {y:90});
			logo.scaleX = 0.25;
			logo.scaleY = 0.25;
			addChild(logo);
			
			MusicManager.playMusicMiracle(true);
			
			selectTxt = new TextField(600,100, "<Press any key to begin!>",Game.FONT_VCR, 32, 0x333333, false);
			selectTxt.pivotX = selectTxt.width * 0.5;
			selectTxt.x = 475;
			selectTxt.y = 584;
			TweenMax.to(selectTxt, 2, {y:250});
			addChild(selectTxt);
			
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
		
		private function keyUpHandler(event:KeyboardEvent):void
		{
			if(event.keyCode)
			{
				Assets.sfxMaleSelectSound.play(0,1, new SoundTransform(0.2));
				game.changeState(Game.MENU_STATE);
				trace("keyboard event detected!")
				event.currentTarget.removeEventListener(event.type, keyUpHandler);
			} else
			{
				update();
			}
		}
		
		public function update():void
		{
			background.update();
		}
		
		public function destroy():void
		{
			selectTxt.removeFromParent(true);
			selectTxt = null;
			
			logo.removeFromParent(true);
			logo = null;
			
			background.removeFromParent(true);
			background = null;
			
			removeFromParent(true);
		}
	}
}