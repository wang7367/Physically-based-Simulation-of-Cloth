void setup() {
  size(900, 900, P3D);
  surface.setTitle("Project2");
  initScene();
  noStroke();
}

Vec2 spherePos=new Vec2(550,320); //600,280
float sphereR=70; //75

//Vec2 spherePos=new Vec2(480,400); //600,280

//Vec2 spherePos=new Vec2(600,600); //600,280
float kf = 0.001;//0.001
float gravity=400;


static int maxNodes = 100;

Vec2  ball[][]=new Vec2[maxNodes][maxNodes];
Vec2  vel[][]=new Vec2[maxNodes][maxNodes];
Vec2  acc[][]=new Vec2[maxNodes][maxNodes];
Vec2  oldVel[][]=new Vec2[maxNodes][maxNodes];
boolean  broken[][]=new boolean[maxNodes][maxNodes];

//Vec2 prevPos=new Vec2(spherePos.x, spherePos.y);
//float speed;

float ks = 50; 
float kd = 10;


int numNodes = 11;
float stringTopX = 200;
float stringTopY = 200;
float radius = 5;

float floor=900;
float maxDis=130;


void initScene(){
  for (int i = 0; i < numNodes; i++){
    for(int j=0; j<numNodes; j++){
    ball[i][j] = new Vec2(stringTopX+40*j+20*i, stringTopY-10*i);
    vel[i][j] =new Vec2(0,0);
    acc[i][j] =new Vec2(0,0);
    oldVel[i][j] =new Vec2(0,0);
    broken[i][j] = false;
    }
  }
}

void update(float dt){
 
  //speed = prevPos.distanceTo(spherePos);
  
  
  for(int i=0; i<numNodes; i++){
   for(int j=0; j<numNodes; j++){
     oldVel[i][j]=vel[i][j];
   }
  }

for (int i = 0; i < numNodes-1; i++){ 
    for (int j = 0; j < numNodes; j++){ 
      Vec2 e=ball[i+1][j].minus(ball[i][j]);
      float l=e.length();
      if(l<maxDis&&broken[i][j]==false){
      Vec2 n=e.normalized();
      float v1=dot(e,vel[i][j]);
      float v2=dot(e,vel[i+1][j]);
      float f=-ks*(10-l)-kd*(v1-v2);
      oldVel[i][j].add(n.times(f).times(dt));
      oldVel[i+1][j].subtract(n.times(f).times(dt));
      }
      else{
        broken[i][j]=true;
      }
    }
  }


  for (int i = 0; i < numNodes; i++){ 
    for (int j = 0; j < numNodes-1; j++){ 
      Vec2 e=ball[i][j+1].minus(ball[i][j]);
      float l=e.length();
      if(l<maxDis&&broken[i][j]==false){
      Vec2 n=e.normalized();
      float v1=dot(e,vel[i][j]);
      float v2=dot(e,vel[i][j+1]);
      float f=-ks*(10-l)-kd*(v1-v2);
      oldVel[i][j].add(n.times(f).times(dt));
      oldVel[i][j].add(oldVel[i][j].times(-kf));
      oldVel[i][j+1].subtract(n.times(f).times(dt));
      }
      else{
         broken[i][j]=true;
      }
    }
  }
 
 
 for (int i = 0; i < numNodes-1; i++){ 
    for (int j = 0; j < numNodes-1; j++){ 
      Vec2 e=ball[i+1][j+1].minus(ball[i][j]);
      float l=e.length();
       if(l>maxDis){
        broken[i][j]=true;
       }
      }
    }
 
 
 

 
  
  

  for (int i = 0; i < numNodes; i++){ 
    for (int j = 0; j < numNodes; j++){ 
      oldVel[i][j].y+=gravity*dt;
    }
  }
    for (int i = 0; i < numNodes; i++){ 
      oldVel[i][0]=new Vec2(0,0);
    }
  
  for(int i=0; i<numNodes; i++){
   for(int j=0; j<numNodes; j++){
     vel[i][j]=oldVel[i][j];
   }
  }
  
  for(int i=0; i<numNodes; i++){
   for(int j=0; j<numNodes; j++){
     ball[i][j].add(vel[i][j].times(dt));
   }
  }
  
  
   for (int i = 0; i < numNodes; i++){
     for(int j=0; j<numNodes; j++){
    if (ball[i][j].y+radius > floor){
      vel[i][j].y *= -.9;
      ball[i][j].y = floor - radius;
    }
  }
 }
  
  
  
  for (int i = 0; i < numNodes; i++){ 
    for (int j = 0; j < numNodes; j++){ 
     float d=spherePos.distanceTo(ball[i][j]);
     if(d<sphereR+.09){
       Vec2 e=(spherePos.minus(ball[i][j])).times(-1);
       Vec2 n=e.normalized();
       Vec2 bounce=n.times(dot(vel[i][j],n));
       vel[i][j].subtract(bounce.times(1.5));
       ball[i][j].add(n.times(0.1+sphereR-d));
     }
    }
  }
  //prevPos=new Vec2(spherePos.x, spherePos.y);
    Vec2 rVel = new Vec2(0,0);
  if (leftPressed) rVel.add(new Vec2(-80,0));
  if (rightPressed) rVel.add(new Vec2(80,0));
  if (upPressed) rVel.add(new Vec2(0,-80));
  if (downPressed) rVel.add(new Vec2(0,80));
  spherePos.add(rVel.times(dt));
  
}

boolean leftPressed, rightPressed, upPressed, downPressed;
void keyPressed(){
  if (keyCode == LEFT) leftPressed = true; 
  if (keyCode == RIGHT) rightPressed = true; 
  if (keyCode == UP) upPressed = true;  
  if (keyCode == DOWN) downPressed = true;
}

void keyReleased(){
  if (keyCode == LEFT) leftPressed = false; 
  if (keyCode == RIGHT) rightPressed = false; 
  if (keyCode == UP) upPressed = false; 
  if (keyCode == DOWN) downPressed = false;  

}






//Draw the scene: one sphere per mass, one line connecting each pair
void draw() {
  background(255,255,255);
  for(int i=0; i<30; i+=1) {
    update(1/(30*frameRate));
  }
  fill(120,120,0);
    circle(spherePos.x, spherePos.y,sphereR*2);
  
  //for (int i = 0; i < numNodes-1; i++){
  //  for(int j = 0; j<numNodes-1; j++){
  //  pushMatrix();
  //  line(ball[i][j].x,ball[i][j].y,ball[i][j+1].x,ball[i][j+1].y);
  //  line(ball[i][j].x,ball[i][j].y,ball[i+1][j].x,ball[i+1][j].y);
  //  translate(ball[i][j+1].x,ball[i][j+1].y);
  //  sphere(radius);
  //  popMatrix();
  //  }
  // pushMatrix();
  // line(ball[numNodes-1][i].x,ball[numNodes-1][i].y,ball[numNodes-1][i+1].x,ball[numNodes-1][i+1].y);
  // line(ball[i][numNodes-1].x,ball[i][numNodes-1].y,ball[i+1][numNodes-1].x,ball[i+1][numNodes-1].y);
  // popMatrix();
  //}

  
boolean colorchange=true;  
  
  for (int i = 0; i < numNodes-1; i++){
    for(int j = 0; j<numNodes-1; j++){
   
    if(colorchange==true){
    fill(0,255,255);
    colorchange=false;
    }else{
    fill(255,255,0);
    colorchange=true;
    }
    if(broken[i][j]==false){
    beginShape();
    vertex(ball[i][j].x, ball[i][j].y);
    vertex(ball[i][j+1].x,ball[i][j+1].y);
    vertex(ball[i+1][j+1].x,ball[i+1][j+1].y);
    vertex(ball[i+1][j].x,ball[i+1][j].y);
    endShape();
    }
    }
  }
  
  
  //pushMatrix();
  //fill(0,255,0);
  // specular(0, 0, 255);  //Setup lights… 
  //ambientLight(90,90,90);   //More light…
  //lightSpecular(255,255,255); shininess(20);  //More light…
  //directionalLight(200, 200, 200, -1, 1, -1); //More light…
  //  translate(spherePos.x, spherePos.y); sphere(sphereR*2);   //Draw sphere
 
  
  //popMatrix();
}
