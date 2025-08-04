include<constants.scad>
use<arm-mount.scad>
use<upper-tie.scad>
use<lower-tie.scad>
use<spine-plate.scad>

$fn = 24; // TODO: why oh WHY does this not work???

rotate([90,0,0]){
	for(x=[-1:2:1])scale([x,1]){
		//color("red"){
			translate([60,10,3.25])support_strut(outer=true);
			translate([60,10,6.75])support_strut(outer=false);
		//}

		//color("blue"){
			arm_mount();
			arm_mount(extra_radius=8.5);
		//}

	}

	//color("yellow") {
		translate([0,37.5,-5.25])upper_tie();
		translate([0,-400,-8])lower_tie();
	//}

	color("grey")for(x=[-1:2:1])scale([x,-1])translate([upper_tie_extrusion_bolt_dist/2-40,180,-8.5-extrusion_width/2])cube([extrusion_width,550,extrusion_width],center=true);

	// TODO: vertical positioning of this is a total guess in CAD
	translate([0,-300,-extrusion_width-6.75])scale([1,1,-1])spine_plate();
}