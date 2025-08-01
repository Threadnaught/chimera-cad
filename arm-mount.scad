use<upper-tie.scad>

$fn=24;

tie_height=80;
thickness=3;
lie_flat=false;

tie_bolt_inner_from_center = 20;
tie_bolt_dia=6.05;
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
strut_first_bend_angle=21.2;

strut_mid_len=176;

strut_second_lateral_angle=72;
strut_second_bend_angle=84;

module pie_slice(angle, r){
	polygon([
		[0,0],
		for (i=[0:$fn])[sin(angle*i/$fn)*r,cos(angle*i/$fn)*r]
	]);
}

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

module flat_section(){
	if(lie_flat){
		children();
	} else {
		linear_extrude(thickness)children();
	}
}

// TODO: this scad needs a bit of cleanup loooool
module arm_mount(extra_radius=0){
	translate([0,0,-extra_radius]){
		flat_section()translate([tie_bolt_inner_from_center-plate_margin,0])difference(){
			union(){
				offset(rounding)offset(-rounding)
				difference(){
					square([plate_margin+(inter_z1_spacing+z1_bolt_space)/2,plate_size_y]);
					translate([plate_margin+(inter_z1_spacing+z1_bolt_space)/2-110,0])square([110,30]);
				}
				translate([plate_margin+(inter_z1_spacing+z1_bolt_space)/2-rounding,plate_size_y-rounding])
					square(rounding);
			}
			
			for(x=[0:tie_bolt_space_x:tie_bolt_space_x*2])for(y=[0:tie_bolt_space_y:tie_bolt_space_y])
				translate([x+plate_margin,y+plate_margin])circle(d=tie_bolt_dia);

			for(x=[0:z1_bolt_space:z1_bolt_space])
			translate([x+(inter_z1_spacing-z1_bolt_space-z1_mounting_margin)/2,plate_size_y-z1_mounting_margin])
			
			circle(d=z1_bolt_dia);
		}

		translate([(inter_z1_spacing-z1_bolt_space)/2-z1_mounting_margin,plate_size_y])stepped_bend(neutral_radius=20+extra_radius){
			flat_section()difference(){
				union(){
					offset(rounding)offset(-rounding)square([100,z1_bolt_space+(z1_mounting_margin*2)]);
					square([100,50]);
				}
				for(x=[0:z1_bolt_space:z1_bolt_space]) for(y=[0:z1_bolt_space:z1_bolt_space])translate([x+z1_mounting_margin,y+z1_mounting_margin])circle(d=z1_bolt_dia);
			}
		}
	}
	
}

%arm_mount();
arm_mount(extra_radius=8.5);
// *translate([280,290])rotate(180)
// arm_mount();


translate([0,37.5,-5])linear_extrude(5)upper_tie();


module support_strut(){
	rotate(strut_initial_lateral_angle){
		flat_section()difference(){
			union(){
				circle(d=20);
				translate([5,0])square([10,20],center=true);
			}
			circle(d=tie_bolt_dia);
		}
		translate([0,10])rotate(-90)translate([0,10])rotate(strut_first_lateral_angle)stepped_bend(total_angle=strut_first_bend_angle,width=20,steps=2){
			flat_section()
			square([20,strut_mid_len]);
			
			translate([0,strut_mid_len]){
				flat_section()rotate(strut_second_lateral_angle-90)pie_slice(strut_second_lateral_angle,20);
				rotate(strut_second_lateral_angle)stepped_bend(total_angle=strut_second_bend_angle,width=20,steps=4){
					flat_section()difference(){
						union(){
							translate([10,5])square([20,10],center=true);
							translate([10,10])circle(d=20);
						}
						translate([10,10])circle(d=z1_bolt_dia);
					}
				}
			}
		}
	}

}
translate([60,10,3.25])support_strut();