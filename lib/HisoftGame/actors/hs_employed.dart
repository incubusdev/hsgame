
import 'package:estudosflame/HisoftGame/highsoft_game.dart';
import 'package:estudosflame/HisoftGame/obstaculos.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';



class HsEmployed extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<HisoftGame> {


  double maxSpeed = 70.0;
  late final Vector2 _lastSize = size.clone();
  late final Transform2D _lastTransform = transform.clone();
  bool emplyedFlipped  = true;
  bool collided  = false;
  JoystickDirection collidedDirection = JoystickDirection.idle;

  final JoystickComponent joystick;
  HsEmployed({required this.joystick})
      : super(size: Vector2(16, 32), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    animation = SpriteAnimation.fromFrameData(
      await game.images.load('bob_run.png'),
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2(16, 32),
        stepTime: 0.20,
      ),
    );
    position = Vector2(320, 780);
    add(
      RectangleHitbox(size: Vector2(12, 23),position: Vector2(2,9))
    );
   
  }

  @override
  void update(double dt) {


    bool moveLeft = gameRef.joystick.direction == JoystickDirection.left;
    bool moveupLeft = gameRef.joystick.direction == JoystickDirection.upLeft;
    bool movedownLeft = gameRef.joystick.direction == JoystickDirection.downLeft;

    bool moveRight= gameRef.joystick.direction == JoystickDirection.right;
    bool moveupRight= gameRef.joystick.direction == JoystickDirection.upRight;
    bool movedownRight= gameRef.joystick.direction == JoystickDirection.downRight;

    bool moveUp = gameRef.joystick.direction == JoystickDirection.up;
    bool moveDown = gameRef.joystick.direction == JoystickDirection.down;
    double employedVectorX = (joystick.relativeDelta * 100* dt)[0];
    double employedVectory = (joystick.relativeDelta * 100 * dt)[1];

 
 if(moveLeft && x > 0 ){
  if(!collided || collidedDirection == JoystickDirection.right || collidedDirection == JoystickDirection.up || collidedDirection == JoystickDirection.down || collidedDirection == JoystickDirection.upRight || collidedDirection == JoystickDirection.downRight ){
    x += employedVectorX;
    
  }
 }
 if(moveupLeft && x > 0 && y > 0){
  if(!collided || collidedDirection == JoystickDirection.down || collidedDirection == JoystickDirection.right || collidedDirection == JoystickDirection.downRight || collidedDirection == JoystickDirection.downLeft || collidedDirection == JoystickDirection.left   ){
    x += employedVectorX ;
    y += employedVectory;
    
  }
 }
 if(movedownLeft && x > 0 && y > 0){
  if(!collided || collidedDirection == JoystickDirection.upRight ||  collidedDirection == JoystickDirection.right ||  collidedDirection == JoystickDirection.left ||  collidedDirection == JoystickDirection.up || collidedDirection == JoystickDirection.upLeft ){
    x += employedVectorX ;
    y += employedVectory ;
    
  }
 }

 if(moveRight  && x > 0 && y  > 0){
  if(!collided || collidedDirection == JoystickDirection.left ||  collidedDirection == JoystickDirection.up ||  collidedDirection == JoystickDirection.down || collidedDirection == JoystickDirection.upLeft || collidedDirection == JoystickDirection.downLeft ){
    x += employedVectorX;
  }
 }
 if(moveupRight && y  > 0){
  if(!collided || collidedDirection == JoystickDirection.down ||  collidedDirection == JoystickDirection.left ||  collidedDirection == JoystickDirection.downLeft || collidedDirection == JoystickDirection.upLeft   || collidedDirection == JoystickDirection.up  ){
    x += employedVectorX ;
    y += employedVectory;
  }
 }
 if(movedownRight  && x  > 0 && y   > 0 ){
  if(!collided || collidedDirection == JoystickDirection.up ||  collidedDirection == JoystickDirection.left ||  collidedDirection == JoystickDirection.upLeft ||  collidedDirection == JoystickDirection.downLeft || collidedDirection == JoystickDirection.down ){
    x += employedVectorX;
    y += employedVectory;
  }
 }


 if(moveUp && y > 0){
  if(!collided || collidedDirection == JoystickDirection.down ||  collidedDirection == JoystickDirection.downLeft ||  collidedDirection == JoystickDirection. downRight ||  collidedDirection == JoystickDirection.left ||  collidedDirection == JoystickDirection.right){
    y+= employedVectory;
  }
 }
 if(moveDown){
  if(!collided || collidedDirection == JoystickDirection.up ||  collidedDirection == JoystickDirection.upRight ||  collidedDirection == JoystickDirection.upLeft ||  collidedDirection == JoystickDirection.right ||  collidedDirection == JoystickDirection.left){
    y += employedVectory;
  }
 }
    // this.position.add(joystick.relativeDelta * 100 * dt);
    // print(joystick.relativeDelta);
  
    // if (!joystick.delta.isZero() && activeCollisions.isEmpty) {
    //   _lastSize.setFrom(size);
    //   _lastTransform.setFrom(transform);
    //   position.add(joystick.relativeDelta * maxSpeed * dt);
    //   // angle = joystick.delta.screenAngle();
    // }
    if(joystick.relativeDelta[0] < 0 && emplyedFlipped ){
      emplyedFlipped = false;
      flipHorizontallyAroundCenter();
    }
    if(joystick.relativeDelta[0] > 0 && !emplyedFlipped ){
      emplyedFlipped = true;
      flipHorizontallyAroundCenter();
    }
    
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    
    super.onCollision(intersectionPoints, other);
    if(other is Obstaculos){
      if(!collided){

      collided = true;
      collidedDirection =  gameRef.joystick.direction;
      joystick.delta.isZero();
      }
     ;
    }
  }


@override
  void onCollisionEnd(PositionComponent other) {
   collidedDirection = JoystickDirection.idle;
   collided = false;
    super.onCollisionEnd(other);
  }
  // @override
  // void onCollisionStart(
  //   Set<Vector2> intersectionPoints,
  //   PositionComponent other,
  // ) {
  //   super.onCollisionStart(intersectionPoints, other);
  //   transform.setFrom(_lastTransform);
  //   size.setFrom(_lastSize);
  
  
  // }
}
