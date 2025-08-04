include<constants.scad>

thickness=5;

module upper_tie(){
    flat_section() intersection(){
        difference(){
            // Main body:
            offset(rounding)offset(-rounding)square([upper_tie_width,upper_tie_height], center=true);
            
            // Screwholes:
            for(y=[-1:2:1])for(x=[-1:2:1])scale([x,y])
                translate([upper_tie_extrusion_bolt_dist/2,upper_tie_extrusion_bolt_space/2])
                    circle(d=m6_bolt_dia_fine);
            for(y=[-1:2:1])for(x=[-1:2:1])scale([x,y])
                translate([upper_tie_external_bolt_dist/2,upper_tie_external_bolt_space/2])union(){
                    circle(d=m6_bolt_dia_fine);
                    translate([40,0])circle(d=m6_bolt_dia_fine);
                }
                    
        }
    }
}