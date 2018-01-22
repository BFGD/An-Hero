package states
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Power0;
	
	import core.Assets;
	import core.Game;
	
	import flash.media.SoundTransform;
	
	import interfaces.IState;
	
	import managers.MusicManager;
	
	import objects.BackgroundCastle;
	
	import starling.animation.DelayedCall;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class End extends Sprite implements IState
	{
		private var game:Game;
		private var background:BackgroundCastle;
		
		private var musicDelay:DelayedCall;
		private var txtOutcome:TextField;
		private var btnMenu:Button;
		private var btnCredits:Button;
		
		public function End(game:Game)
		{
			this.game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(event:Event):void
		{
			background = new BackgroundCastle();
			background.y = -543
			addChild(background);
			TweenMax.to(background, 0.3, {y:0});
			
			MusicManager.playMusicMiracleStinger();
			
			txtOutcome = new TextField(350,200,setUpText(),Game.FONT_VCR,80,0xf0f8ff,true);
			txtOutcome.pivotX = txtOutcome.width * 0.5;
			txtOutcome.pivotY = txtOutcome.height * 0.5;
			txtOutcome.x = 475;
			txtOutcome.y = -543;
			txtOutcome.visible = true;
			addChild(txtOutcome);
			TweenMax.to(txtOutcome, 0.3, {y:170});
			txtTweenBackAndForth();
			
			btnMenu = new Button(Assets.ta.getTexture("btnMenu_Up"),"",Assets.ta.getTexture("btnMenu_Down"));
			btnMenu.pivotX = btnMenu.width * 0.5;
			btnMenu.pivotY = btnMenu.height * 0.5;
			btnMenu.x = 475;
			btnMenu.y = -543;
			TweenMax.to(btnMenu, 0.3, {y:300});
			btnMenu.scaleX = 0.4;
			btnMenu.scaleY = 0.4;
			btnMenu.addEventListener(Event.TRIGGERED, onMenu);
			addChild(btnMenu);
			
			btnCredits = new Button(Assets.ta.getTexture("btnCredits_Up"),"",Assets.ta.getTexture("btnCredits_Down"));
			btnCredits.pivotX = btnCredits.width * 0.5;
			btnCredits.pivotY = btnCredits.height * 0.5;
			btnCredits.x = 475;
			btnCredits.y = -543;
			TweenMax.to(btnCredits, 0.3, {y:400});
			btnCredits.scaleX = 0.4;
			btnCredits.scaleY = 0.4;
			btnCredits.addEventListener(Event.TRIGGERED, onCredits);
			addChild(btnCredits);
		
		}
		
		private function onCredits():void
		{
			TweenMax.allTo([btnCredits,btnMenu,txtOutcome,background], 0.3, {y:700, onComplete: destroyAll, onCompleteParams:[Game.CREDITS_STATE]});
			MusicManager.playMusicMiracle(true);
		}
		
		private function onMenu():void
		{
			TweenMax.allTo([btnCredits,btnMenu,txtOutcome,background], 0.3, {y:700, onComplete: destroyAll, onCompleteParams:[Game.MENU_STATE]});
			MusicManager.playMusicMiracle(true);
			
		}
		
		private function destroyAll(state:int):void
		{
			game.changeState(state);
		}
		
		private function txtTweenBackAndForth():void
		{
	
			one();
				
			function one():void
			{	
				
				TweenMax.to(txtOutcome, 2, {scaleX: 1.5, scaleY: 1.5, onComplete: two, ease: Power0.easeNone})
				
			}
			
			function two():void
			{
				TweenMax.to(txtOutcome, 2, {scaleX: 1, scaleY: 1, onComplete: one, ease: Power0.easeNone})
			}
		
		}
		
		private function setUpText():String
		{
			var outcome:String = null;
			trace(Game.gameOutcome);
			
			if(Game.gameOutcome == "hero")
			{
				return outcome = "DEFEAT";
			}
			else
			{
				return outcome = "Victory";
			}
		}
		
		public function update():void
		{
			
		}
		
		public function destroy():void
		{
			TweenMax.killAll()
				
			background.removeFromParent(true);
			background = null;
			
			btnCredits.removeFromParent(true);
			btnCredits = null;
			
			btnMenu.removeFromParent(true);
			btnMenu = null;
			
			txtOutcome.removeFromParent(true);
			txtOutcome = null;
			
			removeFromParent(true);
		}
	}
}