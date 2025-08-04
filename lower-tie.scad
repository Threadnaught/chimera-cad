include<constants.scad>
$fn=24;

thickness=5;


module lower_tie(){
    flat_section()intersection(){
        //linear_extrude(5)
        difference(){
            offset(rounding)offset(-rounding)square([lower_tie_width,lower_tie_height], center=true);
            for(y=[-1:2:1])for(x=[-1:2:1])scale([x,y])
                translate([lower_tie_extrusion_bolt_dist/2,lower_tie_extrusion_bolt_space/2])
                    circle(d=m6_bolt_dia_fine);

            offset(rounding)offset(-rounding)polygon([[lower_tie_width/2-20,lower_tie_height/2-25],[lower_tie_width/2-20,-lower_tie_height/2+25],[10,0]]);
            offset(rounding)offset(-rounding)polygon([[-lower_tie_width/2+20,lower_tie_height/2-25],[-lower_tie_width/2+20,-lower_tie_height/2+25],[-10,0]]);
            offset(rounding)offset(-rounding)polygon([[lower_tie_width/2-25,lower_tie_height/2-20],[-lower_tie_width/2+25,lower_tie_height/2-20],[0,10]]);
            offset(rounding)offset(-rounding)polygon([[lower_tie_width/2-25,-lower_tie_height/2+20],[-lower_tie_width/2+25,-lower_tie_height/2+20],[0,-10]]);


            for(x=[-1:2:1])scale([x,-1])
                translate([lower_tie_external_bolt_dist/2,lower_tie_external_bolt_space/2])
                    circle(d=m6_bolt_dia_fine);
            translate([0,lower_tie_external_bolt_space/2])circle(d=m6_bolt_dia_fine);
        }
        *translate([45,-50,0])cube(100);
    }
}
%for(x=[-1:2:1])scale([x,-1])translate([lower_tie_extrusion_bolt_dist/2,0,-extrusion_width/2])cube([extrusion_width,lower_tie_height,extrusion_width],center=true);
