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


module brace(x=250,w=6,n=10,s=3,k=0,zip=4,zipL=70,zipX=2.5,zipY=0){
	difference(){
		square([x+w*2,n*2]);
		translate([w-s/2,n])square([s,n]);
		translate([x+w-s/2,n])square([s,n]);
	}
	translate([0,n*2]) rotate(-90) ziptie(zip,zipL,zipX,zipY);
}

module ziptie(z,l,x,y,t){
	if(z!=0){
		translate([-y,l]) square([y,x]);
		translate([-y,l+x+z]) square([y,x]);
		translate([-y,l+l]) square([y,x]);
		translate([-y,l+l+x+z]) square([y,x]);
	}
}


brace();