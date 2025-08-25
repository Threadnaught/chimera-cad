include<constants.scad>
$fn=24;

thickness=5;
proto_board_wid = 55;
proto_board_hei = 75;

pi_wid = 49;
pi_hei = 58;

imu_space = 20;

module electronics_mount(){
    flat_section()intersection(){
        difference(){
            // Main body:
            translate([-35,0])offset(rounding)offset(-rounding)square([lower_tie_width+70,lower_tie_height], center=true);
            for(y=[-1:2:1])for(x=[-1:2:1])scale([x,y])
                translate([lower_tie_extrusion_bolt_dist/2,lower_tie_extrusion_bolt_space/2])
                    circle(d=m6_bolt_dia_coarse+0.1);
            // Proto board:
            translate([-10,0])for(x=[-1:2:1])for(y=[-1:2:1])scale([x,y])translate([proto_board_wid/2,proto_board_hei/2])circle(d=3.5);
            // Pi:
            translate([-110,10])for(x=[-1:2:1])for(y=[-1:2:1])scale([x,y])translate([pi_wid/2,pi_hei/2])circle(d=3.5);
            // IMU:
            translate([35,-25])for(y=[-1:2:1])scale([1,y])translate([0,imu_space/2])circle(d=3.5);
            
        }
    }
}

