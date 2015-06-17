rowW=70;
rowH=100;
rowL=400;
w=17;
k=.43;
rows=4;
echo(rows);

//tabs
tabW=3;
tabL=8;

//light
lightW=17;
lightH=10;



module tab1(){
translate([0,w]) square([tabW,tabL]);
translate([0,w+rowH/2-tabL/2]) square([tabW,tabL]);
translate([0,rowH+w-tabL]) square([tabW,tabL]);
}
module tab2(){
translate([0,w]) square([tabW-k,tabL-k]);
translate([0,w+rowH/2-tabL/2]) square([tabW-k,tabL-k]);
translate([0,rowH+w-tabL]) square([tabW-k,tabL-k]);
}


difference(){
	square([rowL-2*w,rowH+w]);
	for(i=[0:rows-1]){
		translate([w*(1+i)+rowW*i,w]) square([rowW,rowH]);
	}
}
mirror([1,0,0])tab1();
translate([rowL-2*w,0])tab1();

difference(){
	translate([0,w+rowH]) square([rowL-2*w,w*2+lightH]);
	translate([0,w+rowH]) for(i=[0:rows-1]){
		translate([w*(1+i)+rowW/2+rowW*i-lightW/2,w]) square([lightW,lightH]);
	}
}


translate([0,180]){
	difference(){
		square([rowL+2*w,rowH+w+w*2+lightH]);
		translate([w,0]) tab2();
		translate([rowL+w-tabW,0]) tab2();
	}
}


//testing pieces
translate([0,-40]){
square(17);
translate([-tabW,5])square([tabW,tabL]);
translate([20,0])
difference(){
square([tabW+16,tabL+16]);
translate([8,8])square([tabW-k,tabL-k]);
}
}