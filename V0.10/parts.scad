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
k=0;
hook=[[-3.3,12],[-2.2,12],[-.1,6],[0,6],[0,0]];

//base leg
leg(s=s,k=k,baseY=22,lip=40,rows=3,backX=15,baseA=61.5,notchY=8.5,hook=hook);

//brace
translate([60,0]) rotate(90) brace(s=s,k=k,x=165,w=(204-165)/2,zip=0);

//shelf
translate([140,0]) rotate(90) shelf(x=204,w=54,h=10,t=.006,hookX=165,hookY=5.5,hookT=3);

//brace for stacking
translate([180,0]) rotate(90) brace(s=s,k=k,x=165,w=25,zip=0);
translate([180,0]) rotate(90) mirror([0,1,0]) brace(s=s,k=k,x=165,w=25,zip=0);

//stacking leg 
translate([-120,0]) leg(s=s,k=k,baseX=0.0001,baseY=40,lip=8,rows=3,backX=20,baseA=61.5,notchY=11,hook=hook);