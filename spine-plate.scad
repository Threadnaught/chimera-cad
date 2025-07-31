$fn = 16;
rounding = 2.5;

// TODO: measure this IRL
top_height = 25;
mid_height = 10;



// coords traced out of image
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