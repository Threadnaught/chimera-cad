use<upper-tie.scad>
include<constants.scad>

thickness=3;

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
				translate([x+plate_margin,y+plate_margin])circle(d=m6_bolt_dia_fine);

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


module support_strut(outer=true){
	mid_len = outer ? outer_strut_mid_len : inner_strut_mid_len;
	second_bend_radius = outer ? outer_second_bend_radius : inner_second_bend_radius;
	rotate(strut_initial_lateral_angle){
		flat_section()difference(){
			union(){
				circle(d=20);
				translate([5,0])square([10,20],center=true);
			}
			circle(d=m6_bolt_dia_fine);
		}
		translate([0,10])rotate(-90)translate([0,10])rotate(strut_first_lateral_angle)stepped_bend(total_angle=strut_first_bend_angle,width=20,steps=2){
			flat_section()
			square([20,mid_len]);
			
			translate([0,mid_len]){
				flat_section()rotate(strut_second_lateral_angle-90)pie_slice(strut_second_lateral_angle,20);
				rotate(strut_second_lateral_angle)stepped_bend(total_angle=strut_second_bend_angle,width=20,steps=4,neutral_radius=second_bend_radius){
					flat_section(){
						
						translate([20,0]){
							rotate(90)pie_slice(strut_final_angle,20);
							rotate(-strut_final_angle)translate([-20,0])difference(){
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
	}

}
