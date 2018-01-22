package states
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Ease;
	
	import core.Assets;
	import core.Game;
	
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	
	import interfaces.IState;
	
	import managers.MusicManager;
	
	import objects.BackgroundHills;
	
	import starling.animation.Tween;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Menu extends Sprite implements IState
	{
		private var game:Game;
		private var background:BackgroundHills;
		private var playbtn:Button;
		private var logo:Image;
		private var instructionsbtn:Button;
		private var creditsbtn:Button;
		private var pressedState:int;
		private var btnSoundUp:Button;
		private var btnSoundDown:Button;
		
		public function Menu(game:Game)
		{
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			background = new BackgroundHills();
			background.hills1.x = Game.xCordHill1;
			background.hills2.x = Game.xCordHill2;
			addChild(background)
			
			logo = new Image(Assets.ta.getTexture("An_Hero_logo"));
			logo.pivotX = logo.width * 0.5;
			logo.pivotY = logo.height * 0.5;
			menuDrop();
			
			playbtn = new Button(Assets.ta.getTexture("btnPlay_Up"),"",Assets.ta.getTexture("btnPlay_Down"));
			playbtn.pivotX = playbtn.width * 0.5;
			playbtn.pivotY = playbtn.height * 0.5;
			playbtn.y = 230;
			playbtn.x = 1050;
			TweenMax.to(playbtn, 1, {x:475});
			playbtn.scaleX = 0.4;
			playbtn.scaleY = 0.4;
			playbtn.addEventListener(Event.TRIGGERED, onPlay);
			addChild(playbtn);
			
			instructionsbtn = new Button(Assets.ta.getTexture("btnInstructions_Up"),"",Assets.ta.getTexture("btnInstructions_Down"));
			instructionsbtn.pivotX = instructionsbtn.width * 0.5;
			instructionsbtn.pivotY = instructionsbtn.height * 0.5;
			instructionsbtn.y = 320;
			instructionsbtn.x = -50;
			TweenMax.to(instructionsbtn, 1, {x:475});
			instructionsbtn.scaleX = 0.4;
			instructionsbtn.scaleY = 0.4;
			instructionsbtn.addEventListener(Event.TRIGGERED, onInstructions);
			addChild(instructionsbtn);
			
			creditsbtn = new Button(Assets.ta.getTexture("btnCredits_Up"),"",Assets.ta.getTexture("btnCredits_Down"));
			creditsbtn.pivotX = creditsbtn.width * 0.5;
			creditsbtn.pivotY = creditsbtn.height * 0.5;
			creditsbtn.y = 410;
			creditsbtn.x = 1050;
			TweenMax.to(creditsbtn, 1, {x:475});
			creditsbtn.scaleX = 0.4;
			creditsbtn.scaleY = 0.4;
			creditsbtn.addEventListener(Event.TRIGGERED, onCredits);
			addChild(creditsbtn);
			
			btnSoundUp = new Button(Assets.ta.getTexture("SoundButton_Up"));
			btnSoundUp.pivotX = btnSoundUp.width * 0.5;
			btnSoundUp.pivotY = btnSoundUp.height * 0.5;
			btnSoundUp.x = 1000;
			btnSoundUp.y = 50;
			btnSoundUp.scaleX = 0.5;
			btnSoundUp.scaleY = 0.5;
			btnSoundUp.visible = Game.soundUpVisible;
			btnSoundUp.addEventListener(Event.TRIGGERED, onSoundUp);
			TweenMax.to(btnSoundUp, 1, {x:900});
			addChild(btnSoundUp);
			
			btnSoundDown = new Button(Assets.ta.getTexture("SoundButton_Down"));
			btnSoundDown.pivotX = btnSoundDown.width * 0.5;
			btnSoundDown.pivotY = btnSoundDown.height * 0.5;
			btnSoundDown.x = 1000;
			btnSoundDown.y = 50;
			btnSoundDown.scaleX = 0.5;
			btnSoundDown.scaleY = 0.5;
			btnSoundDown.visible = Game.soundDownVisisble;
			btnSoundDown.addEventListener(Event.TRIGGERED, onSoundDown);
			TweenMax.to(btnSoundDown, 1, {x:900});
			addChild(btnSoundDown);
		}
		
		private function menuDrop():void
		{
			if(Game.menuDrop)
			{
				logo.y = -200;
				logo.x = 475;
				logo.scaleX = 0.25;
				logo.scaleY = 0.25;
				TweenMax.to(logo, 1, {y:90});
				addChild(logo);
			}
			else
			{
				logo.y = 90;
				logo.x = 475;
				logo.scaleX = 0.25;
				logo.scaleY = 0.25;
				addChild(logo);
			}
		}
		
		private function onSoundDown():void
		{
			btnSoundUp.visible = true;
			Game.soundUpVisible = true;
			btnSoundDown.visible = false;
			Game.soundDownVisisble = false;
			SoundMixer.soundTransform = new SoundTransform(1);
		}
		
		private function onSoundUp():void
		{
			btnSoundUp.visible = false;
			Game.soundUpVisible = false;
			btnSoundDown.visible = true;
			Game.soundDownVisisble = true;
			SoundMixer.soundTransform = new SoundTransform(0);
		}
		
		private function onPlay():void
		{
			Assets.sfxSelectSound.play(0,1, new SoundTransform(0.2));
			TweenMax.allTo([background,logo,playbtn,instructionsbtn,btnSoundDown,btnSoundUp,creditsbtn], 0.2, {y: 600, onComplete: goToPlay});
			MusicManager.playMusicMiracle(false);
		}
		
		private function goToPlay():void
		{
			Game.menuDrop = true;
			game.changeState(Game.BARRACKS_STATE);
		}
		
		private function onInstructions():void
		{
			Assets.sfxSelectSound.play(0,1, new SoundTransform(0.2));
			Game.menuDrop = true;
			pressedState = Game.INSTRUCTIONS_STATE;
			TweenMax.to(logo, 0.2, {y:-150});
			TweenMax.to(playbtn, 0.2, {x:-1000});
			TweenMax.to(instructionsbtn, 0.2, {x:1100, onComplete: destroyAll, onCompleteParams:[Game.INSTRUCTIONS_STATE]});
			TweenMax.to(btnSoundDown, 0.2, {x:1100});
			TweenMax.to(btnSoundUp, 0.2, {x:1100});
			TweenMax.to(creditsbtn, 0.2, {x:-1000});
		}
		
		private function onCredits():void
		{
			Assets.sfxSelectSound.play(0,1, new SoundTransform(0.2));
			Game.menuDrop = true;
			pressedState = Game.CREDITS_STATE;
			TweenMax.to(logo, 0.2, {y:-150});
			TweenMax.to(playbtn, 0.2, {x:-1000});
			TweenMax.to(instructionsbtn, 0.2, {x:1100});
			TweenMax.to(btnSoundDown, 0.2, {x:1100});
			TweenMax.to(btnSoundUp, 0.2, {x:1100});
			TweenMax.to(creditsbtn, 0.2, {x:-1000, onComplete: destroyAll, onCompleteParams:[Game.CREDITS_STATE]});
		}
		
		public function destroyAll(state:int):void
		{
			game.changeState(state);
		}
		
		public function update():void
		{
			background.update();
			
		}
		
		public function destroy():void
		{
			background.removeFromParent(true);
			background = null;
			
			logo.removeFromParent(true);
			logo = null;
			
			playbtn.removeFromParent(true);
			playbtn = null;
			
			instructionsbtn.removeFromParent(true);
			instructionsbtn = null;
			
			creditsbtn.removeFromParent(true);
			creditsbtn = null;
			
			btnSoundUp.removeFromParent(true);
			btnSoundUp = null;
			
			removeFromParent(true);
			trace("menu destroyed")
		}
	}
}