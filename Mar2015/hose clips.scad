hoseOD=6;
flex=1.5;
arcCut=30;
n=30;


difference(){
	union(){
		circle(hoseOD/2+flex,$fn=n);
		translate([-12,-8])square([24,8]);
	}	
	circle(hoseOD/2,$fn=n);
	CutArc();

	translate([-8,-4])circle(3/2,$fn=n);
	translate([8,-4])circle(3/2,$fn=n);
	ring(hoseOD/2+flex,hoseOD/2+flex+.1,10);
}


module CutArc(r=hoseOD*2,a=arcCut){
	polygon(points=[[0,0],[-sin(a)*r,cos(a)*r],[sin(a)*r,cos(a)*r]]);
}
module ring(r1=1,r2=1.1,a=0){
	difference(){
		circle(r2,$fn=n);
		circle(r1,$fn=n);
		rotate(180)CutArc(a);
	}
}

translate([30,0]){


difference(){
	union(){
		circle(hoseOD/2+flex,$fn=n);
		translate([-8,-10])square([16,10]);
		
	}	
	circle(hoseOD/2,$fn=n);
	CutArc();
	ring(hoseOD/2+flex,hoseOD/2+flex+.1,10);
	translate([-2,-10])square([0.1,2.5]);
	translate([2,-10])square([0.1,2.5]);
	translate([-0.8,-10])square([1.6,4]);
	translate([0,-6.5])circle(1.2,$fn=n);
}


}