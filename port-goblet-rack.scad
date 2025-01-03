include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>

$fn = 50;

module screw_holes() {
    difference() {
        children();
        zspread(spacing = 80, n = 2, l = 120, sp = [0, 0, 20]) {
            xspread(spacing = 67, n = 2, l = 80, sp = [6.5, 0, 0]) {
                metric_bolt(
                    size = 4, 
                    headtype = "countersunk", 
                    l = 16,
                    coarse = true, 
                    pitch = 0, 
                    orient = ORIENT_YNEG,
                    align = "sunken"
                );
            }
        }
    }
}

module alignment_pegs() {
    move([6.5, 7.5, 120]) zcyl(l = 10, d = 5);
    difference() {
        children();
        move([73.5, 7.5, 120]) zcyl(l = 10, d = 5);
    }
}

module part(rear = false) {
    alignment_pegs() {
        screw_holes() {
            linear_extrude(height = 120) {
                polygon(
                    points = [
                        [0, 0], [0, 15], // left side
                        [80, 15], // top
                        [80, 0], // right side
                        [52, 0], // bottom right
                        [52, 2], // right lower inner vertical
                        [67, 7], // right inner incline
                        [67, 11], // right upper inner vertical
                        [13, 11], // inner top
                        [13, 7], // left upper inner vertical 
                        [28, 2], // left inner incline
                        [28, 0] // left lower inner vertical
                    ]
                );
            }
        }
    }

    if (rear) {
        cube(size = [80, 15, 2]);
    }
}

render() move([0, 125, 15]) xrot(180) orient_and_align(size = [120, 170, 15], orient = ORIENT_X) {
    xdistribute(sizes = [80, 80]) {
        part(rear = false);
        part(rear = true);
    }
}