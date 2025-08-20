imu_space = 20;
$fn = 24;

// Actual IMU:
%difference(){
	square([16,27],center=true);
	translate([5.5,0])for(y=[-1:2:1])scale([1,y])translate([0,imu_space/2])circle(d=3.5);
}

linear_extrude(3)difference(){
	
	translate([-1,0])square([25,35],center=true);

	for(y=[-1:2:1])scale([1,y])for(x=[-9:4:9])translate([x,15.5])circle(d=2.5);

	// Screwholes:
	translate([5.5,0])for(y=[-1:2:1])scale([1,y])translate([0,imu_space/2])circle(d=3.5);

	// Strain relief:
	translate([-10,0])for(y=[-1:2:1])scale([1,y])translate([0,5])circle(d=3.5);
}