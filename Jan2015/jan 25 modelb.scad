s1=3-0.2;  //thickness of sheet 1

laserK=.075;  
/*laser Kerf
used for:
	tabs
*/

t1=4;
/*tolerance #1
distance to edge of various things
used in:
	light holder
*/

t2=5;
/*
distance to edge of various things
used in:
	front wall vs side wall
	
*/

module circle1(r){		//circle but with different algorithm for # of sides
	circle(r,$fn=r*10);
} 	



//OVERALL DIMENSIONS:
Width=470;
Depth=150;
Height1=t2;
Height2=Height1+80;
Height3=Height2+80;



//TABS:
tabOut=s1;
tabWide=15;
tabOnCenter=60;


module makeTabs(l=100){
	for(i=[0:tabOnCenter:l/2-tabWide/2]){
		translate([i,tabOut/2]) square([tabWide+laserK*2,tabOut],center=true);
		translate([-i,tabOut/2]) square([tabWide+laserK*2,tabOut],center=true);
	}
	//translate([0,10]) square([l,3],center=true); //test comparison
}
module makeTabHoles(l=100){
	for(i=[0:tabOnCenter:l/2-tabWide/2]){
		translate([i,s1/2]) square([tabWide-laserK*2,s1-laserK*2],center=true);
		translate([-i,s1/2]) square([tabWide-laserK*2,s1-laserK*2],center=true);
	}
	//translate([0,10]) square([l,3],center=true); //test comparison
}


//LIGHT HOLDER:

LHW=14.4;
LHdW=1.2;
LHH=6.85;

lightWide=LHW+t1*2;
lightTall=350-Height3;

lightHole=[[-LHW/2+LHdW/2,-LHH/2],[-LHW/2,LHH/2],[LHW/2,LHH/2],[LHW/2-LHdW/2,-LHH/2]];

module lightHolder(){
	translate([-lightWide/2,0]) difference(){
		square([lightWide,lightTall]);
		translate([lightWide/2,lightTall-t1-LHH/2]) polygon(lightHole);
	}
}

//SIDE:

SW=Depth+t2*2+s1*2;
SH=Height3;

module side(){
	difference(){
		square([SW,SH]);
		translate([SW/2,Height1]) makeTabHoles(Depth);
		translate([SW/2,Height2]) makeTabHoles(Depth);
		translate([t2,SH/2]) rotate(-90) makeTabHoles(SH);
		translate([SW-t2,SH/2]) rotate(90) makeTabHoles(SH);
	}
	translate([SW/2,SH]) lightHolder();
}

//BOTTOMS:

BW=Width;
BH=Depth;

pumpWire=1.8;
PWx=15;
PWy=15;
pumpHole=3.2;
PHx=15;
PHy=15;
drainHole=.5;
DHx=15;
DHy=DHx;

cornerCut=6;
module cc(){
	rotate(-45)square([cornerCut*10,cornerCut*2],center=true);
}

p3=40;
p3h=40;
module bottom(piece=1){
	if (piece==3){
		difference(){
			union(){
				square([BW-p3,BH-p3]);
				translate([BW/2-p3/2,0]) rotate(180) makeTabs(Width-p3);
				translate([BW/2-p3/2,BH-p3]) makeTabs(Width-p3);
				translate([0,BH/2-p3/2]) rotate(90) makeTabs(Depth-p3);
				translate([BW-p3,BH/2-p3/2]) rotate(-90) makeTabs(Depth-p3);				
			}	
			translate([PHx,PHy]) circle1(pumpHole);
			translate([PWx,BH-p3-PWy]) circle1(pumpWire);
		}
		translate([-s1-t2,BH-p3+10]) difference(){
			square([BW-p3+s1*2+t2*2,t2+s1+p3h]);
			translate([(BW-p3+s1*2+t2*2)/2,t2]) makeTabHoles(BW-p3+s1*2+t2*2);
			translate([BW-p3+s1+t2,p3h/2]) rotate(-90) makeTabHoles(p3h);
			translate([t2+s1,(t2+s1+p3h)/2]) rotate(90) makeTabHoles(p3h);
		}	
		translate([0,BH-p3+20+p3h]) difference(){
			union(){
				square([BH-p3,t2+s1+p3h]);
				translate([0,(t2+s1+p3h)/2]) rotate(90) makeTabs(t2+s1+p3h);
				translate([(BH-p3),(t2+s1+p3h)/2]) rotate(-90) makeTabs(t2+s1+p3h);
			}
			translate([(BH-p3)/2,t2]) makeTabHoles(BH-p3);

		}			
	}
	
	else {
		difference(){
			union(){
				square([BW,BH]);
				if (piece==1){
					translate([BW/2,0]) rotate(180) makeTabs(Width);
					translate([BW/2,BH]) makeTabs(Width);
					translate([0,BH/2]) rotate(90) makeTabs(Depth);
					translate([BW,BH/2]) rotate(-90) makeTabs(Depth);
				}
			}
			if (piece==2){
				translate([PHx,PHy]) circle1(pumpHole);
				translate([PWx,BH-PWy]) circle1(pumpWire);
				cc();
				translate([0,BH]) rotate(90) cc();
				translate([BW,0]) rotate(270) cc();
				translate([BW,BH]) rotate(180) cc();
			}
		}
	}
	
}

//FRONT:

FW=Width;
FH=Height3;

module front(){
	difference(){
		union(){
			square([FW,FH]);
			translate([0,FH/2]) rotate(90) makeTabs(Depth);
			translate([FW,FH/2]) rotate(-90) makeTabs(Depth);
		}
		translate([FW/2,Height1]) makeTabHoles(Width);
		translate([FW/2,Height2]) makeTabHoles(Width);
	}
}



module test(){
	//lightHolder();
	//makeTabs();
	//makeTabHoles();
	//side();
	//bottom(2);
	//front();
}
module fitTest(){
	front();
	translate([0,Height3*1.1]) bottom(2);
	translate([Width*1.05,0]) side();
	rotate(90) translate([Height3*1.1-t2-s1,20]) side();
}
module cutTest(){
	TWidth=40;
	difference(){
		square([LHW*2,LHH*2],center=true);
		polygon(lightHole);
	}
	translate([LHW*2,0]) square([TWidth,t2]);
	translate([LHW*2+TWidth/2,t2]) makeTabs(TWidth);
	difference(){
		translate([LHW*2+TWidth*1.1,0]) square([TWidth+pumpHole*3+pumpWire*3,t1*2+s1]);
		translate([LHW*2+TWidth*1.6,t1]) makeTabHoles(40);
		translate([LHW*2+TWidth*2.1,t1+s1/2]) circle1(pumpHole);
		translate([LHW*2+TWidth*2.1+pumpHole*3,t1+s1/2]) circle1(pumpWire);
	}
	translate([0,-30]) difference() {
		square(20);
		cc();
	}
}
module cut(){
	front();
	translate([0,Height3*1.1]) front();
	translate([Width*1.05,0]) side();
	translate([Width*1.05+Depth*1.2,0]) side();
	translate([Width*1.05+Depth*2.4,0]) bottom(1);
	translate([Width*1.05+Depth*2.4,Height3*1.1]) bottom(3);
}


//test();
//fitTest();
//cutTest();
cut();