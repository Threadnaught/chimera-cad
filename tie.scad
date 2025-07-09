$fn=24;

width=150;
height=60;
rounding=5;

extrusion_width=30;

extrusion_bolt_dia=6.05;
extrusion_bolt_dist=width-extrusion_width;
extrusion_bolt_space=height-25;

external_bolt_dia=3.05;
external_bolt_dist=40;
external_bolt_space=height-30;

intersection(){
    //linear_extrude(5)
    difference(){
        offset(rounding)offset(-rounding)square([width,height], center=true);
        for(y=[-1:2:1])for(x=[-1:2:1])scale([x,y])
            translate([extrusion_bolt_dist/2,extrusion_bolt_space/2])
                circle(d=extrusion_bolt_dia);
        
        for(y=[-1:2:1])for(x=[-1:2:1])scale([x,y])
            translate([external_bolt_dist/2,external_bolt_space/2])
                circle(d=external_bolt_dia);
    }
    *translate([45,-50,0])cube(100);
}