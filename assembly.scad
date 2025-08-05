include<constants.scad>
use<arm-mount.scad>
use<upper-tie.scad>
use<lower-tie.scad>
use<spine-plate.scad>
use<brace-adapter.scad>

rotate([0,0,0]){
	for(x=[-1:2:1])scale([x,1]){
		// The mounts themselves, adapt the extrusion to arms
		%arm_mount();
		arm_mount(extra_radius=8.5);

		// Support struts mounted to the underside of the arm mounts. Didn't demonstrate a great ability to improve rigidity.
		*translate([60,10,3.25])support_strut(outer=true);
		*translate([60,10,6.75])support_strut(outer=false);

		rotate([90,0,180]){
			brace_adapter_top();
			brace_adapter_bottom();
		}

	}

	// Upper and lower ties. Provide mounting points for hardware and tie the extrusions together.
	translate([0,37.5,-5.25])upper_tie();
	translate([0,-400,-8])lower_tie();
	
	// Spine plate. Conforms to the back and allows the whole assembly to rest on the back comfortably-ish
	// TODO: vertical positioning of this is a total guess in CAD
	*translate([0,-300,-extrusion_width-6.75])scale([1,1,-1])spine_plate();

	// Extrusions which form the spine of the system.
	%for(x=[-1:2:1])scale([x,-1])translate([upper_tie_extrusion_bolt_dist/2-40,180,-8.5-extrusion_width/2])cube([extrusion_width,550,extrusion_width],center=true);
}