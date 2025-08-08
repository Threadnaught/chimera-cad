include<constants.scad>

thickness=5;

bolt_space=(inter_z1_spacing-z1_bolt_space)/2;
outer_d = 12.5;

module strut(){
	flat_section(){
		difference(){
			hull(){

				translate([-bolt_space,0])circle(d=outer_d);
				translate([bolt_space,0])circle(d=outer_d);
			}
			translate([-bolt_space,0])circle(d=z1_bolt_dia);
			translate([0,0])circle(d=z1_bolt_dia);
			translate([20,0])circle(d=z1_bolt_dia);
			translate([-20,0])circle(d=z1_bolt_dia);
			translate([bolt_space,0])circle(d=z1_bolt_dia);
		}
	}
}