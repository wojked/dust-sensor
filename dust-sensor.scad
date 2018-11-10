EXTRA_MARGIN = 6; // initially 6
SENSOR_WIDTH = 70 + EXTRA_MARGIN;
SENSOR_HEIGHT = 70 + EXTRA_MARGIN;

WALL_THICKNESS = 2;
TOTAL_WALL_HEIGHT = 25;
WALL_HEIGHT = 14;
FRONT_WALL_HEIGHT = TOTAL_WALL_HEIGHT - WALL_HEIGHT;

HOLE_DIAMETER = 3.0; // initially 2.7
HOLE_HOLDER = 6.65;

BASE_THICKNESS = 1;
CORNER_CURVE_DIAMETER = 5; // initially 3

//Cut-outs dimensions
CABLE_PORT_HEIGHT = 21;
AIR_INTAKE_DIAMETER = 7.15;
FAN_SIZE = 35;
FAN_HEIGHT = 10;

PCB_THICKNESS = 1.64;
TOTAL_PCB_THICKNESS = 4.10;
CHIP_THICKNESS = TOTAL_PCB_THICKNESS - PCB_THICKNESS + 1; //initially +0.5
SLOT_HEIGHT = CHIP_THICKNESS + 2.5; //initially + 2

// WEMOS
WEMOS_WIDTH = 61.5;
WEMOS_HEIGHT = 27.5;

EXPLODE = 1;


$fn = 128;

//dust_sensor_back();  
//
//translate([0, 0, WALL_HEIGHT + EXPLODE])
dust_sensor_front();


module dust_sensor_back(dust_sensor) {    
    difference(){
        union(){
            translate([0, 0, BASE_THICKNESS/2])
            base();
            
            translate([0, 0, WALL_HEIGHT/2])
            base_with_walls(WALL_HEIGHT);        
        };        
              
//        // CABLES
//        color("red")
//        translate([-SENSOR_WIDTH/2, (SENSOR_HEIGHT-CABLE_PORT_HEIGHT-EXTRA_MARGIN)/2, BASE_THICKNESS+WALL_HEIGHT/2+2]) //Extra +2
//        cube([8,CABLE_PORT_HEIGHT,WALL_HEIGHT], true);         

        // AIR INTAKE      
        color("red")
        translate([SENSOR_WIDTH/2, (SENSOR_HEIGHT-AIR_INTAKE_DIAMETER-EXTRA_MARGIN)/2-17, BASE_THICKNESS+AIR_INTAKE_DIAMETER/2+6.2])
        cube([8,AIR_INTAKE_DIAMETER,AIR_INTAKE_DIAMETER], true);         
    }            
    
    translate([(SENSOR_WIDTH-HOLE_DIAMETER-EXTRA_MARGIN)/2-9.5, (SENSOR_HEIGHT-HOLE_DIAMETER-EXTRA_MARGIN)/2-3.48, BASE_THICKNESS/2])    
    screw_slot();
    
    // Extra stabilizer
    translate([-(SENSOR_WIDTH-HOLE_DIAMETER-EXTRA_MARGIN)/2+25, (SENSOR_HEIGHT-HOLE_DIAMETER-EXTRA_MARGIN)/2-3.48, BASE_THICKNESS/2])        
    stabiliser();  
    
    translate([-(SENSOR_WIDTH-HOLE_DIAMETER-EXTRA_MARGIN)/2+2.37, (SENSOR_HEIGHT-HOLE_DIAMETER-EXTRA_MARGIN)/2-22.47, BASE_THICKNESS/2])    
    screw_slot();    
    
    translate([(SENSOR_WIDTH-HOLE_DIAMETER-EXTRA_MARGIN)/2-9.5, -(SENSOR_HEIGHT-HOLE_DIAMETER-EXTRA_MARGIN)/2+3.48, BASE_THICKNESS/2])    
    screw_slot();       
    
    // Extra stabilizer
    translate([-(SENSOR_WIDTH-HOLE_DIAMETER-EXTRA_MARGIN)/2+2.37, -(SENSOR_HEIGHT-HOLE_DIAMETER-EXTRA_MARGIN)/2+3.48, BASE_THICKNESS/2])    
    stabiliser();
}

module wemos_plate() {
    cutout = 8;
    
    wemos_width = WEMOS_WIDTH;
    wemos_height = WEMOS_HEIGHT;
    
    wemos_screw_offset = 0.8;
    wemos_screw_slot_diameter = 3;
    
    wemos_screen_width = 28.31;
    wemos_screen_height = 18;
    
    wemos_usb_to_screen = 2.2;
    
    wemos_usb_width = 9.9;
    wemos_usb_height = 10;
    wemos_usb_extra_width = 4;
    
    translate_x = (wemos_width-wemos_screw_slot_diameter)/2 - wemos_screw_offset;
    translate_y = (wemos_height-wemos_screw_slot_diameter)/2 - wemos_screw_offset;
    
    difference(){
        cube([wemos_width,wemos_height,1], true);
        
        translate([translate_x, translate_y, 0])
        cylinder(SLOT_HEIGHT,wemos_screw_slot_diameter/2, wemos_screw_slot_diameter/2, true); 
        
        translate([translate_x, -translate_y, 0])
        cylinder(SLOT_HEIGHT,wemos_screw_slot_diameter/2, wemos_screw_slot_diameter/2, true);         
        
        translate([-translate_x, -translate_y, 0])
        cylinder(SLOT_HEIGHT,wemos_screw_slot_diameter/2, wemos_screw_slot_diameter/2, true);                 
        
        translate([-translate_x, translate_y, 0])
        cylinder(SLOT_HEIGHT,wemos_screw_slot_diameter/2, wemos_screw_slot_diameter/2, true);                         
    }
    
    // Screen cut out
    color("red")
    translate([(wemos_width-wemos_screen_width)/2 - wemos_usb_width - wemos_usb_to_screen, 0, cutout/2])  
    cube([wemos_screen_width,wemos_screen_height,cutout], true);    
    
    // USB port
    color("red")
    translate([(wemos_width-wemos_usb_width+wemos_usb_extra_width)/2, 0, cutout/2])    
    cube([wemos_usb_width+wemos_usb_extra_width,wemos_usb_height,cutout], true);     
}

module dust_sensor_front(dust_sensor) {  
    difference(){
        union(){
            translate([0, 0, FRONT_WALL_HEIGHT/2])
            base_with_walls(FRONT_WALL_HEIGHT);                  
            
            translate([0, 0, FRONT_WALL_HEIGHT - BASE_THICKNESS/2])
            base();
        };        
        // FAN (on top)
        color("red")
        translate([-SENSOR_WIDTH/2, -(SENSOR_HEIGHT-FAN_SIZE-EXTRA_MARGIN)/2+5, FAN_HEIGHT/2])
        cube([8,FAN_SIZE,FAN_HEIGHT], true);        
        
        translate([-(SENSOR_WIDTH-WEMOS_WIDTH)/2,(SENSOR_HEIGHT-WEMOS_HEIGHT)/2,(FRONT_WALL_HEIGHT)/2])
        rotate([0,0,180])
        wemos_plate();        
    }      

//    translate([-(SENSOR_WIDTH-WEMOS_WIDTH)/2,(SENSOR_HEIGHT-WEMOS_HEIGHT)/2,(FRONT_WALL_HEIGHT)/2])
//    rotate([0,0,180])
//    wemos_plate();
}

module rounded_corners(width, height, depth, corner_curve){
    x_translate = width-corner_curve;
    y_translate = height-corner_curve;     
    
    hull(){
            translate([-x_translate/2, -y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);    
            
            translate([-x_translate/2, y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);

            translate([x_translate/2, y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);        
            
            translate([x_translate/2, -y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);        
    }        
}

module base(){
    x_translate = SENSOR_WIDTH-CORNER_CURVE_DIAMETER;
    y_translate = SENSOR_HEIGHT-CORNER_CURVE_DIAMETER;    
    
    difference(){
         rounded_corners(SENSOR_WIDTH, SENSOR_HEIGHT, BASE_THICKNESS, CORNER_CURVE_DIAMETER);
//         cube([SENSOR_WIDTH-22,SENSOR_HEIGHT-22,BASE_THICKNESS*2], true);            
    }
}

module base_with_walls(wall_height){    
    difference(){
        // OUTSIDE
        rounded_corners(SENSOR_WIDTH+WALL_THICKNESS*2, SENSOR_HEIGHT+WALL_THICKNESS*2, wall_height, CORNER_CURVE_DIAMETER);        
        
        // INSIDE
        rounded_corners(SENSOR_WIDTH, SENSOR_HEIGHT, wall_height*2, CORNER_CURVE_DIAMETER);
    }
}

module stabiliser(){
    translate([0,0,CHIP_THICKNESS/2])
    cylinder(CHIP_THICKNESS,HOLE_HOLDER/2, HOLE_HOLDER/2, true);     
}

module screw_slot(){
    union(){
        translate([0,0,CHIP_THICKNESS/2])
        cylinder(CHIP_THICKNESS,HOLE_HOLDER/2, HOLE_HOLDER/2, true);            
        
        translate([0,0,SLOT_HEIGHT/2])
        cylinder(SLOT_HEIGHT,HOLE_DIAMETER/2, HOLE_DIAMETER/2, true);                    
    }
}
