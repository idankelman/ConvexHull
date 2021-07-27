
/* @pjs font="data/font.ttf"; */
    
/* @pjs preload="data/wave.png"; */
	


ArrayList<Point> points;
ArrayList<Point> convex;
ArrayList<Button> Buttons;
int sizer;
float rad= 6;
Point curr; 
Point max;
float angle1;
float angle2;
int spot=1;
boolean stop= false;
int save= 0;
float Text_size=15;
float Text_size2=40;
float Text_size3=10;
float fpser=50;

PFont Font;
PImage wave ;

int newsize=10;

//buttons;

Button size1_btn;
Button size2_btn;
Button reset_btn;
Button slow_btn;

//initiallizing vars
//----------------------------------------------------------------------------------------------------------------------------------
void setup()
{
  size(2000, 2500);
   //createCanvas(windowWidth, windowHeight);
   //size(windowWidth, windowHeight);
  
  wave= loadImage("data/wave.png");
  Font= loadFont("data/font.tff");
  textFont(Font);
  Text_size=width/50;
  Text_size2=Text_size*2;
  Text_size3=Text_size2/3;
  //wave = image(wave,width,width);
    
   reset() 
  
}

void draw()
{
  background(38, 40, 43);
  
  imageMode(CENTER);
  tint(220, 90, 170,220);
  image(wave,width/2,height-height/14,width+width/4,height/3);
  //draw all points  

  for (int i=0; i<points.size(); i++)
    points.get(i).show();
  //each time increase the i of the function

  //draw all the previous found lines

  for (int i =0; i<convex.size()-1; i++)
  {
    convex.get(i).show2(convex.get(i+1));
  }
  convex.get(convex.size()-1).show2(convex.get(0));

  //and draw the current line that im checking
  

  if (!stop)
  {
    rad=rad*2;
    curr.show(80, 30, 255);
    rad=rad/2;
    calcConvex();
  }

  //curr.show2(max);




  //draw buttons

  for (int i =0; i<Buttons.size(); i++)
    Buttons.get(i).show();


  beginShape();
  fill(62, 39, 135, 90);
  //tint(255,7);
  for (int i =0; i<convex.size(); i++)
  {
    Point temp = convex.get(i);
    vertex(temp.x, temp.y);
  }
  endShape(CLOSE);
  noFill();
  noTint();
  fill(255);  

  textSize(Text_size);
  String text1 = "Press On The Reset Button To Restart";
  String text2= "Convex Hull - Idan Kelman-(gift Wrapping)-O(n^2)";
  String text3="the number of points in the convex hull: "+convex.size();
  String text4="the curr point ("+(int)curr.x+","+(int)curr.y+")";
  text(text1, width/2-text1.length()*Text_size/4, height/20);
  text(text2, width/2-text2.length()*Text_size/4, height/20+Text_size*2);
  textSize(Text_size3);
  text(text3, width/6-text3.length()*Text_size3/4, height/20+Text_size3*8);
  text(text4, width/6-text4.length()*Text_size3/4, height/20+Text_size3*10);

textSize(Text_size2);
  fill(255);
  if (stop==true)
    text("Done", width/2-5*Text_size2/4, height/2);
}





void calcConvex()
{  
  if (spot==sizer)
  {
    if (curr.angle(points.get(save))>0)
    {
      stop=true;
      max.mark=2;
      return;
    }

    spot = 0;
    curr=max;
    convex.add(curr);
    //max=points.get(spot);
    // angle1=curr.angle(max);
    boolean add=false;

    for (int i =0; i<points.size(); i++)
    {
      Point temp1 = points.get(i);
      if (temp1.mark==2)
        temp1.mark=0;


      if (add==false&&curr.equal(temp1)==false)
      {
        max=temp1;
        angle1=curr.angle(max);
        add=true;
        println("next");
      }
    }
  }

  //each itteration , search for the next in line point , and calc its angle , save the most greatest angle as mark=1;

  //if found better , swap

  Point temp = points.get(spot);
  if (curr.equal(temp)||temp.mark==1)//if were checking the same dot with itself;
  {

    if (curr.angle(temp)>0)
    {
      max.mark=2;
      curr.mark=1;
      save= spot;
      spot++;
      return;
    }

    if (temp.mark==1)
    {
      spot++;
      return;
    }
    //Point finish = new Point();
    //finish.x= temp.x;
    //finish.y=temp.y;
    //finish.mark=1;
    //convex.add(finish);
  }

  angle2= curr.angle(temp);

  println(spot);
  println(angle1, angle2);


  if (angle2>0)
  {
    //mark max red 
    max.mark=2;

    //mark temp as green
    temp.mark=1;

    //max = temp
    max=temp;

    //update the angle
    angle1=angle2;
  } else
    temp.mark=2;

  curr.show2(temp);
  spot++;
}

void mousePressed()
{
  //add points to change sizer amount
  if (size1_btn.Pressed())
  {
    size_40();
    return;
  }
  if (size2_btn.Pressed())
  {
    size_100();
    return;
  }
  if (reset_btn.Pressed())
  {
    reset();
    return;
  }
  if (slow_btn.Pressed())
  {
    fps();
    return;
  }


  //else retstrt
}

void CreateButtons()
{


  Buttons = new ArrayList<Button>();

  String Btn1= "10 verts";
  String Btn2="30 verts";
  String Btn3="Reset";
  String Btn4="Change Speed";
  float  spacer = 200;

  size1_btn = new Button(width/6-Text_size3*8, height/10+Text_size3 +spacer);
  size2_btn=new Button(width/6-Text_size3*8, height/10+Text_size3 +spacer*2);
  reset_btn= new Button(width/6-Text_size3*8, height/10+Text_size3 +spacer*3);
  slow_btn=new Button(width/6-Text_size3*8, height/10+Text_size3 +spacer*4);

  size1_btn.Color(191, 150, 99);
  size1_btn.Text(Btn1);
  Buttons.add(size1_btn);

  size2_btn.Color(242, 195, 167);
  size2_btn.Text(Btn2);
  Buttons.add(size2_btn);

  reset_btn.Color(16, 45, 64);
  reset_btn.Text(Btn3);
  Buttons.add(reset_btn);

  slow_btn.Color(191, 94, 59);
  slow_btn.Text(Btn4);
  Buttons.add(slow_btn);
}


void size_40()
{
  newsize=10;
}
void size_100()
{
  newsize=30;
}
void reset()
{
  stop=false;
  spot=1;
  save=0;
  angle1=-MAX_INT;
  angle2=-MAX_INT;
  max=null;
  curr=null;



  CreateButtons();


  textSize(Text_size);
  sizer=newsize;
  
  //generate points
  float minX=width/2;
  points = new ArrayList<Point>();
  convex = new ArrayList<Point>();
  for (int i=0; i<sizer; i++)
  {
    Point temp = new Point();
    if (temp.x <= minX)
    {
      curr = temp; 
      minX=curr.x;
    } 
    points.add(temp);
  }
  curr.mark=1;
  convex.add(curr);

  max= points.get(0);

  //creating the vars for first itteration
  if (max.equal(curr)==true)
    max= points.get(1);


  max.mark=1;
  //angle1= curr.angle(max);


  //add them to a arraylist  
}
void fps()
{
  frameRate(fpser);
  fpser=fpser-5;
  if (fpser==0)
    fpser=50;
}











class Button
{
  float roundness=30;
  float x;
  float y;
  float w=width/7;
  float h=height/20;
  color c;
  
  float size_btn;
  String text_btn;

  public Button(float x, float y)
  {
    this.x= x;
    this.y= y;
    
    
  }
  public void Color(float r, float g, float b)
  {
    this.c = color(r,g,b);
    
  }
  
  public void Text(String s)
  {
    this.text_btn=s;
    //this.size_btn=w/s.length();
    this.size_btn=width/70;
  }

  public boolean Pressed()
  {
    if (mouseX<=this.x+ w&&mouseX>=this.x)
      if (mouseY<=this.y+h&&mouseY>=this.y)
        return true;

    return false;
  }
  
  public void show()
  {
    fill(54,53,54);
    rect(this.x,this.y,w,h,roundness);
    if(text_btn==null) 
      return;
    fill(255);
    textSize(this.size_btn);
    text(text_btn,this.x+this.size_btn,y+h/2);
    fill(202, 68, 122);
    textSize(size_btn*2);
    text(char(223),this.x+w-size_btn*2,y+h/2);
      
      
    
    
  }
}


class Point
{
  float x;
  float y;
  int mark = 0;

  public Point()
  {
    this.x = random(0+150, width-150);
    this.y = random(0+150, height-150);
  }

  public float angle(Point b) //<>// //<>// //<>//
  {

    // PVector A = new PVector (this.x, this.y);
    // PVector B = new PVector (b.x, b.y);
    // float dist = PVector.dist(A, B);
    // float angle;
    // float Dx;

    // if (this.x>b.x)
    //    Dx=this.x-b.x;
    // else
    //    Dx=b.x-this.x;

    //  angle = degrees(acos(Dx/dist));  

    //PVector C = A.cross(A);

    //angle=degrees(PVector.angleBetween(A,B));


    //   if((this.x<b.x&&this.y<b.y)||this.x>b.x&&this.y<b.y)
    //     angle=90-angle;

    //   return angle;

    PVector temp1  = new PVector(max.x, max.y);
    PVector temp2  = new PVector(this.x, this.y);
    PVector temp3  = new PVector(b.x, b.y);
    PVector A = PVector.sub(temp2, temp1);
    PVector B= PVector.sub(temp3,temp1);
    PVector C= A.cross(B);
    
    float z = C.z;
    return z;
  }

  public void show(float r, float g , float b)
  {
    
   fill(r,g,b); 
   ellipse(x,y,rad,rad); 
  }

  public void show()
  {
    if (mark==0)//new point
      fill(255);
    if (mark==1)//discovered point
      fill(202, 68, 122);
    if (mark==2)//checked but not in the hull
      fill(219, 46, 46);
    ellipse(x, y, rad,rad);
  }

  public void show2(Point b)
  {
    show();
    stroke(255);
    line(this.x, this.y, b.x, b.y);
    noStroke();
  }

  public boolean equal(Point b)
  {
    if (this.x==b.x&&this.y==b.y)
      return true;
    return false;
  }
}
