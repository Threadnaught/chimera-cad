include<constants.scad>

thickness=5;
centroid_height=110;

x_bolt_space=20;
bolt_hole_diff=10-m6_bolt_dia_fine;
hook_hole_space=x_bolt_space-bolt_hole_diff;


outer_d=20;

module support_hook(){
	flat_section(){
		difference(){
			hull(){
				translate([-x_bolt_space,0])circle(d=outer_d);
				translate([x_bolt_space,0])circle(d=outer_d);
				translate([-x_bolt_space,centroid_height])circle(d=outer_d);
				translate([x_bolt_space,centroid_height])circle(d=outer_d);
			}
			translate([-x_bolt_space,0])circle(d=m6_bolt_dia_fine);
			translate([x_bolt_space,0])circle(d=m6_bolt_dia_fine);

			translate([-x_bolt_space,centroid_height/2])circle(d=m6_bolt_dia_fine);
			translate([x_bolt_space,centroid_height/2])circle(d=m6_bolt_dia_fine);
			
			translate([-hook_hole_space,centroid_height])circle(d=10);
			translate([hook_hole_space,centroid_height])circle(d=10);
			translate([0,centroid_height])circle(d=10);
			
		}
	}
}