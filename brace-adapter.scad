include<constants.scad>
use<sweep-extrude.scad>


// Reference positions (dialed in by hand):
module brace_adapter_refs(){
	*union(){
		translate(upper_position)sphere(d=z1_bolt_dia);
		translate(lower_position)rotate([90,0,0])sphere(d=z1_bolt_dia);
		translate(angling_start_lower)sphere(d=z1_bolt_dia);
		translate(angling_start_upper)sphere(d=z1_bolt_dia);
		translate(upper_above_lower_position)sphere(d=z1_bolt_dia);
		translate(lower_below_upper_position)sphere(d=z1_bolt_dia);
	}
}


module brace_adapter_top(){
	difference(){
		hull(){
			translate(angling_start_upper)linear_extrude(20)square([25,25],center=true);
			translate(angling_start_upper)
				sweep_extrude(
					lower_below_upper_position-angling_start_upper,
					angling_start_lower-angling_start_upper,
					$fn,30
				) square(25,center=true);
		}

		union(){
			translate(angling_start_upper)rotate_towards(angling_start_lower-angling_start_upper){
				translate([0,0,15])linear_extrude(15.1)square([21,21],center=true);
				translate([0,0,9.9])cylinder(d=m6_bolt_dia_coarse,h=7.7);

				translate([0,0,2.5]){
					cylinder(d=13,h=7.5);
					sphere(d=14);
					rotate([0,135,-90])cylinder(d=12,h=30);
				}
			}
			translate(upper_position-[0,0,10]){
				translate([0,0,-2])cylinder(d=m6_bolt_dia_coarse,h=12.1);
				hull(){
					translate([0,-2,0])cylinder(d=10.5,h=5.5);
					translate([0,20,0])cylinder(d=10.5,h=5.5);
				}
			}
		}

		
	}
}

module brace_adapter_bottom(){
	difference(){
		union(){
			hull(){
				translate(lower_position+[7.5,0,-20])linear_extrude(70)square([15,30],center=true);
				translate(angling_start_lower)
					sweep_extrude(
						upper_above_lower_position-angling_start_lower,
						angling_start_upper-angling_start_lower,
						$fn,30
					) square(25,center=true);
			}
			
		}
		
		union(){
			translate(angling_start_lower)rotate_towards(angling_start_upper-angling_start_lower){
				// translate([0,0,15])linear_extrude(15.1)square([21,21],center=true);
				translate([0,0,15])linear_extrude(15.1)square([21,21],center=true);
				translate([0,0,9.9])cylinder(d=m6_bolt_dia_coarse,h=7.7);

				translate([0,0,2.5]){
					cylinder(d=13,h=7.5);
					sphere(d=14);
					rotate([0,135,180+90])cylinder(d=12,h=30);
				}

				*%translate([0,0,15])linear_extrude(brace_length)square([20,20],center=true);
			}

			for(z=[-20:20:0])translate(lower_position+[0,0,z]){
				translate([-1,0,10])rotate([0,90,0])cylinder(d=m6_bolt_dia_coarse,h=30);
				translate([5,0,10])rotate([0,90,0])cylinder(d=15,h=25);
			}
		}
	}
}

module brace(){
	translate(angling_start_lower)rotate_towards(angling_start_upper-angling_start_lower){
		translate([0,0,15])linear_extrude(brace_length)square([20,20],center=true);
	}
}