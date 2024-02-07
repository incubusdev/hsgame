import 'dart:async';

import 'package:estudosflame/HisoftGame/actors/hs_employed.dart';
import 'package:estudosflame/HisoftGame/obstaculos.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';



class HisoftGame  extends FlameGame with DragCallbacks ,HasCollisionDetection {

    late final  SpriteComponent background;
    late final  TiledComponent tiledMap;
    final world = World();
    late final HsEmployed hsEmployed;
    late final CameraComponent cameraComponent;
    late final JoystickComponent joystick;
@override
  FutureOr<void> onLoad()async  {
    // debugMode = true;
   tiledMap = await TiledComponent.load('hsmap3.tmx', Vector2(16,16));

    addJoyStick();
    hsEmployed = HsEmployed(joystick: joystick);
    add(world);
    world.add(tiledMap);
    world.add(hsEmployed);
    
   List<TiledObject> obstacless = tiledMap.tileMap.getLayer<ObjectGroup>('obstaculos')!.objects;
   for(final obstacmc in  obstacless){
    world.add(Obstaculos()..position=Vector2(obstacmc.x, obstacmc.y)..size = Vector2(obstacmc.width, obstacmc.height));
   }
     cameraComponent = CameraComponent(world: world);
     cameraComponent.viewfinder.zoom =
        cameraComponent.viewfinder.zoom.clamp(2.3, 3);
     cameraComponent.follow(hsEmployed);
    //  add(hsEmployed);
     add(cameraComponent);
     add(joystick);

   
     
   
  
    return await super.onLoad();
  }



  Future<void> addBackGround()async {


 Sprite backgroundSprite = await loadSprite('backgroundtest.png');

   background = SpriteComponent()
    ..sprite  =  backgroundSprite..size = backgroundSprite.originalSize;

  }
  void addJoyStick(){
 final knobPaint = BasicPalette.blue.withAlpha(50).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(50).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 20, paint: knobPaint),
      background: CircleComponent(radius: 60, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

  }



  


}