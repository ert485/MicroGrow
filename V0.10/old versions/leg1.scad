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


module leg(angle=10,rows=4,wide=60,deep=6,lip=10,backX=30,baseX=110,baseY=20,s=3,k=0.4,notchX=10,notchY=15){

//calculate total height:
	between=60+sin(angle)*wide+lip;
	tall=baseY+(rows-1)*between+sin(angle)*wide+lip+deep;
	echo(tall);

//base
	base(baseX,baseY);

//rows
	for(i=[0:rows-1]){
		translate([0,baseY+i*between]) row(angle,wide,deep,lip);
	}
//back
	back(backX,tall,notchX,notchY,s,k);

}

module base(X,Y){
	difference(){
		translate([-X,0]) square([X,Y]);
		translate([-X,0]) rotate(45) square(X*2);
	}
}

module row(a,w,d,l){
	translate([-cos(a)*w-sin(a)*d-l,0])
	difference(){
		union(){
			square([l,l+cos(a)*d]);
			translate([l,0]) square([sin(a)*d+cos(a)*w,w]);
		}
		translate([l,l+cos(a)*d])rotate(a)translate([0,-d]) square(w*2);
	}
}

module back(w,t,x,y,s,k){
	difference(){
		square([w,t]);	
		translate([w-x,y]) square([x,s-k/2]);
		translate([w-x,t-y]) square([x,s-k/2]);
	}
}

leg();


