package com.iainlobb.gamepad;

import com.iainlobb.gamepadtesters.GamepadTester;
import com.iainlobb.gamepadtesters.PlatformGamepadTester;
import nme.display.Sprite;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.Lib;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;

/**
 * ...
 * @author Adam Harte (adam@adamharte.com)
 */

class Main extends Sprite
{
	private var testerContainer:Sprite;
	private var uiContainer:Sprite;
	private var gamepadTesterButton:Sprite;
	private var platformGamepadTesterButton:Sprite;
	
	
	public function new () 
	{
		super();
		
		if (stage != null) init();
		else addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	
	
	private function init():Void 
	{
		testerContainer = new Sprite();
		uiContainer = new Sprite();
		addChild(testerContainer);
		addChild(uiContainer);
		
		gamepadTesterButton = createButton('Top Down');
		platformGamepadTesterButton = createButton('Platformer');
		gamepadTesterButton.addEventListener(MouseEvent.CLICK, onGamepadTesterClick);
		platformGamepadTesterButton.addEventListener(MouseEvent.CLICK, onPlatformGamepadTesterClick);
		
		showGamepadTest();
		//showPlatformGameTest();
	}
	
	private function createButton(labelText:String):Sprite 
	{
		var newButton:Sprite = new Sprite();
		newButton.buttonMode = true;
		newButton.useHandCursor = true;
		if (uiContainer.width > 0) 
		{
			newButton.x = uiContainer.width + 10;
		}
		uiContainer.addChild(newButton);
		
		newButton.graphics.beginFill(0xDDDDDD, 0.8);
		newButton.graphics.lineStyle(1, 0xEEEEEE, 0.6);
		newButton.graphics.drawRect(0, 0, 60, 20);
		
		var format:TextFormat = new TextFormat('Arial', 9, 0x999999);
		format.align = TextFormatAlign.CENTER;
		var label:TextField = new TextField();
		label.defaultTextFormat = format;
		label.selectable = false;
		label.mouseEnabled = false;
		label.y = 2;
		label.width = 60;
		label.height = 16;
		label.text = labelText;
		newButton.addChild(label);
		
		return newButton;
	}
	
	private function showGamepadTest() 
	{
		removeOldTest();
		testerContainer.addChild(new GamepadTester());
	}
	
	private function showPlatformGameTest() 
	{
		removeOldTest();
		testerContainer.addChild(new PlatformGamepadTester());
	}
	
	private function removeOldTest() 
	{
		while (testerContainer.numChildren > 0) 
		{
			testerContainer.removeChildAt(0);
		}
	}
	
	
	
	private function onAddedToStage(event:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		init();
	}
	
	private function onGamepadTesterClick(e:MouseEvent):Void 
	{
		showGamepadTest();
	}
	
	private function onPlatformGamepadTesterClick(e:MouseEvent):Void 
	{
		showPlatformGameTest();
	}
	
	
	
	static public function main() 
	{
		Lib.current.addChild(new Main());
	}
	
}