# modified_zork1

This is a Zork 1 with unlimited carrying capacity and light from the lantern.

Changed LOAD-MAX and LOAD-ALLOWED from 100 to 10.000.  
Changed FUMBLE-NUMBER from 7 to 700.  
Changed First number in LAMP-TABLE from 100 to 10.000.  
Added X as synonym for EXAMINE.

    <GLOBAL LOAD-MAX 10000>

    <GLOBAL LOAD-ALLOWED 10000>

    <GLOBAL FUMBLE-NUMBER 700>

    <GLOBAL LAMP-TABLE
    	<TABLE (PURE)
	           10000
	           "The lamp appears a bit dimmer."
    	       70
	           "The lamp is definitely dimmer now."
	           15   
    	       "The lamp is nearly out."
	           0>>
		   
    <SYNONYM EXAMINE DESCRIBE WHAT WHATS X>      
   
