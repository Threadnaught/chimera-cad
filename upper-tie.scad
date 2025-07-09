$fn=24;

width=150;
height=80;
rounding=5;

extrusion_width=30;

extrusion_bolt_dia=6.05;
extrusion_bolt_dist=width-extrusion_width;
extrusion_bolt_space=height-25;

external_bolt_dia=6.05;
external_bolt_dist=40;
external_bolt_space=height-25;

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
%for(x=[-1:2:1])scale([x,-1])translate([extrusion_bolt_dist/2,0,-extrusion_width/2])cube([extrusion_width,height,extrusion_width],center=true);