include<constants.scad>


module imu_band_hook(){
	rotate([90,0,180])difference(){
		rotate([0,-90,0])linear_extrude(20,center=true,convexity=4)difference(){
			square(40,center=true);
			square(30,center=true);
			translate([15,10])square([30,50],center=true);
		}
		translate([0,0,10])rotate([90,0,0])cylinder(d=m6_bolt_dia_coarse,h=50,center=true);
	}
}