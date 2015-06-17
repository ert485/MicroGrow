t=.006;
l=420;
w=60;
h=40;

square([l,w]);
translate([-t-h,0])square([h,w]);
translate([0,w+t])square([l,h]);
translate([l+t,0])square([h,w]);
translate([0,-h-t])square([l,h]);