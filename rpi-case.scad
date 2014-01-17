// RPi board
use <R-Pi/R-Pi.scad>
module rpi() {
  translate([-1,-1,0])
  rotate(a=[0,0,-90])
  translate([-85,0,0])
  pi();
}

// Display
module display() {
// RPi video connector protrudes 13.5mm off the board,
// give it some room. Also center it on the RPi board.
translate([5.05, 0, 29.6]) {
  // LCD
  color("Black")
    translate([0, 49, -2.5])
      cube([46, 40.9, 2.5]);
  // Driver board
  translate([0, 0, -5]) {
  color("LightGreen")
    difference() {
      cube([47.4, 32, 1.63]);
      // Drill holes
      translate([2.5, 2, -1])
        cylinder(h=3, r=1.5, $fn=50);
      translate([47.4 - 2.5, 2, -1])
        cylinder(h=3, r=1.5, $fn=50);
      translate([2.5, 32 - 2, -1])
        cylinder(h=3, r=1.5, $fn=50);
      translate([47.4 - 2.5, 32 - 2, -1])
        cylinder(h=3, r=1.5, $fn=50);
    }
  // Power+Video connector
  color("Silver")
    translate([0.5, 27.6 - 10, 1.63])
      cube([6, 10, 4.65]);
  }
}
}

// Voltage Converter
module voltageconverter() {
translate([-8, -25, 24.6]) {
translate([48.4, 0, 1.16]) {
rotate(a=[0,180,0]) {
  color("DarkGreen")
    difference() {
      cube([48.4, 23, 1.16]);
      // Drill holes
      translate([40.58805, 3.15, -1])
        cylinder(h=5, r=1.45, $fn=50, center=true);
      translate([7.75, 19.95, -1])
        cylinder(h=5, r=1.45, $fn=50, center=true);
    }
}
}
}
}

// Power jack
module power() {
  color("Black")
  union() {
    cube([14, 8, 11]);
    translate([-2.5, -2, -1])
      cube([2.5, 12.0, 13]);
    translate([1.45, -2, 3])
      cube([9.05, 2, 5]);
    translate([1.45, 8, 3])
      cube([9.05, 2, 5]);
  }
}

module power_jack() {
  translate([67.5, -10, -5])
    rotate(a=[0, 0, 180])
      power();
}

module mountingpost(r, center) {
  difference() {
    cylinder(h=5, r=r, $fn=50, center=center);
    translate([0, 0, -1])
      cylinder(h=8, r=2.9/2.0, $fn=50, center=center);
  }
}

// Case Back
module back() {
translate([-13, -32, -8]) {
  color("White", 1.0) {
    union() {
    // Bottom
    difference() {
      cube([82, 130, 3]);
      // Cut out for power
      translate([13.1, 32, 8])
        power_jack();
      // Ventilation holes
      for (i = [0 : 4]) {
        for (j = [0 : 4]) {
          translate([20 + i*10, 42 + j*10, 2.4])
          cylinder(h=5, r=1, $fn=50, center=true);
        }
      }
    }

    // Friction-fit edges
    translate([3, 3, 3])
    difference() {
	   cube([76, 124, 5]);
      translate([3, 3, -1])
        cube([70, 118, 7]);
      // Cut out for SD card
      translate([-3, -3, -3])
      translate([29.25, 100.76, 4.5])
        cube([25, 33, 5]);
      // Cut out for power
      translate([12.55, 32, 0])
      translate([-3, -3, 5])
        power_jack();
    }
    // SD card guide
    translate([26.25, 119, 3])
      difference() {
        cube([31, 11, 5]);
        translate([3, -1, 1.5])
          cube([25, 13, 5]);
      }
    // RPi mounting posts
    // Get into the RPi board coordinate space
    translate([12, 31, 2]) {
    translate([43.5, 5, 0])
      mountingpost(3, false);
    translate([18, 59.5, 0])
      mountingpost(3, false);
    // Rpi mounting blocks
    // Lower left
    translate([-3, -3, 0]) {
      difference() {
        cube([10, 10, 8]);
        translate([3, 3, 5])
          cube([8, 8, 6]);
      }
    }
    // Upper right
    translate([56.1 - 7, 85 - 7, 0]) {
      difference() {
        cube([10, 10, 8]);
        translate([-1, -1, 4.5])
          cube([8, 8, 6]);
      }
    }
    }
    }
  }
}
}

// Case Front
module front() {
translate([-13, -32, 30.6]) {
  color("White", 1.0)
  union() {
    difference() {
      translate([0, 0, -35.6])
        // Front and side walls
        cube([82, 130, 38.6]);
      // Cut out inside
      translate([3, 3, -36.6])
        cube([76, 124, 36.6]);
      // Cut out for display
      translate([19.55, 87, -5])
        cube([43, 33, 10]);
      // Cut out for SD card
      translate([0, 0, -36.6])
      translate([29.25, 100.76, 0])
        cube([25, 33, 5.4]);
      // Cut out for power
      translate([12.55, 32, -30.6])
        power_jack();
    }
    // LCD mounting blocks
    // top
    translate([15.05, 118.9, -3]) {
      difference() {
        cube([50, 4, 3]);
        translate([2, -1, -2])
          cube([46, 3, 5]);
      }
    }
    // lower left
    translate([15, 78, -3]) {
      cube([2, 4, 3]);
      translate([2, 0, 0])
        cube([4, 2, 3]);
    }
    // lower right
    translate([15 + 46 + 2, 78, -3]) {
      cube([2, 4, 3]);
      translate([-2, 0, 0])
        cube([4, 2, 3]);
    }
    // LCD controller mounting posts
    translate([12, 31, -29.6]) {
    translate([5.05, 0, 28]) {
    translate([0, 0, -1.85]) {
      translate([2.5, 2, 0])
        mountingpost(2.95, false);
      translate([47.4 - 2.5, 2, 0])
        mountingpost(2.95, false);
      translate([2.5, 32 - 2, 0])
        mountingpost(2.95, false);
      translate([47.4 - 2.5, 32 - 2, 0])
        mountingpost(2.95, false);
    }
    }
    }
    // Voltage converter mounting posts
    translate([12, 31, -29.6]) {
    translate([-8, -25, 24.6]) {
    translate([48.4, 0, 1.16]) {
    rotate(a=[0,180,0]) {
      translate([40.58805, 3.15, -2.5])
        mountingpost(3, true);
      translate([7.75, 19.95, -2.5])
        mountingpost(3, true);
    }
    }
    }
    }
  }
}
}

rpi();
/*
projection(cut=true)
translate([33, 52, 1])
*/
//back();
/*
projection(cut=true)
translate([33 + 82, 0, 0])
rotate(a=[0,180,0])
translate([33, 52, -30])
*/
front();
//display();
//voltageconverter();
//power_jack();
