EXTRA_MARGIN = 14; // initially 6
SENSOR_WIDTH = 70 + EXTRA_MARGIN;
SENSOR_HEIGHT = 70 + EXTRA_MARGIN;

BASE_THICKNESS = 2; // initially 1
CORNER_CURVE_DIAMETER = 10; // initially 3

WALL_THICKNESS = 2;
TOTAL_WALL_HEIGHT = 32; // initially 25
WALL_HEIGHT = 18;
FRONT_WALL_HEIGHT = TOTAL_WALL_HEIGHT - WALL_HEIGHT + BASE_THICKNESS - 1; // Fix with BASE_THICKNESS - 1 (initial thickness was 1)


/* [MOUNTING ELEMS] */
HOLE_DIAMETER = 3.0; // initially 2.7
HOLE_HOLDER = 6.65;
SCREW_WALL_THICKNESS = 2;
SCREW_HEAD_DIAMETER = 6.4; // M3 screw
SCREW_HEAD_THICKNESS = 3.07; // M3 screw
SCREW_OFFSET = 0.7;


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

WEMOS_TOTAL_THICKNESS = 4.8;
WEMOS_PCB_THICKNESS = PCB_THICKNESS;
WEMOS_SUPPORT_HEIGHT = WEMOS_TOTAL_THICKNESS - WEMOS_PCB_THICKNESS + 2;

WEMOS_OFFSET = 5;
WEMOS_SCREW_OFFSET = 0.5;   //initially 0.8

//DHT22
DHT_WIDTH = 21;
DHT_HEIGHT = 16;
DHT_WIDHT_WITH_HEADER = 26;
DHT_THICKNESS = 7.8;
DHT_HEADER_THICKNESS = 1.6;
DHT_BACK_OFFSET = 2;

DHT_RED_PCB_WIDTH = 40;
DHT_RED_PCB_HEIGHT = 23;
DHT_RED_PCB_THICKNESS = 1.8;
DHT_RED_PCB_OFFSET = 3;
DHT_OFFSET = 8;

OBJ_VISIBLE = false;

EXPLODE = 0;
ROTATE = 180;


$fn = 128;

//dust_sensor_back();  

translate([0, 0, WALL_HEIGHT + EXPLODE])
rotate([0,ROTATE,0])
dust_sensor_front();

module air_grill(){
    hole_width = 2;
    hole_separator = 2;
    translate_step = hole_width + hole_separator;
    length = 10;
    
    initial_translation = translate_step;
    translate([length/2, -initial_translation, 0])
    for (n = [0:1:5]){
        translate([0,n*translate_step, 0]) 
        cube([length,hole_width,hole_width], true);    
    };     
}

module air_grill_set(){
    translate([0,-5,7])
    air_grill();
    
    translate([0,-5,3])
    air_grill();
    
    translate([0,-5,-1])
    air_grill();        
    
    translate([0,-5,-5])
    air_grill();         
    
    translate([0,-5,-9])
    air_grill();  

    translate([0,-5,-13])
    air_grill();      
}

module dht22redpcb(){
    color("red")     
    cube([DHT_RED_PCB_THICKNESS,DHT_RED_PCB_WIDTH,DHT_RED_PCB_HEIGHT], true);     
}

module dht22whitepart(){
    union(){
        cube([DHT_THICKNESS,DHT_WIDTH,DHT_HEIGHT], true);    
        
        translate([-(DHT_THICKNESS-DHT_HEADER_THICKNESS)/2,(DHT_WIDTH-DHT_WIDHT_WITH_HEADER)/2,0])
        cube([DHT_HEADER_THICKNESS,DHT_WIDHT_WITH_HEADER,DHT_RED_PCB_HEIGHT], true);    
        
        translate([0,0,1.5])
        air_grill_set();
    }    
}

module dht22(){
    union(){
        color("red")
        dht22redpcb();
        
        color("white")
        translate([(DHT_RED_PCB_THICKNESS + DHT_THICKNESS)/2-0.001,(DHT_RED_PCB_WIDTH - DHT_WIDTH)/2 - 12,0])
        dht22whitepart();       
    }
}

module screw_head(height) {;
    cylinder(height,SCREW_HEAD_DIAMETER/2, SCREW_HEAD_DIAMETER/2, true);      
}

module screw_pole(height, additional_thickness){
    pole_diameter = HOLE_DIAMETER + 2*SCREW_WALL_THICKNESS + additional_thickness;
    cylinder(height,pole_diameter/2, pole_diameter/2, true);              
}

module screw_tunnel(height){
    color("white")    
    cylinder(height,HOLE_DIAMETER/2, HOLE_DIAMETER/2, true);                  
}

module screw_port(height){
    screw_diameter = HOLE_DIAMETER + 2*SCREW_WALL_THICKNESS;
    
    difference(){
        cylinder(height,screw_diameter/2, screw_diameter/2, true);              
        cylinder(height*2,HOLE_DIAMETER/2, HOLE_DIAMETER/2, true);              
    }
}

module screw_heads(){
    screw_depth = 3;
    translate_x = (SENSOR_WIDTH-SCREW_HEAD_DIAMETER)/2+SCREW_OFFSET;
    translate_y = (SENSOR_HEIGHT-SCREW_HEAD_DIAMETER)/2+SCREW_OFFSET;    

    union(){      
        color("red")
        translate([translate_x,translate_y,screw_depth/2])
        screw_head(screw_depth);     

        color("red")
        translate([-translate_x,translate_y,screw_depth/2])
        screw_head(screw_depth);             
        
        color("red")
        translate([-translate_x,-translate_y,screw_depth/2])
        screw_head(screw_depth);           
        
        color("red")
        translate([translate_x,-translate_y,screw_depth/2])
        screw_head(screw_depth);    
    }
}

module screw_poles(height, additional_thickness){
    screw_depth = 10;
    translate_x = (SENSOR_WIDTH-SCREW_HEAD_DIAMETER)/2+SCREW_OFFSET;
    translate_y = (SENSOR_HEIGHT-SCREW_HEAD_DIAMETER)/2+SCREW_OFFSET;    

    translate([0,0,height/2])
    union(){      
        color("red")
        translate([translate_x,translate_y,0])
        screw_pole(height, additional_thickness);     

        color("red")
        translate([-translate_x,translate_y,0])
        screw_pole(height, additional_thickness);     
        
        color("red")
        translate([-translate_x,-translate_y,0])
        screw_pole(height, additional_thickness);       
        
        color("red")
        translate([translate_x,-translate_y,0])
        screw_pole(height, additional_thickness);     
    }    
}

module dht22_holder(height){
    size = SCREW_HEAD_DIAMETER-1;
    
    translate([size/2,size/2,height/2])
    color("blue")
    cube([size*2,size,height], true);      
}

module screw_tunnels(height){
    screw_depth = 10;
    translate_x = (SENSOR_WIDTH-SCREW_HEAD_DIAMETER)/2+SCREW_OFFSET;
    translate_y = (SENSOR_HEIGHT-SCREW_HEAD_DIAMETER)/2+SCREW_OFFSET;    

    translate([0,0,height/2])
    union(){      
        translate([translate_x,translate_y,0])
        screw_tunnel(height*2);     

        translate([-translate_x,translate_y,0])
        screw_tunnel(height*2);               
        
        translate([-translate_x,-translate_y,0])
        screw_tunnel(height*2);            
        
        translate([translate_x,-translate_y,0])
        screw_tunnel(height*2);     
    }    
}

module dust_sensor_back(dust_sensor) { 
    wemos_wall_dist=3;
    wemos_fix_offset = 0.2;
    difference(){
        union(){
            translate([0, 0, BASE_THICKNESS/2])
            base();
            
            translate([0, 0, WALL_HEIGHT/2])
            base_with_walls(WALL_HEIGHT);        

            screw_poles(WALL_HEIGHT, 0.8);        
            
            translate([SENSOR_WIDTH/2 - 9, -SENSOR_HEIGHT/2, 0])
            dht22_holder(WALL_HEIGHT);      
      
    
        //    // WEMOS
        //    translate([-(SENSOR_WIDTH-WEMOS_WIDTH)/2+WEMOS_OFFSET,(SENSOR_HEIGHT-WEMOS_HEIGHT)/2-wemos_wall_dist,BASE_THICKNESS+WALL_HEIGHT-2])
        //    rotate([0,0,180])    
        //    scale([1,1,4])
        //    wemos_thick_plate();    
            translate([(SENSOR_WIDTH-HOLE_DIAMETER-EXTRA_MARGIN)/2-9.5, (SENSOR_HEIGHT-HOLE_DIAMETER-EXTRA_MARGIN)/2-3.48, BASE_THICKNESS])    
            screw_slot();
            
            // Extra stabilizer
            translate([-(SENSOR_WIDTH-HOLE_DIAMETER-EXTRA_MARGIN)/2+25, (SENSOR_HEIGHT-HOLE_DIAMETER-EXTRA_MARGIN)/2-3.48, BASE_THICKNESS])        
            stabiliser();  
            
            translate([-(SENSOR_WIDTH-HOLE_DIAMETER-EXTRA_MARGIN)/2+2.37, (SENSOR_HEIGHT-HOLE_DIAMETER-EXTRA_MARGIN)/2-22.47, BASE_THICKNESS])    
            screw_slot();    
            
            translate([(SENSOR_WIDTH-HOLE_DIAMETER-EXTRA_MARGIN)/2-9.5, -(SENSOR_HEIGHT-HOLE_DIAMETER-EXTRA_MARGIN)/2+3.48, BASE_THICKNESS])    
            screw_slot();       
            
            // Extra stabilizer
            translate([-(SENSOR_WIDTH-HOLE_DIAMETER-EXTRA_MARGIN)/2+2.37, -(SENSOR_HEIGHT-HOLE_DIAMETER-EXTRA_MARGIN)/2+3.48, BASE_THICKNESS])    
            stabiliser();            
        };  
        
        screw_heads();        
        screw_tunnels(WALL_HEIGHT);
              
//        // CABLES
//        color("red")
//        translate([-SENSOR_WIDTH/2, (SENSOR_HEIGHT-CABLE_PORT_HEIGHT-EXTRA_MARGIN)/2, BASE_THICKNESS+WALL_HEIGHT/2+2]) //Extra +2
//        cube([8,CABLE_PORT_HEIGHT,WALL_HEIGHT], true);         

        // WEMOS - cutout - fix
        translate([-(SENSOR_WIDTH-WEMOS_WIDTH)/2+WEMOS_OFFSET-wemos_fix_offset,(SENSOR_HEIGHT-WEMOS_HEIGHT)/2-wemos_wall_dist+wemos_fix_offset,BASE_THICKNESS+WALL_HEIGHT-2])
        rotate([0,0,180])    
        scale([1,1,4])   
        wemos_thick_plate();

        // AIR INTAKE      
        color("red")
        translate([SENSOR_WIDTH/2, (SENSOR_HEIGHT-AIR_INTAKE_DIAMETER-EXTRA_MARGIN)/2-15.5, BASE_THICKNESS+AIR_INTAKE_DIAMETER/2+6.2])
        cube([8,AIR_INTAKE_DIAMETER,AIR_INTAKE_DIAMETER], true);  

       // DHT22
        translate([(SENSOR_WIDTH-DHT_RED_PCB_THICKNESS)/2 - DHT_OFFSET, -(SENSOR_HEIGHT-DHT_RED_PCB_WIDTH)/2 + 0.5, BASE_THICKNESS + (DHT_RED_PCB_HEIGHT+SLOT_HEIGHT+PCB_THICKNESS)/2+DHT_BACK_OFFSET])
        dht22();       
    }        
//    // DHT22 - positive
    if(OBJ_VISIBLE){
        translate([(SENSOR_WIDTH-DHT_RED_PCB_THICKNESS)/2 - DHT_OFFSET, -(SENSOR_HEIGHT-DHT_RED_PCB_WIDTH)/2 + 0.5, BASE_THICKNESS + (DHT_RED_PCB_HEIGHT+SLOT_HEIGHT+PCB_THICKNESS)/2+DHT_BACK_OFFSET])
        dht22();            
    }
}
module wemos_thick_plate() {
    cutout = 12;
    
    wemos_width = WEMOS_WIDTH;
    wemos_extra_width = 0.5;
    
    wemos_height = WEMOS_HEIGHT;
    wemos_extra_height = 0.5;
    
    wemos_screw_offset = WEMOS_SCREW_OFFSET;
    wemos_screw_slot_diameter = 3;
    
    wemos_screen_width = 28.31;
    wemos_screen_height = 15.64; // initially 18
    wemos_screen_bottom_offset = 7.5; // initially 7.5
    
    wemos_usb_to_screen = 2.2;
    
    wemos_usb_width = 9.9;
    wemos_usb_height = 12;
    wemos_usb_extra_width = 4;
    
    screw_extra_margin_height = 21;
    screw_extra_margin_thickness = 2.55;
    
    cube([wemos_width+wemos_extra_width,wemos_height+wemos_extra_height,WEMOS_PCB_THICKNESS], true);
}


module wemos_plate() {
    cutout = 12;
    
    wemos_width = WEMOS_WIDTH;
    wemos_extra_width = 0.5;
    
    wemos_height = WEMOS_HEIGHT;
    wemos_extra_height = 0.5;
    
    wemos_screw_offset = WEMOS_SCREW_OFFSET;
    wemos_screw_slot_diameter = 3;
    
    wemos_screen_width = 28.31;
    wemos_screen_height = 15.64; // initially 18
    wemos_screen_bottom_offset = 7.5; // initially 7.5
    
    wemos_usb_to_screen = 2.2;
    
    wemos_usb_width = 9.9;
    wemos_usb_height = 12;
    wemos_usb_extra_width = 4;
    
    screw_extra_margin_height = 21;
    screw_extra_margin_thickness = 2.55;
    
    translate_x = (wemos_width-wemos_screw_slot_diameter)/2 - wemos_screw_offset;
    translate_y = (wemos_height-wemos_screw_slot_diameter)/2 - wemos_screw_offset;
    
    difference(){
        cube([wemos_width+wemos_extra_width,wemos_height+wemos_extra_height,WEMOS_PCB_THICKNESS], true);
        
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
    translate([(wemos_width-wemos_screen_width)/2 - wemos_usb_width - wemos_usb_to_screen+WEMOS_OFFSET, -(wemos_height-wemos_screen_height)/2 + wemos_screen_bottom_offset, cutout/2])  
    cube([wemos_screen_width,wemos_screen_height,cutout], true);    
    
    // USB port
    color("red")
    translate([(wemos_width-wemos_usb_width+wemos_usb_extra_width)/2+WEMOS_OFFSET, 0, cutout/2-2])    
    cube([wemos_usb_width+wemos_usb_extra_width,wemos_usb_height,cutout], true);     
    
    // Additional screw cutouts
    color("green")
    translate([(wemos_width-wemos_usb_width)/2-4+WEMOS_OFFSET, 0, (WEMOS_PCB_THICKNESS + screw_extra_margin_thickness)/2])  
    cube([wemos_usb_width,screw_extra_margin_height,screw_extra_margin_thickness], true);            
}

module wemos_single_support() {
    wemos_screw_offset = WEMOS_SCREW_OFFSET;
    wemos_screw_slot_diameter = 3;    
    
    support_wall_thickness = 1.5;
    support_diameter = wemos_screw_slot_diameter + 2*support_wall_thickness; 
    
    difference(){
        cylinder(WEMOS_SUPPORT_HEIGHT,support_diameter/2, support_diameter/2, true); 
        cylinder(WEMOS_SUPPORT_HEIGHT*2,wemos_screw_slot_diameter/2, wemos_screw_slot_diameter/2, true);         
    }
}

module wemos_supports(){
    support_height = 4;
    
    wemos_width = WEMOS_WIDTH;
    wemos_height = WEMOS_HEIGHT;    
    
    wemos_screw_offset = WEMOS_SCREW_OFFSET;
    wemos_screw_slot_diameter = 3;    
    
    translate_x = (wemos_width-wemos_screw_slot_diameter)/2 - wemos_screw_offset;
    translate_y = (wemos_height-wemos_screw_slot_diameter)/2 - wemos_screw_offset;    

    union(){
        translate([translate_x, translate_y, 0])
        wemos_single_support();
        
        translate([translate_x, -translate_y, 0])
        wemos_single_support();
        
        translate([-translate_x, -translate_y, 0])
        wemos_single_support();
        
        translate([-translate_x, translate_y, 0])
        wemos_single_support();
    };     
}

module dust_sensor_front(dust_sensor) {  
    wemos_width = WEMOS_WIDTH;
    wemos_height = WEMOS_HEIGHT;    
    
    wemos_screw_offset = WEMOS_SCREW_OFFSET;
    wemos_screw_slot_diameter = 3;    
    
    translate_x = (wemos_width-wemos_screw_slot_diameter)/2 - wemos_screw_offset;
    translate_y = (wemos_height-wemos_screw_slot_diameter)/2 - wemos_screw_offset;
    
    wemos_wall_dist = 3;
    
    dht_support_height = 4;
    dht_support_width = 5;
    dht_support_thickness = 4;
    
    difference(){
        union(){
            translate([0, 0, FRONT_WALL_HEIGHT/2])
            base_with_walls(FRONT_WALL_HEIGHT);                  
           
            translate([0, 0, FRONT_WALL_HEIGHT - BASE_THICKNESS/2])
            base();
            
            translate([-(SENSOR_WIDTH-WEMOS_WIDTH)/2+WEMOS_OFFSET,(SENSOR_HEIGHT-WEMOS_HEIGHT)/2-wemos_wall_dist, FRONT_WALL_HEIGHT - BASE_THICKNESS - WEMOS_SUPPORT_HEIGHT/2])
            wemos_supports();
            
            screw_poles(FRONT_WALL_HEIGHT, 0.8);      

            //dht22 support
            translate([SENSOR_WIDTH/2 - 9, -SENSOR_HEIGHT/2, 0])
            dht22_holder(FRONT_WALL_HEIGHT);            
            
            color("blue")
            translate([(SENSOR_WIDTH-dht_support_width)/2-6.5,-2,FRONT_WALL_HEIGHT - BASE_THICKNESS - dht_support_thickness/2 - 0])
            cube([dht_support_width,dht_support_height,dht_support_thickness], true);
        };                 
        
        // DHT22
        translate([(SENSOR_WIDTH-DHT_RED_PCB_THICKNESS)/2 - DHT_OFFSET, -(SENSOR_HEIGHT-DHT_RED_PCB_WIDTH)/2 + 0.5, FRONT_WALL_HEIGHT - BASE_THICKNESS - DHT_RED_PCB_HEIGHT/2])
        dht22();        
        
        //Screw tunnels
        translate([0, 0, -FRONT_WALL_HEIGHT/2-BASE_THICKNESS])        
        screw_tunnels(FRONT_WALL_HEIGHT);        
        
        // FAN (on top)
        color("red")
        translate([-SENSOR_WIDTH/2, -(SENSOR_HEIGHT-FAN_SIZE-EXTRA_MARGIN)/2+5, FAN_HEIGHT/2])
        cube([8,FAN_SIZE,FAN_HEIGHT], true);        
        
        // Wemos plate with the screen and USB
        translate([-(SENSOR_WIDTH-WEMOS_WIDTH)/2+WEMOS_OFFSET,(SENSOR_HEIGHT-WEMOS_HEIGHT)/2-wemos_wall_dist,FRONT_WALL_HEIGHT-BASE_THICKNESS - WEMOS_SUPPORT_HEIGHT - WEMOS_PCB_THICKNESS/2])
        rotate([0,0,180])
        wemos_plate();        

        // Wemos thicker cutout
        translate([-(SENSOR_WIDTH-WEMOS_WIDTH)/2+WEMOS_OFFSET,(SENSOR_HEIGHT-WEMOS_HEIGHT)/2-wemos_wall_dist,FRONT_WALL_HEIGHT-BASE_THICKNESS - WEMOS_SUPPORT_HEIGHT - WEMOS_PCB_THICKNESS*2-2])    
        scale([1,1,6])
        wemos_thick_plate();         
    }      
    
//    // DHT22 - positive
    if(OBJ_VISIBLE){
        translate([(SENSOR_WIDTH-DHT_RED_PCB_THICKNESS)/2 - DHT_OFFSET, -(SENSOR_HEIGHT-DHT_RED_PCB_WIDTH)/2 + 0.5, FRONT_WALL_HEIGHT - BASE_THICKNESS - DHT_RED_PCB_HEIGHT/2])
        dht22();  
    }
           
//    
//    translate([-(SENSOR_WIDTH-WEMOS_WIDTH)/2+WEMOS_OFFSET,(SENSOR_HEIGHT-WEMOS_HEIGHT)/2-wemos_wall_dist,FRONT_WALL_HEIGHT-BASE_THICKNESS - WEMOS_SUPPORT_HEIGHT - WEMOS_PCB_THICKNESS/2])
//    rotate([0,0,180])
//    wemos_plate(); 
//    
    if(OBJ_VISIBLE){
        translate([-(SENSOR_WIDTH-WEMOS_WIDTH)/2+WEMOS_OFFSET,(SENSOR_HEIGHT-WEMOS_HEIGHT)/2-wemos_wall_dist,FRONT_WALL_HEIGHT-BASE_THICKNESS - WEMOS_SUPPORT_HEIGHT - WEMOS_PCB_THICKNESS*2-2])    
        scale([1,1,6])
        wemos_thick_plate();        
    }
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
