include<constants.scad>

$fn = 16;

// coords traced out of image
module spine_plate(){
	difference(){
		translate([0,0,rounding])hull(){
			for(x=[-1:2:1])scale([x,1]){
				translate([-73,90])sphere(d=rounding);
				translate([-94,32])sphere(d=rounding);
				translate([-94,-40])sphere(d=rounding);
				translate([-52,-91])sphere(d=rounding);
				translate([-52,91])sphere(d=rounding);

				translate([0,0,plate_mid_height]){
					translate([-52,91])sphere(d=rounding);
				}
				
				translate([0,0,plate_top_height]){
					translate([-52,32])sphere(d=rounding);
					translate([-52,-40])sphere(d=rounding);
				}
			}
		}

		for(x=[-1:2:1])for(y=[-1:2:1])scale([x,y])
			translate([plate_extrusion_bolt_dist/2-40,50]){
				translate([0,0,-1])cylinder(d=m6_bolt_dia_fine,h=40);
				translate([0,0,5])cylinder(d=15,h=40);
			}

		for(x=[-1:2:1])for(y=[-1:2:1])scale([x,y])
			translate([25,25]){
				translate([0,0,-1])cylinder(d=m6_bolt_dia_fine,h=40);
				translate([0,0,-1])cylinder(d=17.5,h=15);
			}
	}

}

spine_plate();