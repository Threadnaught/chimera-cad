include<constants.scad>
use<sweep-extrude.scad>


upper_position = [(inter_z1_spacing+z1_bolt_space)/2,101.5,93.5];
lower_position = [(lower_tie_extrusion_bolt_dist+extrusion_width)/2,-(extrusion_width/2)-8.5,-300];

angling_start_lower = lower_position+[15,0,30];
angling_start_upper = upper_position-[0,0,20];

upper_above_lower_position = [angling_start_lower[0],angling_start_lower[1],angling_start_upper[2]];
lower_below_upper_position = [angling_start_upper[0],angling_start_upper[1],angling_start_lower[2]];

module brace_adapter_top(){
	// Reference positions (dialed in by hand):
	*union(){
		translate(upper_position)sphere(d=z1_bolt_dia);
		translate(lower_position)rotate([90,0,0])sphere(d=z1_bolt_dia);
		translate(angling_start_lower)sphere(d=z1_bolt_dia);
		translate(upper_above_lower_position)sphere(d=z1_bolt_dia);
		translate(angling_start_upper)sphere(d=z1_bolt_dia);
	}
	hull(){
		translate(lower_position+[7.5,0,0])linear_extrude(50)square([15,30],center=true);
		translate(angling_start_lower)
			sweep_extrude(
				upper_above_lower_position-angling_start_lower,
				upper_position-angling_start_lower,
				$fn,30
			) square(25,center=true);
	}
}

module brace_adapter_bottom(){
	hull(){
		translate(angling_start_upper)linear_extrude(20)square([25,25],center=true);
		translate(angling_start_upper)
			sweep_extrude(
				lower_below_upper_position-angling_start_upper,
				lower_position-angling_start_upper,
				$fn,30
			) square(25,center=true);
	}
}