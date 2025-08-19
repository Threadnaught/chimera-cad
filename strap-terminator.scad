include<constants.scad>

$fn = 24;


module strap_terminator(){
	difference(){
		union(){
			cube([10,40,30],center=true);
			for(s=[-1:2:1])scale([1,s,1])translate([10,16.25,10])cube([10,7.5,10],center=true);
	
			*%cube([30,25,10],center=true);
			translate([15,0,10])rotate([90,0,0])cylinder(d=10,h=40,center=true);
		}
		for(s=[-1:2:1])scale([1,s,1])translate([0,8,0]){
			rotate([0,90,0])cylinder(d=m6_bolt_dia_coarse,h=11,center=true);
			rotate([0,90,0])cylinder(d=13.5,h=11);
		}
	}
}
