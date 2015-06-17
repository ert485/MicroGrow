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

module shelf(x=350,w=58,h=10,t=.006,hookX=165,hookY=5.5,hookT=3){
	square([x,w]);
	translate([0,-t-h])square([x,h]);
	translate([0,w+t])square([x,h]);
	translate([x/2-hookX/2,w+t+h]){
		hook(hookY,hookT);
	}
	translate([x/2+hookX/2,w+t+h]){
		hook(hookY,hookT);
	}
}
shelf();


module hook(y,t){
	difference(){
		translate([-(3.1+t*2)/2,0]) square([3.1+t*2,y+t]);
		translate([-3.1/2,0])square([3.1,y]);
	}

}