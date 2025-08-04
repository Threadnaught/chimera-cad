$fn=24;

module rotate_towards(pointing){
	rotate([0,0,atan2(pointing[1], pointing[0])])
	rotate([0,atan2(norm([pointing[1], pointing[0]]), pointing[2]),0])
	children();
}

// // Demo of rotate towards
// for(x=[0:10]){
// 	pointing = [0,x,15];

// 	translate(pointing) sphere(d=0.5);

// 	translate([0,0,x])%rotate_towards(pointing-[0,0,x])
// 	cylinder(d=1,h=15);
// }

module sweep_extrude(start_target,end_target,steps,height){
	for(i=[0:steps-1]){
		i_bump = i + 0.01;
		progress_pre = i_bump/steps;
		progress_post = (i_bump+1)/steps;

		target_pre = start_target + ((end_target - start_target) * progress_pre);
		target_post = start_target + ((end_target - start_target) * progress_post);
		
		// Debug shapes:
		*union(){
			% rotate_towards(target_pre) translate([0,0,height * progress_pre]) cylinder(h=30,d=0.5);
			% rotate_towards(target_post) translate([0,0,height * progress_post]) cylinder(h=30,d=0.5);

			translate(target_pre) sphere(d=0.5);
			translate(target_post) sphere(d=0.5);
		}

		hull(){
			rotate_towards(target_pre) translate([0,0,height * progress_pre])  linear_extrude(0.01) children();
			 rotate_towards(target_post) translate([0,0,height * progress_post]) linear_extrude(0.01) children();
		}
		// rotate_towards()
	}
}

sweep_extrude([0,0,20],[20,20,20],10,10)difference(){circle(5);};