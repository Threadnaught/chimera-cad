$fn=24;

for(x=[0:25:25*3])for(y=[0:25:25*4])translate([x,y])difference(){
	circle(d=20);
	circle(d=7);
}