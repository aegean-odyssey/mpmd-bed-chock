/* MONOPRICE MP MINI DELTA, BED CHOCK
   small "chock" prevents the print bed from tilting while printing
   (see https://github.com/aegean-odyssey/mpmd-bed-chock/)
*/
/* 
Copyright (c) 2020 Aegean Associates, Inc. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted (subject to the limitations in the disclaimer
below) provided that the following conditions are met:

     * Redistributions of source code must retain the above copyright notice,
     this list of conditions and the following disclaimer.

     * Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in the
     documentation and/or other materials provided with the distribution.

     * Neither the name of the copyright holder nor the names of its
     contributors may be used to endorse or promote products derived from this
     software without specific prior written permission.

NO EXPRESS OR IMPLIED LICENSES TO ANY PARTY'S PATENT RIGHTS ARE GRANTED BY
THIS LICENSE. THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/   

/* 3D PRINTING
   layer height:        0.050mm
   first layer height:  0.200mm
   perimiters:          3
   bottom solid layers: 10
   top solid layers:    15
   fill density:        25%
*/
   
/* HOW TO USE
   After the printer performs its initial calibration "bed taps",
   gently slide the three (3) chocks in place under the bed at each
   of the switches. This should prevent the bed from tilting.
*/

module chock() {

    N = 12;     // number of steps
    r = 0.05;   // rise of each step
    d = 0.75;   // step depth
    h = 2.6;    // step height (1st)
    w = 16.0;   // step width
    u = 8.0;    // cutout
    t = 3.0;    // post offset
    f = h+r*N;  // final height

    module blank() {
        $fn = 60;  // arc smoothing
        e = 0.01;  // tiny "nudge" bit
        module co() { cylinder(d=w, h=f+2*e); }
        module ci() { cylinder(d=u, h=f+3*e); }
        difference() {
            y = t + d*N;
            translate([0, 0, -2*e/2])
            hull() { co(); translate([0, y]) co(); }
            translate([0, 0, -3*e/2])
            hull() { ci(); translate([0, y]) ci(); }

        }
    }
 
    module wedge() {
        for (i=[0:N-1], o=d*i, z=h+r*i)
            translate([-w/2, o]) cube([w, d, z]);
        translate([-w/2, d*N]) cube([w, t+w/2, f]);
    }

    intersection() {
        wedge();
        blank();
    }
}

chock();
