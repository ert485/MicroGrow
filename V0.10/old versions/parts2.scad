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

use<leg.scad>;
use<brace.scad>;
use<shelf.scad>;

s=2.75;
k=0.4;


leg(s=s,k=k,baseX=100,baseY=30,rows=3,backX=25);
translate([60,0]) rotate(90) brace(s=s,k=k,x=200);
translate([135,0]) rotate(90) shelf(x=300);