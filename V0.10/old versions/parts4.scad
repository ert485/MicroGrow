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

leg(s=s,k=k,baseX=90,baseY=40,lip=8,rows=3,backX=20,baseA=61.5,notchY=11);
translate([60,0]) rotate(90) brace(s=s,k=k,x=165,w=25,zip=0);
translate([135,0]) rotate(90) shelf(x=220,w=58/2);