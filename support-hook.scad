include<constants.scad>

thickness=5;

x_bolt_space=20;
centroid_height=100;
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
			translate([-x_bolt_space,centroid_height])circle(d=m6_bolt_dia_fine);
			translate([x_bolt_space,centroid_height])circle(d=m6_bolt_dia_fine);
		}
	}
}