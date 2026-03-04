      

    Installation instructions for Microsoft QuickWin Ver. 3.0 (FORTRAN)
    Copyright (C) Microsoft Corp. 1992. All rights reserved.


    INSTALLING QUICKWIN GRAPHICS
    ----------------------------

      It is strongly recommended that you read this section fully before 
      running the QuickWin Graphics setup program.
      
      You will need approximately 750K of free space on your hard disk drive 
      to successfully install QuickWin Graphics for Microsoft FORTRAN.
      
      To set up QuickWin Graphics, do the following:

	1.  Insert the Program Disk into your floppy disk drive.

	2.  Run the SETUP program.

	    NOTE:  If you chose to install Microsoft FORTRAN with directory 
	    names other than the default names, you should substitute the
	    directories which you specified when installing Microsoft FORTRAN
	    for those given here.

	    To run SETUP, type the following at the MS-DOS prompt:

	    a:setup <Bin dir> <Lib dir> <Include dir> <Samples dir>

	    where "a" is the letter representing your floppy disk drive.
	    Also, replace each of the four directory parameters (shown above
	    in angle brackets) with the fully qualified path name (including 
	    the hard disk drive letter) of the corresponding FORTRAN 
	    directory on your hard disk drive, as shown below:

	    Directory        FORTRAN default       Directory which
	    parameter        directory name        represents the location of
	    -------------    ------------------    --------------------------
	    <Bin dir>        c:\fortran\binb       MS-DOS executable files
	    <Lib dir>        c:\fortran\lib        QuickWin combined library
	    <Include dir>    c:\fortran\include    Include files
	    <Samples dir>    c:\fortran\source\    Sample programs
				samples

	    If for the <Samples dir> parameter you specify the directory 
	    where your existing FORTRAN sample code is located, some of the 
	    new sample programs will overwrite previous versions of the 
	    programs.  If you want to preserve the original versions of the 
	    sample code, you can create a new directory for the QuickWin 
	    Graphics sample programs, and specify that directory in place of 
	    your original samples directory.  
	    
	    NOTE:  It is required that you specify a drive letter before 
	    the "setup" command and each of the four directory parameters,
	    and that you use fully qualified path names.

	3.  You do NOT need to restart your system for the update to take 
	    effect.  Simply recompile your MS-DOS graphics applications as 
	    described in the QuickWin Graphics User's Guide.

	    NOTE:  SETUP will automatically back up your current QuickWin
	    combined library LLIBFEW.LIB to LLIBFEW.BAK.  If the new, updated 
	    library is working properly after SETUP is complete, you may 
	    delete the backup file to save space on your hard disk drive.


-----------------------------------------------------------------------------


  Supplemental Notes for the QuickWin Graphics User's Guide
  ---------------------------------------------------------


    INPUT COMMAND FROM WINDOW MENU AVAILABLE FOR GRAPHICS CHILD WINDOWS

      The QuickWin Graphics User's Guide states that the Input command (from
    the Window menu) is unavailable to the user in QuickWin graphics windows.
    The Input command is in fact available; when a Graphics Child Window is 
    waiting for input (upon a call to INCHARQQ), the Input command gives 
    focus to that window.


    DRAWING RECTANGLES 1 PIXEL BY 1 PIXEL IN SIZE ALLOWED

      The QuickWin Graphics User's Guide states that it is not possible to
    draw any graphics elements of only one pixel in size, except with the
    setpixel routines.  It is in fact possible to draw a 1x1 rectangle (as is
    the case with MS-DOS programs using GRAPHICS.LIB).


    SETTING OUT-OF-RANGE TEXT COLORS

      Under GRAPHICS.LIB, if an out-of-range text color is requested in a
    call to the settextcolor routine, the text color is set to the maximum
    nonblinking color index.  Under QuickWin Graphics, if an out of range 
    text color is requested, the text color is left unchanged.


    SETTING TEXT COLORS ON 256-COLOR MACHINES

      The following applies only to computers capable of displaying 256
    colors.  Under GRAPHICS.LIB in a 256-color mode, the text color can be
    set to any value from 0 to 255.  Under QuickWin Graphics, values greater
    than 31 are not allowed for text colors.


    DRAWING LINES WITH LINETO (or LINETO_W)

      Under QuickWin Graphics, the final pixel specified by a lineto call is
    not drawn.  For instance, assume the current position is (1,1).  Then the
    call:  status = LINETO(4,4) will only set pixels (1,1), (2,2), and (3,3).
    The new current position after the lineto call will be (4,4); however,
    that pixel is not set by the lineto call.


    CALLING RECTANGLE (or RECTANGLE_W) WITH $GFILLINTERIOR AND A FILL MASK

      If a call is made to one of the rectangle functions with the fill flag
    set to $GFILLINTERIOR and a fill mask other than the default solid mask,
    then the rectangle produced will be one pixel smaller than the dimensions
    specified in the call.  For example, a call which requests a filled
    rectangle (using a non-solid fill mask) from (10,10) to (20,20) produces 
    a rectangle from (10,10) to (19,19).

      
    CALLING FLOODFILL (or FLOODFILL_W) UNDER WINDOWS 3.1

      If an area being floodfilled has part of its border lying along the
    far-right border of the Logical Graphics Screen, the floodfill call may
    not recognize that section of the border, allowing the fill pattern to
    escape from its intended boundaries.


    CALLING FLOODFILL (or FLOODFILL_W) UNDER WINDOWS 3.0

      The floodfill routines work much slower under Windows 3.0 than under 
    Windows 3.1.  Further, under Windows 3.0, neither of the floodfill 
    routines apply fill masks (i.e.:  areas filled are always filled with 
    solid colors).

      On systems with EGA adapters, graphics color #7 (white) is actually a 
    combination of two other colors (gray and bright white).  Because of 
    this, any floodfill call (under Windows 3.0 and an EGA adapter) which 
    uses color #7 as either its boundary color or fill color produces 
    improper results.  This also applies to any other such composite colors 
    which might be produced by non-standard graphics adapters.


    EGA TEXT COLOR #7 IS THE SAME AS TEXT COLOR #8

      On systems with EGA adapters, text color #7 (white) actually appears 
    the same as text color #8 (gray).


    SETTING TEXT COLORS ON MACHINES WITH MONOCHROME ADAPTERS

      The following applies only to computers with monochrome graphics
    adapters.  Under GRAPHICS.LIB, calling settextcolor with the index of
    any color other than black sets the text color to white.  Under QuickWin
    Graphics, only the following text color indices set the text color to
    white:  7, 11, 13, 14, 15, 23, 27, 29, 30, 31.


    DRAWING GRAPHICS OUTSIDE A VIEWPORT DOES NOT RETURN 0

      Under GRAPHICS.LIB, attempting to draw graphics elements which are 
    entirely outside a viewport yields a return code of 0 from the graphics
    call.  Under QuickWin Graphics, such calls return 1 (as if the element
    had been successfully drawn).


    DRAWING LINES AND RECTANGLES PAST A GCW's CLIPPING REGION WITH MONOCHROME
    ADAPTERS

      The following applies only to computers with monochrome graphics
    adapters.  Drawing a line or rectangle which cannot be completely
    contained in the current clipping region of the GCW when the call is made
    causes incomplete results.


    RETURNING FROM AN ICONIZED GCW BEING VIEWED IN FULL SCREEN MODE AFTER 
    PROGRAM TERMINATION

      If a program's active GCW is both iconized and being viewed in Full 
    Screen mode when the program terminates, the Escape key will not revert 
    back to the QuickWin Graphics application.  Instead, a mouse click must 
    be used.  The Ctrl+Esc key sequence will also still bring up the Windows 
    Task List, allowing the program to be terminated from there.

      This is only applicable if a 'No' response is given to the 'Program
    Terminated... Close Window?' message box which appears at the end of a
    QuickWin Graphics application.


    LINKING NOIGNORECASE

      You cannot link a QuickWin Graphics program with the NOIGNORECASE link
    option (i.e.:  /link /NOI).  Doing so causes an Unresolved External
    Linker error.
    
    
    CALLING YIELDQQ

      If you make any calls to YIELDQQ within a loop, it is necessary to 
    compile your program with the /MW0 switch.


-----------------------------------------------------------------------------
