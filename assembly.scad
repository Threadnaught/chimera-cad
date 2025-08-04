use<arm-mount.scad>
use<upper-tie.scad>

$fn = 24;

for(x=[-1:2:1])scale([x,1]){
	color("red"){
		translate([60,10,3.25])support_strut(outer=true);
		translate([60,10,6.75])support_strut(outer=false);
	}

	color("blue"){
		arm_mount();
		arm_mount(extra_radius=8.5);
	}
}

color("yellow") translate([0,37.5,-5])linear_extrude(5)upper_tie();