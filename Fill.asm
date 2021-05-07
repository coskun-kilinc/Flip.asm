(LOOP)
    @SCREEN     //Starts the infinite loop
    D=A         //Loads the screen memory space
    @0
    M=D         //stores D (the screen memory space) in ram0 so that
                //we can iterate through the pixels on the screen later

(KBDCHECK)      //Check the keyboard memory space to see if a key is being pressed
    @KBD
    D=M         //loads the contents of KBD (which key is being pressed, if any) to D
    @WHITE
    D;JEQ       //if D is equal to 0 (no key is pressed) jump to @WHITE
    @BLACK
    0;JMP      //else, go to black

(BLACK)
    @1
    M=-1        //sets RAM1 to fill value to black
    @FILL
    0;JMP       //unconditionally jump to fill procedure

(WHITE)
    @1
    M=0         //sets RAM1 to fill value to white
    @FILL
    0;JMP       //unconditionally jump to fill procedure

(FILL)
    @1          //load Ram1 to see what value to fill the screen with
    D=M         //D now contains the value (black or white) to fill the screen with
    @0
    A=M         //Loads address of the pixel to fill
    M=D         //fills the pixel with the value in Ram1 (black or white)
    @0
    M=M+1       //increment to next pixel and stores it back in ram0
    D=M         //sets D to ram 0
    @KBD
    D=A-D       //sets D to D (the current pixel) minus KBD (the last register) to get number of pixels remaining to fill
    @FILL
    D;JGT       //if remaining  pixels to fill is greater than 0, repeat loop else continue

@LOOP
0;JMP           //remaining pixels was 0, jump to start of loop
