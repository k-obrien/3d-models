include <BOSL/constants.scad>
use <BOSL/transforms.scad>
use <BOSL/shapes.scad>
use <BOSL/metric_screws.scad>

$fn = 50;

module screw_holes() {
    difference() {
        children();
        zspread(spacing = 87, n = 2, l = 174, sp = [0, 0, 43.5]) {
            xspread(spacing = 93, l = 106, sp = [6.5, 0, 0]) {
                metric_bolt(
                    size = 4, 
                    headtype = "countersunk", 
                    l = 26,
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
    move([6.5, 11.5, 174]) zcyl(l = 10, d = 5);
    difference() {
        children();
        move([99.5, 11.5, 174]) zcyl(l = 10, d = 5);
    }
}

module part(rear = false) {
    alignment_pegs() {
        screw_holes() {
            linear_extrude(height = 174) {
                polygon(
                    points = [
                        [0, 0], [0, 26], // left side
                        [106, 26], // top
                        [106, 0], // right side
                        [82, 0], // bottom right
                        [82, 2], // right lower inner vertical
                        [93, 21], // right inner incline
                        [93, 23], // right upper inner vertical
                        [13, 23], // inner top
                        [13, 21], // left upper inner vertical 
                        [24, 2], // left inner incline
                        [24, 0] // left lower inner vertical
                    ]
                );
            }
        }
    }

    if (rear) {
        cube(size = [106, 26, 2]);
    }
}

render() move([0, 164, 26]) xrot(180) orient_and_align(size = [174, 116, 26], orient = ORIENT_X) {
    xdistribute(sizes = [106, 106]) {
        part(rear = false);
        part(rear = true);
    }
}
