import 'dart:async';


import 'package:estudosflame/HisoftGame/actors/hs_employed.dart';
import 'package:estudosflame/HisoftGame/highsoft_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';




class Obstaculos extends PositionComponent with HasGameRef<HisoftGame>,CollisionCallbacks {
 



@override
  FutureOr<void> onLoad()async {
    add(RectangleHitbox());
  
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
   if(other is HsEmployed){
    // print('bateu em algo');
   }
    super.onCollision(intersectionPoints, other);
  }

@override
  void onCollisionEnd(PositionComponent other) {
    if(other is HsEmployed){
      // print('manucuuuu');
    }
    super.onCollisionEnd(other);
  }
  
  


}


