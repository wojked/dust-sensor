SENSOR_WIDTH = 70;
SENSOR_HEIGHT = 70;

HOLE_DIAMETER = 2.7;
HOLE_HOLDER = 6.65;

BASE_THICKNESS = 1;
CORNER_CURVE_DIAMETER = 3;

PCB_THICKNESS = 1.64;
TOTAL_PCB_THICKNESS = 4.10;
CHIP_THICKNESS = TOTAL_PCB_THICKNESS - PCB_THICKNESS + 0.5;
SLOT_HEIGHT = CHIP_THICKNESS + 2;


$fn = 128;
dust_sensor();  


module dust_sensor(dust_sensor) {
//    cube([SENSOR_WIDTH, SENSOR_HEIGHT, 2], true);  
    base();
    
    translate([(SENSOR_WIDTH-HOLE_DIAMETER-11.5)/2, (SENSOR_HEIGHT-HOLE_DIAMETER-5.17)/2, BASE_THICKNESS/2])    
    screw_slot();
    
    translate([-(SENSOR_WIDTH-HOLE_DIAMETER-4.45)/2, (SENSOR_HEIGHT-HOLE_DIAMETER-23.05)/2, BASE_THICKNESS/2])    
    screw_slot();    
    
    translate([(SENSOR_WIDTH-HOLE_DIAMETER-11.5)/2, -(SENSOR_HEIGHT-HOLE_DIAMETER-4.36)/2, BASE_THICKNESS/2])    
    screw_slot();       
}

module base(){
    x_translate = SENSOR_WIDTH-CORNER_CURVE_DIAMETER;
    y_translate = SENSOR_HEIGHT-CORNER_CURVE_DIAMETER;    
    
    translate([0, 0, BASE_THICKNESS/2])    
    difference(){
        
        hull(){
                translate([-x_translate/2, -y_translate/2, 0])
                cylinder(BASE_THICKNESS,CORNER_CURVE_DIAMETER/2, CORNER_CURVE_DIAMETER/2, true);    
                
                translate([-x_translate/2, y_translate/2, 0])
                cylinder(BASE_THICKNESS,CORNER_CURVE_DIAMETER/2, CORNER_CURVE_DIAMETER/2, true);

                translate([x_translate/2, y_translate/2, 0])
                cylinder(BASE_THICKNESS,CORNER_CURVE_DIAMETER/2, CORNER_CURVE_DIAMETER/2, true);        
                
                translate([x_translate/2, -y_translate/2, 0])
                cylinder(BASE_THICKNESS,CORNER_CURVE_DIAMETER/2, CORNER_CURVE_DIAMETER/2, true);        
            }
            cube([SENSOR_WIDTH-10,SENSOR_HEIGHT-10,BASE_THICKNESS*2], true);            
    }
}

module screw_slot(){
    union(){
        translate([0,0,CHIP_THICKNESS/2])
        cylinder(CHIP_THICKNESS,HOLE_HOLDER/2, HOLE_HOLDER/2, true);            
        
        translate([0,0,SLOT_HEIGHT/2])
        cylinder(SLOT_HEIGHT,HOLE_DIAMETER/2, HOLE_DIAMETER/2, true);                    
    }
}