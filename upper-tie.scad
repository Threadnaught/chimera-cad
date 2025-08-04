include<constants.scad>

thickness=5;

module upper_tie(){
    flat_section() intersection(){
        difference(){
            offset(rounding)offset(-rounding)square([upper_tie_width,upper_tie_height], center=true);
            for(y=[-1:2:1])for(x=[-1:2:1])scale([x,y])
                translate([upper_tie_extrusion_bolt_dist/2,upper_tie_extrusion_bolt_space/2])
                    circle(d=upper_tie_extrusion_bolt_dia);
            
            for(y=[-1:2:1])for(x=[-1:2:1])scale([x,y])
                translate([upper_tie_external_bolt_dist/2,upper_tie_external_bolt_space/2])union(){
                    circle(d=upper_tie_external_bolt_dia);
                    translate([40,0])circle(d=upper_tie_external_bolt_dia);
                }
                    
        }
        *translate([45,-50,0])cube(100);
    }

}