$fn = 16;
rounding = 2.5;

// TODO: measure this IRL
top_height = 25;
mid_height = 10;

bolt_hole_dia=6.5;

extrusion_height=200;
extrusion_width=30;
extrusion_bolt_dist=200;

// coords traced out of image
difference(){
	translate([0,0,rounding])hull(){
		for(x=[-1:2:1])scale([x,1]){
			translate([-73,90])sphere(r=rounding);
			translate([-94,32])sphere(r=rounding);
			translate([-94,-40])sphere(r=rounding);
			translate([-52,-91])sphere(r=rounding);
			translate([-52,91])sphere(r=rounding);

			translate([0,0,mid_height]){
				translate([-52,91])sphere(r=rounding);
			}
			
			translate([0,0,top_height]){
				translate([-52,32])sphere(r=rounding);
				translate([-52,-40])sphere(r=rounding);
			}
		}
	}

	for(x=[-1:2:1])for(y=[-1:2:1])scale([x,y])
		translate([extrusion_bolt_dist/2-40,50]){
			translate([0,0,-1])cylinder(d=bolt_hole_dia,h=40);
			translate([0,0,5])cylinder(d=15,h=40);
		}

	for(x=[-1:2:1])for(y=[-1:2:1])scale([x,y])
		translate([25,25]){
			translate([0,0,-1])cylinder(d=bolt_hole_dia,h=40);
			translate([0,0,-1])cylinder(d=17.5,h=15);
		}
}

%for(x=[-1:2:1])scale([x,-1])translate([extrusion_bolt_dist/2-40,0,-extrusion_width/2])cube([extrusion_width,extrusion_height,extrusion_width],center=true);