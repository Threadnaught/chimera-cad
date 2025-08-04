include<constants.scad>
$fn=24;

thickness=5;

module lower_tie(){
    flat_section()intersection(){
        difference(){
            // Main body:
            offset(rounding)offset(-rounding)square([lower_tie_width,lower_tie_height], center=true);
            for(y=[-1:2:1])for(x=[-1:2:1])scale([x,y])
                translate([lower_tie_extrusion_bolt_dist/2,lower_tie_extrusion_bolt_space/2])
                    circle(d=m6_bolt_dia_fine);

            //Cutouts:
            offset(rounding)offset(-rounding)
                for(s=[-1:2:1])scale([s,s]){
                    polygon([[lower_tie_width/2-20,lower_tie_height/2-25],[lower_tie_width/2-20,-lower_tie_height/2+25],[10,0]]);
                    polygon([[lower_tie_width/2-25,lower_tie_height/2-20],[-lower_tie_width/2+25,lower_tie_height/2-20],[0,10]]);
                }
            
            //Screwholes:
            for(x=[-1:2:1])scale([x,-1])
                translate([lower_tie_external_bolt_dist/2,lower_tie_external_bolt_space/2])
                    circle(d=m6_bolt_dia_fine);
            translate([0,lower_tie_external_bolt_space/2])circle(d=m6_bolt_dia_fine);
        }
    }
}

