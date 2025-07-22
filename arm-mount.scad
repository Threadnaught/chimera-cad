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

module stepped_bend(width=100,neutral_radius=20,steps=4){
	if(lie_flat){
		echo("Bend section length:");
		echo(neutral_radius*PI/(2*steps));
		color("blue")square([width,neutral_radius*PI/2]);
		translate([0,neutral_radius*PI/2])children();
	} else {
		color("blue")translate([0,0,neutral_radius+thickness/2])rotate([0,90,0])linear_extrude(width)intersection(){
			difference(){
				circle(r=neutral_radius+thickness/2,$fn=steps*4);
				circle(r=neutral_radius-thickness/2,$fn=steps*4);
			}
			square(neutral_radius+thickness);
		}
		translate([0,neutral_radius+thickness/2,neutral_radius+thickness/2])rotate([90,0,0])children();
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
arm_mount();
arm_mount(extra_radius=8.5);
*translate([280,290])rotate(180)
arm_mount();


%translate([0,37.5,-5.25])linear_extrude(5)upper_tie();