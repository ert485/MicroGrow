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

module leg(angle=0,rows=4,wide=60,deep=10,lip=40,backX=15,baseX=75,baseY=17,s=3,k=0,notchX=10,notchY=8.5,baseA=30,zip=0,zipL=70,zipX=2.5,zipY=1,edge=0,hook=[[-2,6.5],[-1.2,6.8],[0,4.5],[0,0]]){
echo(deep+hook[0][1]);
//calculate total height:
	between=lip*2;
	tall=baseY+(rows-1)*between+sin(angle)*wide+lip+deep+hook[0][1]-lip;
	echo(tall);





//rows
	difference(){
		for(i=[0:rows-1]){
			translate([0,i*between-lip+baseY]) row(angle,wide,deep,lip,edge,hook);
		}
		rotate(180)square(lip*2);
	}
//back
	back(backX,tall,notchX,notchY,s,k);

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




leg();


