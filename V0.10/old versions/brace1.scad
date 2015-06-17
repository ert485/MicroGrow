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
module brace(x=250,w=6,n=10,s=3,k=0.4){
	difference(){
		square([x+s*2+w*2,n*2]);
		translate([w,n])square([s-k/2,n]);
		translate([w+s+x,n])square([s-k/2,n]);
	}
}

brace();