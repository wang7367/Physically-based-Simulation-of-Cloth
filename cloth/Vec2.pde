//Vector Library [2D]
//CSCI 5611 Vector 2 Library [Solution]

//Instructions: Implement all of the following vector operations--

public class Vec2 {
  public float x, y;
  
  public Vec2(float x, float y){
    this.x=x;
    this.y=y;
  }
  
  public String toString(){
    return "(" + x+ ", " + y +")";
  }
   
  
  public float length(){
    return sqrt(x*x+y*y);
  }
  
  public Vec2 plus(Vec2 rhs){
    return new Vec2(rhs.x+x,rhs.y+y);
  }
  
  public void add(Vec2 rhs){
    x+=rhs.x;
    y+=rhs.y;
  }
  
  public Vec2 minus(Vec2 rhs){
    return new Vec2(x-rhs.x,y-rhs.y);
  }
  
  public void subtract(Vec2 rhs){
    x -=rhs.x;
    y -=rhs.y;
  }
  
   public Vec2 times(float rhs){
    return new Vec2(x*rhs, y*rhs);
  }
  
  public void mul(float rhs){
    x *=rhs;
    y *=rhs;
  }
  
  public void normalize(){
    float magnitude = sqrt(x*x + y*y);
    x /= magnitude;
    y /= magnitude;
  }
  
  public Vec2 normalized(){
    float magnitude = sqrt(x*x + y*y);
    return new Vec2(x/magnitude, y/magnitude);
  }
  
  public float distanceTo(Vec2 rhs){
    float dx=rhs.x-x;
    float dy=rhs.y-y;
    return sqrt(dx*dx+dy*dy);
  }
  
}

Vec2 interpolate(Vec2 a, Vec2 b, float t){
  return a.plus((b.minus(a)).times(t));
}

float interpolate(float a, float b, float t){
  return a + ((b-a)*t);
}

float dot(Vec2 a, Vec2 b){
  return a.x*b.x+a.y*b.y;
}

Vec2 projAB(Vec2 a, Vec2 b){
  return b.times(a.x*b.x+a.y*b.y);
}
