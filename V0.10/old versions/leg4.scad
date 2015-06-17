/* 
Copyright 2015 Erik Tetland

	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/


module leg(angle=10,rows=4,wide=60,deep=10,lip=10,backX=30,baseX=110,baseY=20,s=3,k=0.4,notchX=10,notchY=15,baseA=30,zip=0,zipL=70,zipX=2.5,zipY=1,edge=0,hook=[[-2,7],[-1,7],[0,4],[0,0]]){

//calculate total height:
	between=60+sin(angle)*wide+lip;
	tall=baseY+(rows-1)*between+sin(angle)*wide+lip+deep+hook[0][1];
	echo(tall);

//base
	base(baseX,baseY,baseA);

//ziptie holder
	ziptie(zip,zipL,zipX,zipY);


//rows
	for(i=[0:rows-1]){
		translate([0,baseY+i*between]) row(angle,wide,deep,lip,edge,hook);
	}
//back
	back(backX,tall,notchX,notchY,s,k);

}

module base(X,Y,A){
	difference(){
		translate([-X,0]) square([X,Y]);
		translate([-X,0]) rotate(A) square(X*2);
	}
}

module row(a,w,d,l,e,h){
	translate([-cos(a)*w-sin(a)*d-l,0]){
		difference(){
			union(){
				square([l,l+cos(a)*d]);
				translate([l,0]) square([sin(a)*d+cos(a)*w,w]);
		}
			translate([l,l+cos(a)*d])rotate(a)translate([0,-d]) square(w*2);
			if(e==0) square([l+sin(a)*d,100]);
		}
	translate([l+sin(a)*d+cos(a)*w,l+sin(a)*w+d])polygon(h);
	}
}

module back(w,t,x,y,s,k){
	difference(){
		square([w,t]);	
		translate([w-y,0]) square([s-k/2,x]);
		translate([w-y,t-x]) square([s-k/2,x]);
	}
}

module ziptie(z,l,x,y){
	if(z!=0){
		translate([-y,l]) square([y,x]);
		translate([-y,l+x+z]) square([y,x]);
		translate([-y,l+l]) square([y,x]);
		translate([-y,l+l+x+z]) square([y,x]);
	}
}



leg();


