$fn=24;

// Utility modules:
// Create a 2D pie slice
module pie_slice(angle, r){
	polygon([
		[0,0],
		for (i=[0:$fn])[sin(angle*i/$fn)*r,cos(angle*i/$fn)*r]
	]);
}

// Bent sheet metal modules:
// Create a flat section
module flat_section(){
	if(lie_flat){
		children();
	} else {
		linear_extrude(thickness)children();
	}
}

// Create a bent section
module stepped_bend(total_angle=90,width=100,neutral_radius=20,steps=4){
	if(lie_flat){
		//If we're flat, approximated staged bends to a circle and calculate width
		total_extension_length = neutral_radius*PI*2*(total_angle/360);
		echo("Bend section length:", total_extension_length/steps);
		color("blue")square([width,total_extension_length]);
		translate([0,total_extension_length])children();
	} else {
		//If we're bent upwards, construct the staged bend using an extruded polygon, and then place the downstream shapes in the right place
		angles = [for (i=[0:steps]) total_angle*i/steps];
		inside_radius = neutral_radius-(thickness/2);
		outside_radius = neutral_radius+(thickness/2);
		color("blue")translate([0,0,neutral_radius+thickness/2])rotate([0,90,0])linear_extrude(width)intersection(){
			polygon([
				for (angle=angles)[cos(angle) * outside_radius, sin(angle) * outside_radius],
				for (i=[steps:-1:0])[cos(angles[i]) * inside_radius, sin(angles[i]) * inside_radius]
			]);
		}
		// This fun little trick moves the piece such that the centre of rotation aligns with the centre of the curve, moves the following section, then flips it back.
		translate([0,0,outside_radius])rotate([total_angle,0,0])translate([0,0,-outside_radius])
		children();
	}
}



// General Constants:
lie_flat=false;
m6_bolt_dia_fine=6.05;
m6_bolt_dia_coarse=6.5;
m5_bolt_dia_coarse=5.5;
extrusion_width=30;

// Arm Mount / Support strut constants:
tie_bolt_inner_from_center = 20;
tie_bolt_space_x=40;
tie_bolt_space_y=55;

z1_bolt_space=60;
z1_bolt_dia=6.5;

inter_z1_spacing=400;

plate_margin=10;
plate_size_lower_x=tie_bolt_space_x+(plate_margin*2);
plate_size_y=tie_bolt_space_y+(plate_margin*2);

z1_mounting_margin=20;
rounding=5;

strut_initial_lateral_angle=17.5;

strut_first_lateral_angle=0;
strut_first_bend_angle=20.3;

outer_strut_mid_len=172;
inner_strut_mid_len=outer_strut_mid_len-1.3;

strut_second_lateral_angle=72;
strut_second_bend_angle=84;

outer_second_bend_radius=20;
inner_second_bend_radius=20-3.5;

strut_final_angle=20;

// Upper tie:
upper_tie_width=150+80;
upper_tie_height=80;

upper_tie_extrusion_bolt_dist=upper_tie_width-extrusion_width;
upper_tie_extrusion_bolt_space=upper_tie_height-25;

upper_tie_external_bolt_dist=40;
upper_tie_external_bolt_space=upper_tie_height-25;

// Lower tie:
lower_tie_width=150;
lower_tie_height=100;

lower_tie_extrusion_bolt_dist=lower_tie_width-extrusion_width;
lower_tie_extrusion_bolt_space=lower_tie_height-25;

lower_tie_external_bolt_dist=70;
lower_tie_external_bolt_space=lower_tie_height-25;

//Spine plate
// TODO: measure this IRL
plate_top_height = 25;
plate_mid_height = 10;

plate_extrusion_bolt_dist=200;