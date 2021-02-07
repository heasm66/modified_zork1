;"ZORK1 for
	        Zork I: The Great Underground Empire
	(c) Copyright 1983 Infocom, Inc.  All Rights Reserved."

;"Settings"

<CONSTANT RELEASEID 2>
<VERSION ZIP>
<FREQUENT-WORDS?>
<SETG ZORK-NUMBER 1>

;"Default Property Values"

<PROPDEF SIZE 5>
<PROPDEF CAPACITY 0>
<PROPDEF VALUE 0>
<PROPDEF TVALUE 0>

;-------------------------------------------------------
"MAIN"
;-------------------------------------------------------
			"Generic MAIN file for
			    The ZORK Trilogy
		       started on 7/28/83 by MARC"

<CONSTANT SERIAL 0>

<GLOBAL PLAYER <>>

<GLOBAL P-WON <>>

<CONSTANT M-FATAL 2>
 
<CONSTANT M-HANDLED 1>   
 
<CONSTANT M-NOT-HANDLED <>>   
 
<CONSTANT M-OBJECT <>>

<CONSTANT M-BEG 1>  
 
<CONSTANT M-END 6> 
 
<CONSTANT M-ENTER 2>
 
<CONSTANT M-LOOK 3> 
 
<CONSTANT M-FLASH 4>

<CONSTANT M-OBJDESC 5>

;"GO now lives in SPECIAL.ZIL"    


<ROUTINE MAIN-LOOP ("AUX" TRASH)
	 <REPEAT ()
		 <SET TRASH <MAIN-LOOP-1>>>>

<ROUTINE MAIN-LOOP-1 ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP O I) 
     <SET CNT 0>
     <SET OBJ <>>
     <SET PTBL T>
     <COND (<SETG P-WON <PARSER>>
	    <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	    <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
	    <COND (<AND ,P-IT-OBJECT <ACCESSIBLE? ,P-IT-OBJECT>>
		   <SET TMP <>>
		   <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .ICNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSI .CNT> ,IT>
					 <PUT ,P-PRSI .CNT ,P-IT-OBJECT>
					 <SET TMP T>
					 <RETURN>)>)>>
		   <COND (<NOT .TMP>
			  <SET CNT 0>
			  <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .OCNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSO .CNT> ,IT>
					 <PUT ,P-PRSO .CNT ,P-IT-OBJECT>
					 <RETURN>)>)>>)>
		   <SET CNT 0>)>
	    <SET NUM
		 <COND (<0? .OCNT> .OCNT)
		       (<G? .OCNT 1>
			<SET TBL ,P-PRSO>
			<COND (<0? .ICNT> <SET OBJ <>>)
			      (T <SET OBJ <GET ,P-PRSI 1>>)>
			.OCNT)
		       (<G? .ICNT 1>
			<SET PTBL <>>
			<SET TBL ,P-PRSI>
			<SET OBJ <GET ,P-PRSO 1>>
			.ICNT)
		       (T 1)>>
	    <COND (<AND <NOT .OBJ> <1? .ICNT>> <SET OBJ <GET ,P-PRSI 1>>)>
	    <COND (<AND <==? ,PRSA ,V?WALK>
			<NOT <ZERO? ,P-WALK-DIR>>>
		   <SET V <PERFORM ,PRSA ,PRSO>>)
		  (<0? .NUM>
		   <COND (<0? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
			  <SET V <PERFORM ,PRSA>>
			  <SETG PRSO <>>)
			 (<NOT ,LIT>
			  <TELL "It's too dark to see." CR>)
			 (T
			  <TELL "It's not clear what you're referring to." CR>
			  <SET V <>>)>)
		  (T
		   <SETG P-NOT-HERE 0>
		   <SETG P-MULT <>>
		   <COND (<G? .NUM 1> <SETG P-MULT T>)>
		   <SET TMP <>>
		   <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
				  <COND (<G? ,P-NOT-HERE 0>
					 <TELL "The ">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE .NUM>>
						<TELL "other ">)>
					 <TELL "object">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
						<TELL "s">)>
					 <TELL " that you mentioned ">
					 <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
						<TELL "are">)
					       (T <TELL "is">)>
					 <TELL "n't here." CR>)
					(<NOT .TMP>
					 <TELL
"There's nothing here you can take." CR>)>
				  <RETURN>)
				 (T
				  <COND (.PTBL <SET OBJ1 <GET ,P-PRSO .CNT>>)
					(T <SET OBJ1 <GET ,P-PRSI .CNT>>)>
				  <SET O <COND (.PTBL .OBJ1) (T .OBJ)>>
				  <SET I <COND (.PTBL .OBJ) (T .OBJ1)>>

;"multiple exceptions"
<COND (<OR <G? .NUM 1>
	   <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0> ,W?ALL>>
       <SET V <LOC ,WINNER>>
       <COND (<EQUAL? .O ,NOT-HERE-OBJECT>
	      <SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>
	      <AGAIN>)
	     (<AND <VERB? TAKE>
		   .I
		   <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0> ,W?ALL>
		   <NOT <IN? .O .I>>>
	      <AGAIN>)
	     (<AND <EQUAL? ,P-GETFLAGS ,P-ALL>
		   <VERB? TAKE>
		   <OR <AND <NOT <EQUAL? <LOC .O> ,WINNER ,HERE .V>>
			    <NOT <EQUAL? <LOC .O> .I>>
			    <NOT <FSET? <LOC .O> ,SURFACEBIT>>>
		       <NOT <OR <FSET? .O ,TAKEBIT>
				<FSET? .O ,TRYTAKEBIT>>>>>
	      <AGAIN>)
	     (ELSE
	      <COND (<EQUAL? .OBJ1 ,IT>
		     <PRINTD ,P-IT-OBJECT>)
		    (T <PRINTD .OBJ1>)>
	      <TELL ": ">)>)>
;"end multiple exceptions"
				  <SETG PRSO .O>
				  <SETG PRSI .I>
				  <SET TMP T>
				  <SET V <PERFORM ,PRSA ,PRSO ,PRSI>>
				  <COND (<==? .V ,M-FATAL> <RETURN>)>)>>)>
	    <COND (<NOT <==? .V ,M-FATAL>>
		   ;<COND (<==? <LOC ,WINNER> ,PRSO>
			  <SETG PRSO <>>)>
		   <SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-END>>)>
	    ;<COND (<VERB? ;AGAIN ;"WALK -- why was this here?"
			  SAVE RESTORE ;SCORE ;VERSION ;WAIT> T)
		  (T
		   <SETG L-PRSA ,PRSA>
		   <SETG L-PRSO ,PRSO>
		   <SETG L-PRSI ,PRSI>)>
	    <COND (<==? .V ,M-FATAL> <SETG P-CONT <>>)>)
	   (T
	    <SETG P-CONT <>>)>
     %<COND (<==? ,ZORK-NUMBER 3>
	     '<COND (<NOT ,CLEFT-QUEUED?>
		     <ENABLE <QUEUE I-CLEFT <+ 70 <RANDOM 70>>>>
		     <SETG CLEFT-QUEUED? T>)>)
	    (ELSE '<NULL-F>)>
     <COND (,P-WON
	    <COND (<VERB? TELL BRIEF SUPER-BRIEF VERBOSE SAVE VERSION
			  QUIT RESTART SCORE SCRIPT UNSCRIPT RESTORE> T)
		  (T <SET V <CLOCKER>>)>)>>
 
<GLOBAL P-MULT <>>

<GLOBAL P-NOT-HERE 0>



%<COND (<GASSIGNED? PREDGEN>

'<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI) 
	;<COND (,DEBUG
	       <TELL "[Perform: ">
	       %<COND (<GASSIGNED? PREDGEN> '<TELL N .A>)
		      (T '<PRINC <NTH ,ACTIONS <+ <* .A 2> 1>>>)>
	       <COND (<AND .O <NOT <==? .A ,V?WALK>>>
		      <TELL "/" D .O>)>
	       <COND (.I <TELL "/" D .I>)>
	       <TELL "]" CR>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<COND (<AND <EQUAL? ,IT .I .O>
		    <NOT <ACCESSIBLE? ,P-IT-OBJECT>>>
	       <TELL "I don't see what you are referring to." CR>
	       <RFATAL>)>
	<COND (<==? .O ,IT> <SET O ,P-IT-OBJECT>)>
	<COND (<==? .I ,IT> <SET I ,P-IT-OBJECT>)>
	<SETG PRSA .A>
	<SETG PRSO .O>
	<COND (<AND ,PRSO <NOT <EQUAL? ,PRSI ,IT>> <NOT <VERB? WALK>>>
	       <SETG P-IT-OBJECT ,PRSO>)>
	<SETG PRSI .I>
	<COND (<AND <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V <NOT-HERE-OBJECT-F>>> .V)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <COND
		(<SET V <APPLY <GETP ,WINNER ,P?ACTION>>> .V)
		(<SET V <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-BEG>> .V)
		(<SET V <APPLY <GET ,PREACTIONS .A>>> .V)
		(<AND .I <SET V <APPLY <GETP .I ,P?ACTION>>>> .V)
		(<AND .O
		      <NOT <==? .A ,V?WALK>>
		      <LOC .O>
		      <SET V <APPLY <GETP <LOC .O> ,P?CONTFCN>>>>
		 .V)
		(<AND .O
		      <NOT <==? .A ,V?WALK>>
		      <SET V <APPLY <GETP .O ,P?ACTION>>>>
		 .V)
		(<SET V <APPLY <GET ,ACTIONS .A>>> .V)>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>)
       (T
	
'<PROG ()

<SETG DEBUG <>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI) 
	#DECL ((A) FIX (O) <OR FALSE OBJECT FIX> (I) <OR FALSE OBJECT> (V) ANY)
	<COND (,DEBUG
	       <TELL "** PERFORM: PRSA = ">
	       <PRINC <NTH ,ACTIONS <+ <* .A 2> 1>>>
	       <COND (<AND .O <NOT <==? .A ,V?WALK>>>
		      <TELL " | PRSO = " D .O>)>
	       <COND (.I <TELL " | PRSI = " D .I>)>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<COND (<AND <EQUAL? ,IT .I .O>
		    <NOT <ACCESSIBLE? ,P-IT-OBJECT>>>
	       <TELL "I don't see what you are referring to." CR>
	       <RFATAL>)>
	<COND (<==? .O ,IT> <SET O ,P-IT-OBJECT>)>
	<COND (<==? .I ,IT> <SET I ,P-IT-OBJECT>)>
	<SETG PRSA .A>
	<SETG PRSO .O>
	<COND (<AND ,PRSO <NOT <VERB? WALK>>>
	       <SETG P-IT-OBJECT ,PRSO>)>
	<SETG PRSI .I>
	<COND (<AND <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V <D-APPLY "Not Here" ,NOT-HERE-OBJECT-F>>> .V)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <COND (<SET V <DD-APPLY "Actor" ,WINNER
				      <GETP ,WINNER ,P?ACTION>>> .V)
		     (<SET V <D-APPLY "Room (M-BEG)"
				      <GETP <LOC ,WINNER> ,P?ACTION>
				      ,M-BEG>> .V)
		     (<SET V <D-APPLY "Preaction"
				      <GET ,PREACTIONS .A>>> .V)
		     (<AND .I <SET V <D-APPLY "PRSI"
					      <GETP .I ,P?ACTION>>>> .V)
		     (<AND .O
			   <NOT <==? .A ,V?WALK>>
			   <LOC .O>
			   <GETP <LOC .O> ,P?CONTFCN>
			   <SET V <DD-APPLY "Container" <LOC .O>
					   <GETP <LOC .O> ,P?CONTFCN>>>>
		      .V)
		     (<AND .O
			   <NOT <==? .A ,V?WALK>>
			   <SET V <D-APPLY "PRSO"
					   <GETP .O ,P?ACTION>>>>
		      .V)
		     (<SET V <D-APPLY <>
				      <GET ,ACTIONS .A>>> .V)>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

<DEFINE D-APPLY (STR FCN "OPTIONAL" FOO "AUX" RES)
	<COND (<NOT .FCN> <>)
	      (T
	       <COND (,DEBUG
		      <COND (<NOT .STR>
			     <TELL CR "  Default ->" CR>)
			    (T <TELL CR "  " .STR " -> ">)>)>
	       <SET RES
		    <COND (<ASSIGNED? FOO>
			   <APPLY .FCN .FOO>)
			  (T <APPLY .FCN>)>>
	       <COND (<AND ,DEBUG .STR>
		      <COND (<==? .RES 2>
			     <TELL "Fatal" CR>)
			    (<NOT .RES>
			     <TELL "Not handled">)
			    (T <TELL "Handled" CR>)>)>
	       .RES)>>

<ROUTINE DD-APPLY (STR OBJ FCN "OPTIONAL" (FOO <>))
	<COND (,DEBUG <TELL "[" D .OBJ "=]">)>
	<D-APPLY .STR .FCN .FOO>>
>)>

;-------------------------------------------------------
"CLOCK"
;-------------------------------------------------------
"GCLOCK for
			    The Zork Trilogy
	 (c) Copyright 1983 Infocom, Inc.  All Rights Reserved"

<CONSTANT C-TABLELEN 180>

<GLOBAL C-TABLE <ITABLE NONE 180>>

<GLOBAL C-DEMONS 180>

<GLOBAL C-INTS 180>

<CONSTANT C-INTLEN 6>

<CONSTANT C-ENABLED? 0>

<CONSTANT C-TICK 1>

<CONSTANT C-RTN 2>

<ROUTINE QUEUE (RTN TICK "AUX" CINT)
	 #DECL ((RTN) ATOM (TICK) FIX (CINT) <PRIMTYPE VECTOR>)
	 <PUT <SET CINT <INT .RTN>> ,C-TICK .TICK>
	 .CINT>

<ROUTINE INT (RTN "OPTIONAL" (DEMON <>) E C INT)
	 #DECL ((RTN) ATOM (DEMON) <OR ATOM FALSE> (E C INT) <PRIMTYPE
							      VECTOR>)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<==? .C .E>
			<SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			<AND .DEMON <SETG C-DEMONS <- ,C-DEMONS ,C-INTLEN>>>
			<SET INT <REST ,C-TABLE ,C-INTS>>
			<PUT .INT ,C-RTN .RTN>
			<RETURN .INT>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN> <RETURN .C>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<GLOBAL CLOCK-WAIT <>>

<ROUTINE CLOCKER ("AUX" C E TICK (FLG <>))
	 #DECL ((C E) <PRIMTYPE VECTOR> (TICK) FIX (FLG) <OR FALSE ATOM>)
	 <COND (,CLOCK-WAIT <SETG CLOCK-WAIT <>> <RFALSE>)>
	 <SET C <REST ,C-TABLE <COND (,P-WON ,C-INTS) (T ,C-DEMONS)>>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <REPEAT ()
		 <COND (<==? .C .E>
			<SETG MOVES <+ ,MOVES 1>>
			<RETURN .FLG>)
		       (<NOT <0? <GET .C ,C-ENABLED?>>>
			<SET TICK <GET .C ,C-TICK>>
			<COND (<0? .TICK>)
			      (T
			       <PUT .C ,C-TICK <- .TICK 1>>
			       <COND (<AND <NOT <G? .TICK 1>>
					   <APPLY <GET .C ,C-RTN>>>
				      <SET FLG T>)>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

;-------------------------------------------------------
"PARSER"
;-------------------------------------------------------
			"Generic PARSER file for
			    The ZORK Trilogy
		       started on 7/28/83 by MARC"

;"WHICH and TRAP retrofixes installed"

"Parser global variable convention:  All parser globals will
  begin with 'P-'.  Local variables are not restricted in any
  way.
"

<SETG SIBREAKS ".,\"">

<GLOBAL PRSA <>>
<GLOBAL PRSI <>>
<GLOBAL PRSO <>>

<GLOBAL P-TABLE 0>
<GLOBAL P-ONEOBJ 0>
<GLOBAL P-SYNTAX 0>

<GLOBAL P-CCTBL <TABLE 0 0 0 0>>
;"pointers used by CLAUSE-COPY (source/destination beginning/end pointers)"
<CONSTANT CC-SBPTR 0>
<CONSTANT CC-SEPTR 1>
<CONSTANT CC-DBPTR 2>
<CONSTANT CC-DEPTR 3>

<GLOBAL P-LEN 0>
<GLOBAL P-DIR 0>
<GLOBAL HERE 0>
<GLOBAL WINNER 0>

<GLOBAL P-LEXV
	<ITABLE 59 (LEXV) 0 #BYTE 0 #BYTE 0> ;<ITABLE BYTE 120>>
<GLOBAL AGAIN-LEXV
	<ITABLE 59 (LEXV) 0 #BYTE 0 #BYTE 0> ;<ITABLE BYTE 120>>
<GLOBAL RESERVE-LEXV
	<ITABLE 59 (LEXV) 0 #BYTE 0 #BYTE 0> ;<ITABLE BYTE 120>>
<GLOBAL RESERVE-PTR <>>

;"INBUF - Input buffer for READ"

<GLOBAL P-INBUF
	<ITABLE 120 (BYTE LENGTH) 0>
	;<ITABLE BYTE 60>>
<GLOBAL OOPS-INBUF
	<ITABLE 120 (BYTE LENGTH) 0>
	;<ITABLE BYTE 60>>
<GLOBAL OOPS-TABLE <TABLE <> <> <> <>>>
<CONSTANT O-PTR 0>	"word pointer to unknown token in P-LEXV"
<CONSTANT O-START 1>	"word pointer to sentence start in P-LEXV"
<CONSTANT O-LENGTH 2>	"byte length of unparsed tokens in P-LEXV"
<CONSTANT O-END 3>	"byte pointer to first free byte in OOPS-INBUF"

;"Parse-cont variable"

<GLOBAL P-CONT <>>
<GLOBAL P-IT-OBJECT <>>
;<GLOBAL LAST-PSEUDO-LOC <>>

;"Orphan flag"

<GLOBAL P-OFLAG <>>
<GLOBAL P-MERGED <>>
<GLOBAL P-ACLAUSE <>>
<GLOBAL P-ANAM <>>
<GLOBAL P-AADJ <>>
;"Parser variables and temporaries"

;"Byte offset to # of entries in LEXV"

<CONSTANT P-LEXWORDS 1> ;"Word offset to start of LEXV entries"
<CONSTANT P-LEXSTART 1> ;"Number of words per LEXV entry"
<CONSTANT P-LEXELEN 2>
<CONSTANT P-WORDLEN 4> ;"Offset to parts of speech byte"

<CONSTANT P-PSOFF 4> ;"Offset to first part of speech"
<CONSTANT P-P1OFF 5> ;"First part of speech bit mask in PSOFF byte"
<CONSTANT P-P1BITS 3>

<CONSTANT P-ITBLLEN 9>
<GLOBAL P-ITBL <TABLE 0 0 0 0 0 0 0 0 0 0>>
<GLOBAL P-OTBL <TABLE 0 0 0 0 0 0 0 0 0 0>>
<GLOBAL P-VTBL <TABLE 0 0 0 0>>
<GLOBAL P-OVTBL <TABLE 0 #BYTE 0 #BYTE 0>>

<GLOBAL P-NCN 0>

<CONSTANT P-VERB 0>
<CONSTANT P-VERBN 1>
<CONSTANT P-PREP1 2>
<CONSTANT P-PREP1N 3>
<CONSTANT P-PREP2 4>
<CONSTANT P-PREP2N 5>
<CONSTANT P-NC1 6>
<CONSTANT P-NC1L 7>
<CONSTANT P-NC2 8>
<CONSTANT P-NC2L 9>

<GLOBAL QUOTE-FLAG <>>
<GLOBAL P-END-ON-PREP <>>

" Grovel down the input finding the verb, prepositions, and noun clauses.
   If the input is <direction> or <walk> <direction>, fall out immediately
   setting PRSA to ,V?WALK and PRSO to <direction>.  Otherwise, perform
   all required orphaning, syntax checking, and noun clause lookup."

<ROUTINE PARSER ("AUX" (PTR ,P-LEXSTART) WRD (VAL 0) (VERB <>) (OF-FLAG <>)
		       OWINNER OMERGED LEN (DIR <>) (NW 0) (LW 0) (CNT -1))
	<REPEAT ()
		<COND (<G? <SET CNT <+ .CNT 1>> ,P-ITBLLEN> <RETURN>)
		      (T
		       <COND (<NOT ,P-OFLAG>
			      <PUT ,P-OTBL .CNT <GET ,P-ITBL .CNT>>)>
		       <PUT ,P-ITBL .CNT 0>)>>
	<SET OWINNER ,WINNER>
	<SET OMERGED ,P-MERGED>
	<SETG P-ADVERB <>>
	<SETG P-MERGED <>>
	<SETG P-END-ON-PREP <>>
	<PUT ,P-PRSO ,P-MATCHLEN 0>
	<PUT ,P-PRSI ,P-MATCHLEN 0>
	<PUT ,P-BUTS ,P-MATCHLEN 0>
	<COND (<AND <NOT ,QUOTE-FLAG> <N==? ,WINNER ,PLAYER>>
	       <SETG WINNER ,PLAYER>
	       <SETG HERE <META-LOC ,PLAYER>>
	       ;<COND (<NOT <FSET? <LOC ,WINNER> ,VEHBIT>>
		      <SETG HERE <LOC ,WINNER>>)>
	       <SETG LIT <LIT? ,HERE>>)>
	<COND (,RESERVE-PTR
	       <SET PTR ,RESERVE-PTR>
	       <STUFF ,RESERVE-LEXV ,P-LEXV>
	       <COND (<AND <NOT ,SUPER-BRIEF> <EQUAL? ,PLAYER ,WINNER>>
		      <CRLF>)>
	       <SETG RESERVE-PTR <>>
	       <SETG P-CONT <>>)
	      (,P-CONT
	       <SET PTR ,P-CONT>
	       <COND (<AND <NOT ,SUPER-BRIEF>
			   <EQUAL? ,PLAYER ,WINNER>
			   <NOT <VERB? SAY>>>
		      <CRLF>)>
	       <SETG P-CONT <>>)
	      (T
	       <SETG WINNER ,PLAYER>
	       <SETG QUOTE-FLAG <>>
	       <COND (<NOT <FSET? <LOC ,WINNER> ,VEHBIT>>
		      <SETG HERE <LOC ,WINNER>>)>
	       <SETG LIT <LIT? ,HERE>>
	       <COND (<NOT ,SUPER-BRIEF> <CRLF>)>
	       <TELL ">">
	       <READ ,P-INBUF ,P-LEXV>)>
	<SETG P-LEN <GETB ,P-LEXV ,P-LEXWORDS>>
	<COND (<ZERO? ,P-LEN> <TELL "I beg your pardon?" CR> <RFALSE>)>
	<COND (<EQUAL? <SET WRD <GET ,P-LEXV .PTR>> ,W?OOPS>
	       <COND (<EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
			      ,W?PERIOD ,W?COMMA>
		      <SET PTR <+ .PTR ,P-LEXELEN>>
		      <SETG P-LEN <- ,P-LEN 1>>)>
	       <COND (<NOT <G? ,P-LEN 1>>
		      <TELL "I can't help your clumsiness." CR>
		      <RFALSE>)
		     (<GET ,OOPS-TABLE ,O-PTR>
		      <COND (<AND <G? ,P-LEN 2>
				  <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					  ,W?QUOTE>>
			     <TELL
"Sorry, you can't correct mistakes in quoted text." CR>
			     <RFALSE>)
			    (<G? ,P-LEN 2>
			     <TELL
"Warning: only the first word after OOPS is used." CR>)>
		      <PUT ,AGAIN-LEXV <GET ,OOPS-TABLE ,O-PTR>
			   <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>
		      <SETG WINNER .OWINNER> ;"maybe fix oops vs. chars.?"
		      <INBUF-ADD <GETB ,P-LEXV <+ <* .PTR ,P-LEXELEN> 6>>
				 <GETB ,P-LEXV <+ <* .PTR ,P-LEXELEN> 7>>
				 <+ <* <GET ,OOPS-TABLE ,O-PTR> ,P-LEXELEN> 3>>
		      <STUFF ,AGAIN-LEXV ,P-LEXV>
		      <SETG P-LEN <GETB ,P-LEXV ,P-LEXWORDS>>
		      <SET PTR <GET ,OOPS-TABLE ,O-START>>
		      <INBUF-STUFF ,OOPS-INBUF ,P-INBUF>)
		     (T
		      <PUT ,OOPS-TABLE ,O-END <>>
		      <TELL "There was no word to replace!" CR>
		      <RFALSE>)>)
	      (T
	       <COND (<NOT <EQUAL? .WRD ,W?AGAIN ,W?G>>
		      <SETG P-NUMBER 0>)>
	       <PUT ,OOPS-TABLE ,O-END <>>)>
	<COND (<EQUAL? <GET ,P-LEXV .PTR> ,W?AGAIN ,W?G>
	       <COND (<ZERO? <GETB ,OOPS-INBUF 1>>
		      <TELL "Beg pardon?" CR>
		      <RFALSE>)
		     (,P-OFLAG
		      <TELL "It's difficult to repeat fragments." CR>
		      <RFALSE>)
		     (<NOT ,P-WON>
		      <TELL "That would just repeat a mistake." CR>
		      <RFALSE>)
		     (<G? ,P-LEN 1>
		      <COND (<OR <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					,W?PERIOD ,W?COMMA ,W?THEN>
				 <EQUAL? <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>
					,W?AND>>
			     <SET PTR <+ .PTR <* 2 ,P-LEXELEN>>>
			     <PUTB ,P-LEXV ,P-LEXWORDS
				   <- <GETB ,P-LEXV ,P-LEXWORDS> 2>>)
			    (T
			     <TELL "I couldn't understand that sentence." CR>
			     <RFALSE>)>)
		     (T
		      <SET PTR <+ .PTR ,P-LEXELEN>>
		      <PUTB ,P-LEXV ,P-LEXWORDS
			    <- <GETB ,P-LEXV ,P-LEXWORDS> 1>>)>
	       <COND (<G? <GETB ,P-LEXV ,P-LEXWORDS> 0>
		      <STUFF ,P-LEXV ,RESERVE-LEXV>
		      <SETG RESERVE-PTR .PTR>)
		     (T
		      <SETG RESERVE-PTR <>>)>
	       ;<SETG P-LEN <GETB ,AGAIN-LEXV ,P-LEXWORDS>>
	       <SETG WINNER .OWINNER>
	       <SETG P-MERGED .OMERGED>
	       <INBUF-STUFF ,OOPS-INBUF ,P-INBUF>
	       <STUFF ,AGAIN-LEXV ,P-LEXV>
	       <SET CNT -1>
	       <SET DIR ,AGAIN-DIR>
	       <REPEAT ()
		<COND (<IGRTR? CNT ,P-ITBLLEN> <RETURN>)
		      (T <PUT ,P-ITBL .CNT <GET ,P-OTBL .CNT>>)>>)
	      (T
	       <STUFF ,P-LEXV ,AGAIN-LEXV>
	       <INBUF-STUFF ,P-INBUF ,OOPS-INBUF>
	       <PUT ,OOPS-TABLE ,O-START .PTR>
	       <PUT ,OOPS-TABLE ,O-LENGTH <* 4 ,P-LEN>>
	       <SET LEN
		    <* 2 <+ .PTR <* ,P-LEXELEN <GETB ,P-LEXV ,P-LEXWORDS>>>>>
	       <PUT ,OOPS-TABLE ,O-END <+ <GETB ,P-LEXV <- .LEN 1>>
					  <GETB ,P-LEXV <- .LEN 2>>>>
	       <SETG RESERVE-PTR <>>
	       <SET LEN ,P-LEN>
	       <SETG P-DIR <>>
	       <SETG P-NCN 0>
	       <SETG P-GETFLAGS 0>
	       <REPEAT ()
		<COND (<L? <SETG P-LEN <- ,P-LEN 1>> 0>
		       <SETG QUOTE-FLAG <>>
		       <RETURN>)
		      (<OR <SET WRD <GET ,P-LEXV .PTR>>
			   <SET WRD <NUMBER? .PTR>>>
		       <COND (<ZERO? ,P-LEN> <SET NW 0>)
			     (T <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>)>
		       <COND (<AND <EQUAL? .WRD ,W?TO>
				   <EQUAL? .VERB ,ACT?TELL ;,ACT?ASK>>
			      <SET WRD ,W?QUOTE>)
			     (<AND <EQUAL? .WRD ,W?THEN>
				   <G? ,P-LEN 0>
				   <NOT .VERB>
				   <NOT ,QUOTE-FLAG> ;"Last NOT added 7/3">
			      <COND (<EQUAL? .LW 0 ,W?PERIOD>
				     <SET WRD ,W?THE>)
				    (ELSE
				     <PUT ,P-ITBL ,P-VERB ,ACT?TELL>
				     <PUT ,P-ITBL ,P-VERBN 0>
				     <SET WRD ,W?QUOTE>)>)>
		       <COND (<EQUAL? .WRD ,W?THEN ,W?PERIOD ,W?QUOTE>
			      <COND (<EQUAL? .WRD ,W?QUOTE>
				     <COND (,QUOTE-FLAG
					    <SETG QUOTE-FLAG <>>)
					   (T <SETG QUOTE-FLAG T>)>)>
			      <OR <ZERO? ,P-LEN>
				  <SETG P-CONT <+ .PTR ,P-LEXELEN>>>
			      <PUTB ,P-LEXV ,P-LEXWORDS ,P-LEN>
			      <RETURN>)
			     (<AND <SET VAL
					<WT? .WRD
					     ,PS?DIRECTION
					     ,P1?DIRECTION>>
				   <EQUAL? .VERB <> ,ACT?WALK>
				   <OR <EQUAL? .LEN 1>
				       <AND <EQUAL? .LEN 2>
					    <EQUAL? .VERB ,ACT?WALK>>
				       <AND <EQUAL? .NW
					            ,W?THEN
					            ,W?PERIOD
					            ,W?QUOTE>
					    <NOT <L? .LEN 2>>>
				       <AND ,QUOTE-FLAG
					    <EQUAL? .LEN 2>
					    <EQUAL? .NW ,W?QUOTE>>
				       <AND <G? .LEN 2>
					    <EQUAL? .NW ,W?COMMA ,W?AND>>>>
			      <SET DIR .VAL>
			      <COND (<EQUAL? .NW ,W?COMMA ,W?AND>
				     <PUT ,P-LEXV
					  <+ .PTR ,P-LEXELEN>
					  ,W?THEN>)>
			      <COND (<NOT <G? .LEN 2>>
				     <SETG QUOTE-FLAG <>>
				     <RETURN>)>)
			     (<AND <SET VAL <WT? .WRD ,PS?VERB ,P1?VERB>>
				   <NOT .VERB>>
			      <SET VERB .VAL>
			      <PUT ,P-ITBL ,P-VERB .VAL>
			      <PUT ,P-ITBL ,P-VERBN ,P-VTBL>
			      <PUT ,P-VTBL 0 .WRD>
			      <PUTB ,P-VTBL 2 <GETB ,P-LEXV
						    <SET CNT
							 <+ <* .PTR 2> 2>>>>
			      <PUTB ,P-VTBL 3 <GETB ,P-LEXV <+ .CNT 1>>>)
			     (<OR <SET VAL <WT? .WRD ,PS?PREPOSITION 0>>
				  <EQUAL? .WRD ,W?ALL ,W?ONE ;,W?BOTH>
				  <WT? .WRD ,PS?ADJECTIVE>
				  <WT? .WRD ,PS?OBJECT>>
			      <COND (<AND <G? ,P-LEN 1>
					  <EQUAL? .NW ,W?OF>
					  <ZERO? .VAL>
					  <NOT <EQUAL? .WRD
						       ,W?ALL ,W?ONE ,W?A>>
					  ;<NOT <EQUAL? .WRD ,W?BOTH>>>
				     <SET OF-FLAG T>)
				    (<AND <NOT <ZERO? .VAL>>
				          <OR <ZERO? ,P-LEN>
					      <EQUAL? .NW ,W?THEN ,W?PERIOD>>>
				     <SETG P-END-ON-PREP T>
				     <COND (<L? ,P-NCN 2>
					    <PUT ,P-ITBL ,P-PREP1 .VAL>
					    <PUT ,P-ITBL ,P-PREP1N .WRD>)>)
				    (<EQUAL? ,P-NCN 2>
				     <TELL
"There were too many nouns in that sentence." CR>
				     <RFALSE>)
				    (T
				     <SETG P-NCN <+ ,P-NCN 1>>
				     <SETG P-ACT .VERB>
				     <OR <SET PTR <CLAUSE .PTR .VAL .WRD>>
					 <RFALSE>>
				     <COND (<L? .PTR 0>
					    <SETG QUOTE-FLAG <>>
					    <RETURN>)>)>)
			     (<EQUAL? .WRD ,W?OF>
			      <COND (<OR <NOT .OF-FLAG>
					 <EQUAL? .NW ,W?PERIOD ,W?THEN>>
				     <CANT-USE .PTR>
				     <RFALSE>)
				    (T
				     <SET OF-FLAG <>>)>)
			     (<WT? .WRD ,PS?BUZZ-WORD>)
			     (<AND <EQUAL? .VERB ,ACT?TELL>
				   <WT? .WRD ,PS?VERB ,P1?VERB>
				   <EQUAL? ,WINNER ,PLAYER>>
			      <TELL
"Please consult your manual for the correct way to talk to other people
or creatures." CR>
			      <RFALSE>)
			     (T
			      <CANT-USE .PTR>
			      <RFALSE>)>)
		      (T
		       <UNKNOWN-WORD .PTR>
		       <RFALSE>)>
		<SET LW .WRD>
		<SET PTR <+ .PTR ,P-LEXELEN>>>)>
	<PUT ,OOPS-TABLE ,O-PTR <>>
	<COND (.DIR
	       <SETG PRSA ,V?WALK>
	       <SETG PRSO .DIR>
	       <SETG P-OFLAG <>>
	       <SETG P-WALK-DIR .DIR>
	       <SETG AGAIN-DIR .DIR>)
	      (ELSE
	       <COND (,P-OFLAG <ORPHAN-MERGE>)>
	       <SETG P-WALK-DIR <>>
	       <SETG AGAIN-DIR <>>
	       <COND (<AND <SYNTAX-CHECK>
			   <SNARF-OBJECTS>
			   <MANY-CHECK>
			   <TAKE-CHECK>>
		      T)>)>>

<GLOBAL P-ACT <>>
<GLOBAL P-WALK-DIR <>>
<GLOBAL AGAIN-DIR <>>

;"For AGAIN purposes, put contents of one LEXV table into another."
<ROUTINE STUFF (SRC DEST "OPTIONAL" (MAX 29) "AUX" (PTR ,P-LEXSTART) (CTR 1)
						   BPTR)
	 <PUTB .DEST 0 <GETB .SRC 0>>
	 <PUTB .DEST 1 <GETB .SRC 1>>
	 <REPEAT ()
	  <PUT .DEST .PTR <GET .SRC .PTR>>
	  <SET BPTR <+ <* .PTR 2> 2>>
	  <PUTB .DEST .BPTR <GETB .SRC .BPTR>>
	  <SET BPTR <+ <* .PTR 2> 3>>
	  <PUTB .DEST .BPTR <GETB .SRC .BPTR>>
	  <SET PTR <+ .PTR ,P-LEXELEN>>
	  <COND (<IGRTR? CTR .MAX>
		 <RETURN>)>>>

;"Put contents of one INBUF into another"
<ROUTINE INBUF-STUFF (SRC DEST "AUX" CNT)
	 <SET CNT <- <GETB .SRC 0> 1>>
	 <REPEAT ()
		 <PUTB .DEST .CNT <GETB .SRC .CNT>>
		 <COND (<DLESS? CNT 0> <RETURN>)>>>

;"Put the word in the positions specified from P-INBUF to the end of
OOPS-INBUF, leaving the appropriate pointers in AGAIN-LEXV"
<ROUTINE INBUF-ADD (LEN BEG SLOT "AUX" DBEG (CTR 0) TMP)
	 <COND (<SET TMP <GET ,OOPS-TABLE ,O-END>>
		<SET DBEG .TMP>)
	       (T
		<SET DBEG <+ <GETB ,AGAIN-LEXV
				   <SET TMP <GET ,OOPS-TABLE ,O-LENGTH>>>
			     <GETB ,AGAIN-LEXV <+ .TMP 1>>>>)>
	 <PUT ,OOPS-TABLE ,O-END <+ .DBEG .LEN>>
	 <REPEAT ()
	  <PUTB ,OOPS-INBUF <+ .DBEG .CTR> <GETB ,P-INBUF <+ .BEG .CTR>>>
	  <SET CTR <+ .CTR 1>>
	  <COND (<EQUAL? .CTR .LEN> <RETURN>)>>
	 <PUTB ,AGAIN-LEXV .SLOT .DBEG>
	 <PUTB ,AGAIN-LEXV <- .SLOT 1> .LEN>>

;"Check whether word pointed at by PTR is the correct part of speech.
   The second argument is the part of speech (,PS?<part of speech>).  The
   3rd argument (,P1?<part of speech>), if given, causes the value
   for that part of speech to be returned."

<ROUTINE WT? (PTR BIT "OPTIONAL" (B1 5) "AUX" (OFFS ,P-P1OFF) TYP)
	<COND (<BTST <SET TYP <GETB .PTR ,P-PSOFF>> .BIT>
	       <COND (<G? .B1 4> <RTRUE>)
		     (T
		      <SET TYP <BAND .TYP ,P-P1BITS>>
		      <COND (<NOT <EQUAL? .TYP .B1>> <SET OFFS <+ .OFFS 1>>)>
		      <GETB .PTR .OFFS>)>)>>

;" Scan through a noun clause, leave a pointer to its starting location"

<ROUTINE CLAUSE (PTR VAL WRD "AUX" OFF NUM (ANDFLG <>) (FIRST?? T) NW (LW 0))
	<SET OFF <* <- ,P-NCN 1> 2>>
	<COND (<NOT <EQUAL? .VAL 0>>
	       <PUT ,P-ITBL <SET NUM <+ ,P-PREP1 .OFF>> .VAL>
	       <PUT ,P-ITBL <+ .NUM 1> .WRD>
	       <SET PTR <+ .PTR ,P-LEXELEN>>)
	      (T <SETG P-LEN <+ ,P-LEN 1>>)>
	<COND (<ZERO? ,P-LEN> <SETG P-NCN <- ,P-NCN 1>> <RETURN -1>)>
	<PUT ,P-ITBL <SET NUM <+ ,P-NC1 .OFF>> <REST ,P-LEXV <* .PTR 2>>>
	<COND (<EQUAL? <GET ,P-LEXV .PTR> ,W?THE ,W?A ,W?AN>
	       <PUT ,P-ITBL .NUM <REST <GET ,P-ITBL .NUM> 4>>)>
	<REPEAT ()
		<COND (<L? <SETG P-LEN <- ,P-LEN 1>> 0>
		       <PUT ,P-ITBL <+ .NUM 1> <REST ,P-LEXV <* .PTR 2>>>
		       <RETURN -1>)>
		<COND (<OR <SET WRD <GET ,P-LEXV .PTR>>
			   <SET WRD <NUMBER? .PTR>>>
		       <COND (<ZERO? ,P-LEN> <SET NW 0>)
			     (T <SET NW <GET ,P-LEXV <+ .PTR ,P-LEXELEN>>>)>
		       <COND (<EQUAL? .WRD ,W?AND ,W?COMMA> <SET ANDFLG T>)
			     (<EQUAL? .WRD ,W?ALL ,W?ONE ;,W?BOTH>
			      <COND (<EQUAL? .NW ,W?OF>
				     <SETG P-LEN <- ,P-LEN 1>>
				     <SET PTR <+ .PTR ,P-LEXELEN>>)>)
			     (<OR <EQUAL? .WRD ,W?THEN ,W?PERIOD>
				  <AND <WT? .WRD ,PS?PREPOSITION>
				       <GET ,P-ITBL ,P-VERB>
				          ;"ADDED 4/27 FOR TURTLE,UP"
				       <NOT .FIRST??>>>
			      <SETG P-LEN <+ ,P-LEN 1>>
			      <PUT ,P-ITBL
				   <+ .NUM 1>
				   <REST ,P-LEXV <* .PTR 2>>>
			      <RETURN <- .PTR ,P-LEXELEN>>)
			     (<WT? .WRD ,PS?OBJECT>
			      <COND (<AND <G? ,P-LEN 0>
					  <EQUAL? .NW ,W?OF>
					  <NOT <EQUAL? .WRD ,W?ALL ,W?ONE>>>
				     T)
				    (<AND <WT? .WRD
					       ,PS?ADJECTIVE
					       ,P1?ADJECTIVE>
					  <NOT <EQUAL? .NW 0>>
					  <WT? .NW ,PS?OBJECT>>)
				    (<AND <NOT .ANDFLG>
					  <NOT <EQUAL? .NW ,W?BUT ,W?EXCEPT>>
					  <NOT <EQUAL? .NW ,W?AND ,W?COMMA>>>
				     <PUT ,P-ITBL
					  <+ .NUM 1>
					  <REST ,P-LEXV <* <+ .PTR 2> 2>>>
				     <RETURN .PTR>)
				    (T <SET ANDFLG <>>)>)
			     (<AND <OR ,P-MERGED
				       ,P-OFLAG
				       <NOT <EQUAL? <GET ,P-ITBL ,P-VERB> 0>>>
				   <OR <WT? .WRD ,PS?ADJECTIVE>
				       <WT? .WRD ,PS?BUZZ-WORD>>>)
			     (<AND .ANDFLG
				   <OR <WT? .WRD ,PS?DIRECTION>
				       <WT? .WRD ,PS?VERB>>>
			      <SET PTR <- .PTR 4>>
			      <PUT ,P-LEXV <+ .PTR 2> ,W?THEN>
			      <SETG P-LEN <+ ,P-LEN 2>>)
			     (<WT? .WRD ,PS?PREPOSITION> T)
			     (T
			      <CANT-USE .PTR>
			      <RFALSE>)>)
		      (T <UNKNOWN-WORD .PTR> <RFALSE>)>
		<SET LW .WRD>
		<SET FIRST?? <>>
		<SET PTR <+ .PTR ,P-LEXELEN>>>>

<ROUTINE NUMBER? (PTR "AUX" CNT BPTR CHR (SUM 0) (TIM <>))
	 <SET CNT <GETB <REST ,P-LEXV <* .PTR 2>> 2>>
	 <SET BPTR <GETB <REST ,P-LEXV <* .PTR 2>> 3>>
	 <REPEAT ()
		 <COND (<L? <SET CNT <- .CNT 1>> 0> <RETURN>)
		       (T
			<SET CHR <GETB ,P-INBUF .BPTR>>
			<COND (<EQUAL? .CHR 58>
			       <SET TIM .SUM>
			       <SET SUM 0>)
			      (<G? .SUM 10000> <RFALSE>)
			      (<AND <L? .CHR 58> <G? .CHR 47>>
			       <SET SUM <+ <* .SUM 10> <- .CHR 48>>>)
			      (T <RFALSE>)>
			<SET BPTR <+ .BPTR 1>>)>>
	 <PUT ,P-LEXV .PTR ,W?INTNUM>
	 <COND (<G? .SUM 1000> <RFALSE>)
	       (.TIM
		<COND (<L? .TIM 8> <SET TIM <+ .TIM 12>>)
		      (<G? .TIM 23> <RFALSE>)>
		<SET SUM <+ .SUM <* .TIM 60>>>)>
	 <SETG P-NUMBER .SUM>
	 ,W?INTNUM>

<GLOBAL P-NUMBER 0>

<GLOBAL P-DIRECTION 0>


;"New ORPHAN-MERGE for TRAP Retrofix 6/21/84"

<ROUTINE ORPHAN-MERGE ("AUX" (CNT -1) TEMP VERB BEG END (ADJ <>) WRD)
   <SETG P-OFLAG <>>
   <COND (<OR <EQUAL? <WT? <SET WRD <GET <GET ,P-ITBL ,P-VERBN> 0>>
			   ,PS?VERB ,P1?VERB>
		      <GET ,P-OTBL ,P-VERB>>
	      <NOT <ZERO? <WT? .WRD ,PS?ADJECTIVE>>>>
	  <SET ADJ T>)
	 (<AND <NOT <ZERO? <WT? .WRD ,PS?OBJECT ,P1?OBJECT>>>
	       <EQUAL? ,P-NCN 0>>
	  <PUT ,P-ITBL ,P-VERB 0>
	  <PUT ,P-ITBL ,P-VERBN 0>
	  <PUT ,P-ITBL ,P-NC1 <REST ,P-LEXV 2>>
	  <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>
	  <SETG P-NCN 1>)>
   <COND (<AND <NOT <ZERO? <SET VERB <GET ,P-ITBL ,P-VERB>>>>
	       <NOT .ADJ>
	       <NOT <EQUAL? .VERB <GET ,P-OTBL ,P-VERB>>>>
	  <RFALSE>)
	 (<EQUAL? ,P-NCN 2> <RFALSE>)
	 (<EQUAL? <GET ,P-OTBL ,P-NC1> 1>
	  <COND (<OR <EQUAL? <SET TEMP <GET ,P-ITBL ,P-PREP1>>
			  <GET ,P-OTBL ,P-PREP1>>
		     <ZERO? .TEMP>>
		 <COND (.ADJ
			<PUT ,P-OTBL ,P-NC1 <REST ,P-LEXV 2>>
			<COND (<ZERO? <GET ,P-ITBL ,P-NC1L>>
			       <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>)>
			<COND (<ZERO? ,P-NCN> <SETG P-NCN 1>)>)
		       (T
			<PUT ,P-OTBL ,P-NC1 <GET ,P-ITBL ,P-NC1>>)>
		 <PUT ,P-OTBL ,P-NC1L <GET ,P-ITBL ,P-NC1L>>)
		(T <RFALSE>)>)
	 (<EQUAL? <GET ,P-OTBL ,P-NC2> 1>
	  <COND (<OR <EQUAL? <SET TEMP <GET ,P-ITBL ,P-PREP1>>
			  <GET ,P-OTBL ,P-PREP2>>
		     <ZERO? .TEMP>>
		 <COND (.ADJ
			<PUT ,P-ITBL ,P-NC1 <REST ,P-LEXV 2>>
			<COND (<ZERO? <GET ,P-ITBL ,P-NC1L>>
			       <PUT ,P-ITBL ,P-NC1L <REST ,P-LEXV 6>>)>)>
		 <PUT ,P-OTBL ,P-NC2 <GET ,P-ITBL ,P-NC1>>
		 <PUT ,P-OTBL ,P-NC2L <GET ,P-ITBL ,P-NC1L>>
		 <SETG P-NCN 2>)
		(T <RFALSE>)>)
	 (<NOT <ZERO? ,P-ACLAUSE>>
	  <COND (<AND <NOT <EQUAL? ,P-NCN 1>> <NOT .ADJ>>
		 <SETG P-ACLAUSE <>>
		 <RFALSE>)
		(T
		 <SET BEG <GET ,P-ITBL ,P-NC1>>
		 <COND (.ADJ <SET BEG <REST ,P-LEXV 2>> <SET ADJ <>>)>
		 <SET END <GET ,P-ITBL ,P-NC1L>>
		 <REPEAT ()
			 <SET WRD <GET .BEG 0>>
			 <COND (<EQUAL? .BEG .END>
				<COND (.ADJ <ACLAUSE-WIN .ADJ> <RETURN>)
				      (T <SETG P-ACLAUSE <>> <RFALSE>)>)
			       (<AND <NOT .ADJ>
				     <OR <BTST <GETB .WRD ,P-PSOFF>
					       ,PS?ADJECTIVE>
					 <EQUAL? .WRD ,W?ALL ,W?ONE>>>
				<SET ADJ .WRD>)
			       (<EQUAL? .WRD ,W?ONE>
				<ACLAUSE-WIN .ADJ>
				<RETURN>)
			       (<BTST <GETB .WRD ,P-PSOFF> ,PS?OBJECT>
				<COND (<EQUAL? .WRD ,P-ANAM>
				       <ACLAUSE-WIN .ADJ>)
				      (T
				       <NCLAUSE-WIN>)>
				<RETURN>)>
			 <SET BEG <REST .BEG ,P-WORDLEN>>
			 <COND (<EQUAL? .END 0>
				<SET END .BEG>
				<SETG P-NCN 1>
				<PUT ,P-ITBL ,P-NC1 <BACK .BEG 4>>
				<PUT ,P-ITBL ,P-NC1L .BEG>)>>)>)>
   <PUT ,P-VTBL 0 <GET ,P-OVTBL 0>>
   <PUTB ,P-VTBL 2 <GETB ,P-OVTBL 2>>
   <PUTB ,P-VTBL 3 <GETB ,P-OVTBL 3>>
   <PUT ,P-OTBL ,P-VERBN ,P-VTBL>
   <PUTB ,P-VTBL 2 0>
   <REPEAT ()
	   <COND (<G? <SET CNT <+ .CNT 1>> ,P-ITBLLEN>
		  <SETG P-MERGED T>
		  <RTRUE>)
		 (T <PUT ,P-ITBL .CNT <GET ,P-OTBL .CNT>>)>>
   T>

;"New ACLAUSE-WIN for TRAP retrofix 6/21/84"

<ROUTINE ACLAUSE-WIN (ADJ)
	<PUT ,P-ITBL ,P-VERB <GET ,P-OTBL ,P-VERB>>
	<PUT ,P-CCTBL ,CC-SBPTR ,P-ACLAUSE>
	<PUT ,P-CCTBL ,CC-SEPTR <+ ,P-ACLAUSE 1>>
	<PUT ,P-CCTBL ,CC-DBPTR ,P-ACLAUSE>
	<PUT ,P-CCTBL ,CC-DEPTR <+ ,P-ACLAUSE 1>>
	<CLAUSE-COPY ,P-OTBL ,P-OTBL .ADJ>
	<AND <NOT <EQUAL? <GET ,P-OTBL ,P-NC2> 0>> <SETG P-NCN 2>>
	<SETG P-ACLAUSE <>>
	<RTRUE>>

<ROUTINE NCLAUSE-WIN ()
        <PUT ,P-CCTBL ,CC-SBPTR ,P-NC1>
	<PUT ,P-CCTBL ,CC-SEPTR ,P-NC1L>
	<PUT ,P-CCTBL ,CC-DBPTR ,P-ACLAUSE>
	<PUT ,P-CCTBL ,CC-DEPTR <+ ,P-ACLAUSE 1>>
	<CLAUSE-COPY ,P-ITBL ,P-OTBL>
	<AND <NOT <EQUAL? <GET ,P-OTBL ,P-NC2> 0>> <SETG P-NCN 2>>
	<SETG P-ACLAUSE <>>
	<RTRUE>>

;"Print undefined word in input.
   PTR points to the unknown word in P-LEXV"

<ROUTINE WORD-PRINT (CNT BUF)
	 <REPEAT ()
		 <COND (<DLESS? CNT 0> <RETURN>)
		       (ELSE
			<PRINTC <GETB ,P-INBUF .BUF>>
			<SET BUF <+ .BUF 1>>)>>>

<ROUTINE UNKNOWN-WORD (PTR "AUX" BUF)
	<PUT ,OOPS-TABLE ,O-PTR .PTR>
	<COND (<VERB? SAY>
	       <TELL "Nothing happens." CR>
	       <RFALSE>)>
	<TELL "I don't know the word \"">
	<WORD-PRINT <GETB <REST ,P-LEXV <SET BUF <* .PTR 2>>> 2>
		    <GETB <REST ,P-LEXV .BUF> 3>>
	<TELL "\"." CR>
	<SETG QUOTE-FLAG <>>
	<SETG P-OFLAG <>>>

<ROUTINE CANT-USE (PTR "AUX" BUF)
	<COND (<VERB? SAY>
	       <TELL "Nothing happens." CR>
	       <RFALSE>)>
	<TELL "You used the word \"">
	<WORD-PRINT <GETB <REST ,P-LEXV <SET BUF <* .PTR 2>>> 2>
		    <GETB <REST ,P-LEXV .BUF> 3>>
	<TELL "\" in a way that I don't understand." CR>
	<SETG QUOTE-FLAG <>>
	<SETG P-OFLAG <>>>

;" Perform syntax matching operations, using P-ITBL as the source of
   the verb and adjectives for this input.  Returns false if no
   syntax matches, and does it's own orphaning.  If return is true,
   the syntax is saved in P-SYNTAX."

<GLOBAL P-SLOCBITS 0>

<CONSTANT P-SYNLEN 8>

<CONSTANT P-SBITS 0>
<CONSTANT P-SPREP1 1>
<CONSTANT P-SPREP2 2>
<CONSTANT P-SFWIM1 3>
<CONSTANT P-SFWIM2 4>
<CONSTANT P-SLOC1 5>
<CONSTANT P-SLOC2 6>
<CONSTANT P-SACTION 7>
<CONSTANT P-SONUMS 3>

<ROUTINE SYNTAX-CHECK ("AUX" SYN LEN NUM OBJ
		       	    (DRIVE1 <>) (DRIVE2 <>) PREP VERB TMP)
	<COND (<ZERO? <SET VERB <GET ,P-ITBL ,P-VERB>>>
	       <TELL "There was no verb in that sentence!" CR>
	       <RFALSE>)>
	<SET SYN <GET ,VERBS <- 255 .VERB>>>
	<SET LEN <GETB .SYN 0>>
	<SET SYN <REST .SYN>>
	<REPEAT ()
		<SET NUM <BAND <GETB .SYN ,P-SBITS> ,P-SONUMS>>
		<COND (<G? ,P-NCN .NUM> T)
		      (<AND <NOT <L? .NUM 1>>
			    <ZERO? ,P-NCN>
			    <OR <ZERO? <SET PREP <GET ,P-ITBL ,P-PREP1>>>
				<EQUAL? .PREP <GETB .SYN ,P-SPREP1>>>>
		       <SET DRIVE1 .SYN>)
		      (<EQUAL? <GETB .SYN ,P-SPREP1> <GET ,P-ITBL ,P-PREP1>>
		       <COND (<AND <EQUAL? .NUM 2> <EQUAL? ,P-NCN 1>>
			      <SET DRIVE2 .SYN>)
			     (<EQUAL? <GETB .SYN ,P-SPREP2>
				   <GET ,P-ITBL ,P-PREP2>>
			      <SYNTAX-FOUND .SYN>
			      <RTRUE>)>)>
		<COND (<DLESS? LEN 1>
		       <COND (<OR .DRIVE1 .DRIVE2> <RETURN>)
			     (T
			      <TELL
"That sentence isn't one I recognize." CR>
			      <RFALSE>)>)
		      (T <SET SYN <REST .SYN ,P-SYNLEN>>)>>
	<COND (<AND .DRIVE1
		    <SET OBJ
			 <GWIM <GETB .DRIVE1 ,P-SFWIM1>
			       <GETB .DRIVE1 ,P-SLOC1>
			       <GETB .DRIVE1 ,P-SPREP1>>>>
	       <PUT ,P-PRSO ,P-MATCHLEN 1>
	       <PUT ,P-PRSO 1 .OBJ>
	       <SYNTAX-FOUND .DRIVE1>)
	      (<AND .DRIVE2
		    <SET OBJ
			 <GWIM <GETB .DRIVE2 ,P-SFWIM2>
			       <GETB .DRIVE2 ,P-SLOC2>
			       <GETB .DRIVE2 ,P-SPREP2>>>>
	       <PUT ,P-PRSI ,P-MATCHLEN 1>
	       <PUT ,P-PRSI 1 .OBJ>
	       <SYNTAX-FOUND .DRIVE2>)
	      (<EQUAL? .VERB ,ACT?FIND>
	       <TELL "That question can't be answered." CR>
	       <RFALSE>)
	      (<NOT <EQUAL? ,WINNER ,PLAYER>>
	       <CANT-ORPHAN>)
	      (T
	       <ORPHAN .DRIVE1 .DRIVE2>
	       <TELL "What do you want to ">
	       <SET TMP <GET ,P-OTBL ,P-VERBN>>
	       <COND (<EQUAL? .TMP 0> <TELL "tell">)
		     (<ZERO? <GETB ,P-VTBL 2>>
		      <PRINTB <GET .TMP 0>>)
		     (T
		      <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
		      <PUTB ,P-VTBL 2 0>)>
	       <COND (.DRIVE2
		      <TELL " ">
		      <THING-PRINT T T>)>
	       <SETG P-OFLAG T>
	       <PREP-PRINT <COND (.DRIVE1 <GETB .DRIVE1 ,P-SPREP1>)
				 (T <GETB .DRIVE2 ,P-SPREP2>)>>
	       <TELL "?" CR>
	       <RFALSE>)>>

<ROUTINE CANT-ORPHAN ()
	 <TELL "\"I don't understand! What are you referring to?\"" CR>
	 <RFALSE>>


<ROUTINE ORPHAN (D1 D2 "AUX" (CNT -1))
	<COND (<NOT ,P-MERGED>
	       <PUT ,P-OCLAUSE ,P-MATCHLEN 0>)>
	<PUT ,P-OVTBL 0 <GET ,P-VTBL 0>>
	<PUTB ,P-OVTBL 2 <GETB ,P-VTBL 2>>
	<PUTB ,P-OVTBL 3 <GETB ,P-VTBL 3>>
	<REPEAT ()
		<COND (<IGRTR? CNT ,P-ITBLLEN> <RETURN>)
		      (T <PUT ,P-OTBL .CNT <GET ,P-ITBL .CNT>>)>>
	<COND (<EQUAL? ,P-NCN 2>
	       <PUT ,P-CCTBL ,CC-SBPTR ,P-NC2>
	       <PUT ,P-CCTBL ,CC-SEPTR ,P-NC2L>
	       <PUT ,P-CCTBL ,CC-DBPTR ,P-NC2>
	       <PUT ,P-CCTBL ,CC-DEPTR ,P-NC2L>
	       <CLAUSE-COPY ,P-ITBL ,P-OTBL>)>
	<COND (<NOT <L? ,P-NCN 1>>
	       <PUT ,P-CCTBL ,CC-SBPTR ,P-NC1>
	       <PUT ,P-CCTBL ,CC-SEPTR ,P-NC1L>
	       <PUT ,P-CCTBL ,CC-DBPTR ,P-NC1>
	       <PUT ,P-CCTBL ,CC-DEPTR ,P-NC1L>
	       <CLAUSE-COPY ,P-ITBL ,P-OTBL>)>
	<COND (.D1
	       <PUT ,P-OTBL ,P-PREP1 <GETB .D1 ,P-SPREP1>>
	       <PUT ,P-OTBL ,P-NC1 1>)
	      (.D2
	       <PUT ,P-OTBL ,P-PREP2 <GETB .D2 ,P-SPREP2>>
	       <PUT ,P-OTBL ,P-NC2 1>)>>

<ROUTINE THING-PRINT (PRSO? "OPTIONAL" (THE? <>) "AUX" BEG END)
	 <COND (.PRSO?
		<SET BEG <GET ,P-ITBL ,P-NC1>>
		<SET END <GET ,P-ITBL ,P-NC1L>>)
	       (ELSE
		<SET BEG <GET ,P-ITBL ,P-NC2>>
		<SET END <GET ,P-ITBL ,P-NC2L>>)>
	 <BUFFER-PRINT .BEG .END .THE?>>

<ROUTINE BUFFER-PRINT (BEG END CP
		       "AUX" (NOSP T) WRD (FIRST?? T) (PN <>) (Q? <>))
	 <REPEAT ()
		<COND (<EQUAL? .BEG .END> <RETURN>)
		      (T
		       <SET WRD <GET .BEG 0>>
		       <COND ;(<EQUAL? .WRD ,W?$BUZZ> T)
			     (<EQUAL? .WRD ,W?COMMA>
			      <TELL ", ">)
			     (.NOSP <SET NOSP <>>)
			     (ELSE <TELL " ">)>
		       <COND (<EQUAL? .WRD ,W?PERIOD ,W?COMMA>
			      <SET NOSP T>)
			     (<EQUAL? .WRD ,W?ME>
			      <PRINTD ,ME>
			      <SET PN T>)
			     (<EQUAL? .WRD ,W?INTNUM>
			      <PRINTN ,P-NUMBER>
			      <SET PN T>)
			     (T
			      <COND (<AND .FIRST?? <NOT .PN> .CP>
				     <TELL "the ">)>
			      <COND (<OR ,P-OFLAG ,P-MERGED> <PRINTB .WRD>)
				    (<AND <EQUAL? .WRD ,W?IT>
					  <ACCESSIBLE? ,P-IT-OBJECT>>
				     <PRINTD ,P-IT-OBJECT>)
				    (T
				     <WORD-PRINT <GETB .BEG 2>
						 <GETB .BEG 3>>)>
			      <SET FIRST?? <>>)>)>
		<SET BEG <REST .BEG ,P-WORDLEN>>>>

<ROUTINE PREP-PRINT (PREP "AUX" WRD)
	<COND (<NOT <ZERO? .PREP>>
	       <TELL " ">
	       <COND ;(<EQUAL? .PREP ,PR?THROUGH>
		      <TELL "through">)
		     (T
		      <SET WRD <PREP-FIND .PREP>>
		      <PRINTB .WRD>)>)>>

<ROUTINE CLAUSE-COPY (SRC DEST "OPTIONAL" (INSRT <>) "AUX" BEG END)
	<SET BEG <GET .SRC <GET ,P-CCTBL ,CC-SBPTR>>>
	<SET END <GET .SRC <GET ,P-CCTBL ,CC-SEPTR>>>
	<PUT .DEST
	     <GET ,P-CCTBL ,CC-DBPTR>
	     <REST ,P-OCLAUSE
		   <+ <* <GET ,P-OCLAUSE ,P-MATCHLEN> ,P-LEXELEN> 2>>>
	<REPEAT ()
		<COND (<EQUAL? .BEG .END>
		       <PUT .DEST
			    <GET ,P-CCTBL ,CC-DEPTR>
			    <REST ,P-OCLAUSE
				  <+ <* <GET ,P-OCLAUSE ,P-MATCHLEN> ,P-LEXELEN>
				     2>>>
		       <RETURN>)
		      (T
		       <COND (<AND .INSRT <EQUAL? ,P-ANAM <GET .BEG 0>>>
			      <CLAUSE-ADD .INSRT>)>
		       <CLAUSE-ADD <GET .BEG 0>>)>
		<SET BEG <REST .BEG ,P-WORDLEN>>>>


<ROUTINE CLAUSE-ADD (WRD "AUX" PTR)
	<SET PTR <+ <GET ,P-OCLAUSE ,P-MATCHLEN> 2>>
	<PUT ,P-OCLAUSE <- .PTR 1> .WRD>
	<PUT ,P-OCLAUSE .PTR 0>
	<PUT ,P-OCLAUSE ,P-MATCHLEN .PTR>>

<ROUTINE PREP-FIND (PREP "AUX" (CNT 0) SIZE)
	<SET SIZE <* <GET ,PREPOSITIONS 0> 2>>
	<REPEAT ()
		<COND (<IGRTR? CNT .SIZE> <RFALSE>)
		      (<EQUAL? <GET ,PREPOSITIONS .CNT> .PREP>
		       <RETURN <GET ,PREPOSITIONS <- .CNT 1>>>)>>>

<ROUTINE SYNTAX-FOUND (SYN)
	<SETG P-SYNTAX .SYN>
	<SETG PRSA <GETB .SYN ,P-SACTION>>>

<GLOBAL P-GWIMBIT 0>

<ROUTINE GWIM (GBIT LBIT PREP "AUX" OBJ)
	<COND (<EQUAL? .GBIT ,RMUNGBIT>
	       <RETURN ,ROOMS>)>
	<SETG P-GWIMBIT .GBIT>
	<SETG P-SLOCBITS .LBIT>
	<PUT ,P-MERGE ,P-MATCHLEN 0>
	<COND (<GET-OBJECT ,P-MERGE <>>
	       <SETG P-GWIMBIT 0>
	       <COND (<EQUAL? <GET ,P-MERGE ,P-MATCHLEN> 1>
		      <SET OBJ <GET ,P-MERGE 1>>
		      <TELL "(">
		      <COND (<AND <NOT <ZERO? .PREP>>
				  <NOT ,P-END-ON-PREP>>
			     <PRINTB <SET PREP <PREP-FIND .PREP>>>
			     <COND (<EQUAL? .PREP ,W?OUT>
				    <TELL " of">)>
			     <TELL " ">
			     <COND (<EQUAL? .OBJ ,HANDS>
				    <TELL "your hands">)
				   (T
				    <TELL "the " D .OBJ>)>
			     <TELL ")" CR>)
			    (ELSE
			     <TELL D .OBJ ")" CR>)>
		      .OBJ)>)
	      (T <SETG P-GWIMBIT 0> <RFALSE>)>>

<ROUTINE SNARF-OBJECTS ("AUX" OPTR IPTR L)
	 <PUT ,P-BUTS ,P-MATCHLEN 0>
	 <COND (<NOT <EQUAL? <SET IPTR <GET ,P-ITBL ,P-NC2>> 0>>
		<SETG P-SLOCBITS <GETB ,P-SYNTAX ,P-SLOC2>>
		<OR <SNARFEM .IPTR <GET ,P-ITBL ,P-NC2L> ,P-PRSI> <RFALSE>>)>
	 <COND (<NOT <EQUAL? <SET OPTR <GET ,P-ITBL ,P-NC1>> 0>>
		<SETG P-SLOCBITS <GETB ,P-SYNTAX ,P-SLOC1>>
		<OR <SNARFEM .OPTR <GET ,P-ITBL ,P-NC1L> ,P-PRSO> <RFALSE>>)>
	 <COND (<NOT <ZERO? <GET ,P-BUTS ,P-MATCHLEN>>>
		<SET L <GET ,P-PRSO ,P-MATCHLEN>>
		<COND (.OPTR <SETG P-PRSO <BUT-MERGE ,P-PRSO>>)>
		<COND (<AND .IPTR
			    <OR <NOT .OPTR>
				<EQUAL? .L <GET ,P-PRSO ,P-MATCHLEN>>>>
		       <SETG P-PRSI <BUT-MERGE ,P-PRSI>>)>)>
	 <RTRUE>>

<ROUTINE BUT-MERGE (TBL "AUX" LEN BUTLEN (CNT 1) (MATCHES 0) OBJ NTBL)
	<SET LEN <GET .TBL ,P-MATCHLEN>>
	<PUT ,P-MERGE ,P-MATCHLEN 0>
	<REPEAT ()
		<COND (<DLESS? LEN 0> <RETURN>)
		      (<ZMEMQ <SET OBJ <GET .TBL .CNT>> ,P-BUTS>)
		      (T
		       <PUT ,P-MERGE <+ .MATCHES 1> .OBJ>
		       <SET MATCHES <+ .MATCHES 1>>)>
		<SET CNT <+ .CNT 1>>>
	<PUT ,P-MERGE ,P-MATCHLEN .MATCHES>
	<SET NTBL ,P-MERGE>
	<SETG P-MERGE .TBL>
	.NTBL>

<GLOBAL P-NAM <>>
<GLOBAL P-ADJ <>>
<GLOBAL P-ADVERB <>>
<GLOBAL P-ADJN <>>
<GLOBAL P-PRSO <ITABLE NONE 50>>
<GLOBAL P-PRSI <ITABLE NONE 50>>
<GLOBAL P-BUTS <ITABLE NONE 50>>
<GLOBAL P-MERGE <ITABLE NONE 50>>
<GLOBAL P-OCLAUSE <ITABLE NONE 100>>
<GLOBAL P-MATCHLEN 0>
<GLOBAL P-GETFLAGS 0>
<CONSTANT P-ALL 1>
<CONSTANT P-ONE 2>
<CONSTANT P-INHIBIT 4>


<GLOBAL P-AND <>>

<ROUTINE SNARFEM (PTR EPTR TBL "AUX" (BUT <>) LEN WV WRD NW (WAS-ALL <>))
   <SETG P-AND <>>
   <COND (<EQUAL? ,P-GETFLAGS ,P-ALL>
	  <SET WAS-ALL T>)>
   <SETG P-GETFLAGS 0>
   <PUT .TBL ,P-MATCHLEN 0>
   <SET WRD <GET .PTR 0>>
   <REPEAT ()
	   <COND (<EQUAL? .PTR .EPTR>
		  <SET WV <GET-OBJECT <OR .BUT .TBL>>>
		  <COND (.WAS-ALL <SETG P-GETFLAGS ,P-ALL>)>
		  <RETURN .WV>)
		 (T
		  <COND (<==? .EPTR <REST .PTR ,P-WORDLEN>>
			 <SET NW 0>)
			(T <SET NW <GET .PTR ,P-LEXELEN>>)>
		  <COND (<EQUAL? .WRD ,W?ALL ;,W?BOTH>
			 <SETG P-GETFLAGS ,P-ALL>
			 <COND (<EQUAL? .NW ,W?OF>
				<SET PTR <REST .PTR ,P-WORDLEN>>)>)
			(<EQUAL? .WRD ,W?BUT ,W?EXCEPT>
			 <OR <GET-OBJECT <OR .BUT .TBL>> <RFALSE>>
			 <SET BUT ,P-BUTS>
			 <PUT .BUT ,P-MATCHLEN 0>)
			(<EQUAL? .WRD ,W?A ,W?ONE>
			 <COND (<NOT ,P-ADJ>
				<SETG P-GETFLAGS ,P-ONE>
				<COND (<EQUAL? .NW ,W?OF>
				       <SET PTR <REST .PTR ,P-WORDLEN>>)>)
			       (T
				<SETG P-NAM ,P-ONEOBJ>
				<OR <GET-OBJECT <OR .BUT .TBL>> <RFALSE>>
				<AND <ZERO? .NW> <RTRUE>>)>)
			(<AND <EQUAL? .WRD ,W?AND ,W?COMMA>
			      <NOT <EQUAL? .NW ,W?AND ,W?COMMA>>>
			 <SETG P-AND T>
			 <OR <GET-OBJECT <OR .BUT .TBL>> <RFALSE>>
			 T)
			(<WT? .WRD ,PS?BUZZ-WORD>)
			(<EQUAL? .WRD ,W?AND ,W?COMMA>)
			(<EQUAL? .WRD ,W?OF>
			 <COND (<ZERO? ,P-GETFLAGS>
				<SETG P-GETFLAGS ,P-INHIBIT>)>)
			(<AND <SET WV <WT? .WRD ,PS?ADJECTIVE ,P1?ADJECTIVE>>
			      <NOT ,P-ADJ>>
			 <SETG P-ADJ .WV>
			 <SETG P-ADJN .WRD>)
			(<WT? .WRD ,PS?OBJECT ,P1?OBJECT>
			 <SETG P-NAM .WRD>
			 <SETG P-ONEOBJ .WRD>)>)>
	   <COND (<NOT <EQUAL? .PTR .EPTR>>
		  <SET PTR <REST .PTR ,P-WORDLEN>>
		  <SET WRD .NW>)>>>

<CONSTANT SH 128>
<CONSTANT SC 64>
<CONSTANT SIR 32>
<CONSTANT SOG 16>
<CONSTANT STAKE 8>
<CONSTANT SMANY 4>
<CONSTANT SHAVE 2>

<ROUTINE GET-OBJECT (TBL
		     "OPTIONAL" (VRB T)
		     "AUX" BITS LEN XBITS TLEN (GCHECK <>) (OLEN 0) OBJ)
	 <SET XBITS ,P-SLOCBITS>
	 <SET TLEN <GET .TBL ,P-MATCHLEN>>
	 <COND (<BTST ,P-GETFLAGS ,P-INHIBIT> <RTRUE>)>
	 <COND (<AND <NOT ,P-NAM> ,P-ADJ>
		<COND (<WT? ,P-ADJN ,PS?OBJECT ,P1?OBJECT>
		       <SETG P-NAM ,P-ADJN>
		       <SETG P-ADJ <>>)
		      %<COND (<==? ,ZORK-NUMBER 3>
			      '(<SET BITS
				     <WT? ,P-ADJN
					  ,PS?DIRECTION ,P1?DIRECTION>>
				<SETG P-ADJ <>>
				<PUT .TBL ,P-MATCHLEN 1>
				<PUT .TBL 1 ,INTDIR>
				<SETG P-DIRECTION .BITS>
				<RTRUE>))
			     (ELSE '(<NULL-F> T))>>)>
	 <COND (<AND <NOT ,P-NAM>
		     <NOT ,P-ADJ>
		     <NOT <EQUAL? ,P-GETFLAGS ,P-ALL>>
		     <ZERO? ,P-GWIMBIT>>
		<COND (.VRB
		       <TELL
"There seems to be a noun missing in that sentence!" CR>)>
		<RFALSE>)>
	 <COND (<OR <NOT <EQUAL? ,P-GETFLAGS ,P-ALL>> <ZERO? ,P-SLOCBITS>>
		<SETG P-SLOCBITS -1>)>
	 <SETG P-TABLE .TBL>
	 <PROG ()
	       <COND (.GCHECK <GLOBAL-CHECK .TBL>)
		     (T
		      <COND (,LIT
			     <FCLEAR ,PLAYER ,TRANSBIT>
			     <DO-SL ,HERE ,SOG ,SIR>
			     <FSET ,PLAYER ,TRANSBIT>)>
		      <DO-SL ,PLAYER ,SH ,SC>)>
	       <SET LEN <- <GET .TBL ,P-MATCHLEN> .TLEN>>
	       <COND (<BTST ,P-GETFLAGS ,P-ALL>)
		     (<AND <BTST ,P-GETFLAGS ,P-ONE>
			   <NOT <ZERO? .LEN>>>
		      <COND (<NOT <EQUAL? .LEN 1>>
			     <PUT .TBL 1 <GET .TBL <RANDOM .LEN>>>
			     <TELL "(How about the ">
			     <PRINTD <GET .TBL 1>>
			     <TELL "?)" CR>)>
		      <PUT .TBL ,P-MATCHLEN 1>)
		     (<OR <G? .LEN 1>
			  <AND <ZERO? .LEN> <NOT <EQUAL? ,P-SLOCBITS -1>>>>
		      <COND (<EQUAL? ,P-SLOCBITS -1>
			     <SETG P-SLOCBITS .XBITS>
			     <SET OLEN .LEN>
			     <PUT .TBL
				  ,P-MATCHLEN
				  <- <GET .TBL ,P-MATCHLEN> .LEN>>
			     <AGAIN>)
			    (T
			     <COND (<ZERO? .LEN> <SET LEN .OLEN>)>
			     <COND (<NOT <EQUAL? ,WINNER ,PLAYER>>
				    <CANT-ORPHAN>
				    <RFALSE>)
				   (<AND .VRB ,P-NAM>
				    <WHICH-PRINT .TLEN .LEN .TBL>
				    <SETG P-ACLAUSE
					  <COND (<EQUAL? .TBL ,P-PRSO> ,P-NC1)
						(T ,P-NC2)>>
				    <SETG P-AADJ ,P-ADJ>
				    <SETG P-ANAM ,P-NAM>
				    <ORPHAN <> <>>
				    <SETG P-OFLAG T>)
				   (.VRB
				    <TELL
"There seems to be a noun missing in that sentence!" CR>)>
			     <SETG P-NAM <>>
			     <SETG P-ADJ <>>
			     <RFALSE>)>)>
	       <COND (<AND <ZERO? .LEN> .GCHECK>
		      <COND (.VRB
			     ;"next added 1/2/85 by JW"
			     <SETG P-SLOCBITS .XBITS>
			     <COND (<OR ,LIT <VERB? TELL ;WHERE ;WHAT ;WHO>>
				    ;"Changed 6/10/83 - MARC"
				    <OBJ-FOUND ,NOT-HERE-OBJECT .TBL>
				    <SETG P-XNAM ,P-NAM>
				    <SETG P-XADJ ,P-ADJ>
				    <SETG P-XADJN ,P-ADJN>
				    <SETG P-NAM <>>
				    <SETG P-ADJ <>>
				    <SETG P-ADJN <>>
				    <RTRUE>)
				   (T <TELL "It's too dark to see!" CR>)>)>
		      <SETG P-NAM <>>
		      <SETG P-ADJ <>>
		      <RFALSE>)
		     (<ZERO? .LEN> <SET GCHECK T> <AGAIN>)>
	       <SETG P-SLOCBITS .XBITS>
	       <SETG P-NAM <>>
	       <SETG P-ADJ <>>
	       <RTRUE>>>

<GLOBAL P-XNAM <>>
<GLOBAL P-XADJ <>>
<GLOBAL P-XADJN <>>

<ROUTINE WHICH-PRINT (TLEN LEN TBL "AUX" OBJ RLEN)
	 <SET RLEN .LEN>
	 <TELL "Which ">
         <COND (<OR ,P-OFLAG ,P-MERGED ,P-AND>
		<PRINTB <COND (,P-NAM ,P-NAM)
			      (,P-ADJ ,P-ADJN)
			      (ELSE ,W?ONE)>>)
	       (ELSE
		<THING-PRINT <EQUAL? .TBL ,P-PRSO>>)>
	 <TELL " do you mean, ">
	 <REPEAT ()
		 <SET TLEN <+ .TLEN 1>>
		 <SET OBJ <GET .TBL .TLEN>>
		 <TELL "the " D .OBJ>
		 <COND (<EQUAL? .LEN 2>
		        <COND (<NOT <EQUAL? .RLEN 2>> <TELL ",">)>
		        <TELL " or ">)
		       (<G? .LEN 2> <TELL ", ">)>
		 <COND (<L? <SET LEN <- .LEN 1>> 1>
		        <TELL "?" CR>
		        <RETURN>)>>>


<ROUTINE GLOBAL-CHECK (TBL "AUX" LEN RMG RMGL (CNT 0) OBJ OBITS FOO)
	<SET LEN <GET .TBL ,P-MATCHLEN>>
	<SET OBITS ,P-SLOCBITS>
	<COND (<SET RMG <GETPT ,HERE ,P?GLOBAL>>
	       <SET RMGL <- <PTSIZE .RMG> 1>>
	       <REPEAT ()
		       <COND (<THIS-IT? <SET OBJ <GETB .RMG .CNT>> .TBL>
			      <OBJ-FOUND .OBJ .TBL>)>
		       <COND (<IGRTR? CNT .RMGL> <RETURN>)>>)>
	<COND (<SET RMG <GETPT ,HERE ,P?PSEUDO>>
	       <SET RMGL <- </ <PTSIZE .RMG> 4> 1>>
	       <SET CNT 0>
	       <REPEAT ()
		       <COND (<EQUAL? ,P-NAM <GET .RMG <* .CNT 2>>>
			      <PUTP ,PSEUDO-OBJECT
				    ,P?ACTION
				    <GET .RMG <+ <* .CNT 2> 1>>>
			      <SET FOO
				   <BACK <GETPT ,PSEUDO-OBJECT ,P?ACTION> 5>>
			      <PUT .FOO 0 <GET ,P-NAM 0>>
			      <PUT .FOO 1 <GET ,P-NAM 1>>
			      <OBJ-FOUND ,PSEUDO-OBJECT .TBL>
			      <RETURN>)
		             (<IGRTR? CNT .RMGL> <RETURN>)>>)>
	<COND (<EQUAL? <GET .TBL ,P-MATCHLEN> .LEN>
	       <SETG P-SLOCBITS -1>
	       <SETG P-TABLE .TBL>
	       <DO-SL ,GLOBAL-OBJECTS 1 1>
	       <SETG P-SLOCBITS .OBITS>
	       <COND (<AND <ZERO? <GET .TBL ,P-MATCHLEN>>
			   <EQUAL? ,PRSA ,V?LOOK-INSIDE ,V?SEARCH ,V?EXAMINE>>
		      <DO-SL ,ROOMS 1 1>)>)>>

<ROUTINE DO-SL (OBJ BIT1 BIT2 "AUX" BTS)
	<COND (<BTST ,P-SLOCBITS <+ .BIT1 .BIT2>>
	       <SEARCH-LIST .OBJ ,P-TABLE ,P-SRCALL>)
	      (T
	       <COND (<BTST ,P-SLOCBITS .BIT1>
		      <SEARCH-LIST .OBJ ,P-TABLE ,P-SRCTOP>)
		     (<BTST ,P-SLOCBITS .BIT2>
		      <SEARCH-LIST .OBJ ,P-TABLE ,P-SRCBOT>)
		     (T <RTRUE>)>)>>

<CONSTANT P-SRCBOT 2>
<CONSTANT P-SRCTOP 0>
<CONSTANT P-SRCALL 1>

<ROUTINE SEARCH-LIST (OBJ TBL LVL "AUX" FLS NOBJ)
	<COND (<SET OBJ <FIRST? .OBJ>>
	       <REPEAT ()
		       <COND (<AND <NOT <EQUAL? .LVL ,P-SRCBOT>>
				   <GETPT .OBJ ,P?SYNONYM>
				   <THIS-IT? .OBJ .TBL>>
			      <OBJ-FOUND .OBJ .TBL>)>
		       <COND (<AND <OR <NOT <EQUAL? .LVL ,P-SRCTOP>>
				       <FSET? .OBJ ,SEARCHBIT>
				       <FSET? .OBJ ,SURFACEBIT>>
				   <SET NOBJ <FIRST? .OBJ>>
				   <OR <FSET? .OBJ ,OPENBIT>
				       <FSET? .OBJ ,TRANSBIT>>>
			      <SET FLS
				   <SEARCH-LIST .OBJ
						.TBL
						<COND (<FSET? .OBJ ,SURFACEBIT>
						       ,P-SRCALL)
						      (<FSET? .OBJ ,SEARCHBIT>
						       ,P-SRCALL)
						      (T ,P-SRCTOP)>>>)>
		       <COND (<SET OBJ <NEXT? .OBJ>>) (T <RETURN>)>>)>>

<ROUTINE OBJ-FOUND (OBJ TBL "AUX" PTR)
	<SET PTR <GET .TBL ,P-MATCHLEN>>
	<PUT .TBL <+ .PTR 1> .OBJ>
	<PUT .TBL ,P-MATCHLEN <+ .PTR 1>>>

<ROUTINE TAKE-CHECK ()
	<AND <ITAKE-CHECK ,P-PRSO <GETB ,P-SYNTAX ,P-SLOC1>>
	     <ITAKE-CHECK ,P-PRSI <GETB ,P-SYNTAX ,P-SLOC2>>>>

<ROUTINE ITAKE-CHECK (TBL IBITS "AUX" PTR OBJ TAKEN)
	 #DECL ((TBL) TABLE (IBITS PTR) FIX (OBJ) OBJECT
		(TAKEN) <OR FALSE FIX ATOM>)
	 <COND (<AND <SET PTR <GET .TBL ,P-MATCHLEN>>
		     <OR <BTST .IBITS ,SHAVE>
			 <BTST .IBITS ,STAKE>>>
		<REPEAT ()
			<COND (<L? <SET PTR <- .PTR 1>> 0> <RETURN>)
			      (T
			       <SET OBJ <GET .TBL <+ .PTR 1>>>
			       <COND (<EQUAL? .OBJ ,IT>
				      <COND (<NOT <ACCESSIBLE? ,P-IT-OBJECT>>
					     <TELL
"I don't see what you're referring to." CR>
					     <RFALSE>)
					    (T
					     <SET OBJ ,P-IT-OBJECT>)>)>
			       <COND (<AND <NOT <HELD? .OBJ>>
					   <NOT <EQUAL? .OBJ ,HANDS ,ME>>>
				      <SETG PRSO .OBJ>
				      <COND (<FSET? .OBJ ,TRYTAKEBIT>
					     <SET TAKEN T>)
					    (<NOT <EQUAL? ,WINNER ,ADVENTURER>>
					     <SET TAKEN <>>)
					    (<AND <BTST .IBITS ,STAKE>
						  <EQUAL? <ITAKE <>> T>>
					     <SET TAKEN <>>)
					    (T <SET TAKEN T>)>
				      <COND (<AND .TAKEN
						  <BTST .IBITS ,SHAVE>
						  <EQUAL? ,WINNER
							  ,ADVENTURER>>
					     <COND (<EQUAL? .OBJ
							    ,NOT-HERE-OBJECT>
						    <TELL
"You don't have that!" CR>
						    <RFALSE>)>
					     <TELL "You don't have the ">
					     <PRINTD .OBJ>
					     <TELL "." CR>
					     <RFALSE>)
					    (<AND <NOT .TAKEN>
						  <EQUAL? ,WINNER ,ADVENTURER>>
					     <TELL "(Taken)" CR>)>)>)>>)
	       (T)>>

<ROUTINE MANY-CHECK ("AUX" (LOSS <>) TMP)
	<COND (<AND <G? <GET ,P-PRSO ,P-MATCHLEN> 1>
		    <NOT <BTST <GETB ,P-SYNTAX ,P-SLOC1> ,SMANY>>>
	       <SET LOSS 1>)
	      (<AND <G? <GET ,P-PRSI ,P-MATCHLEN> 1>
		    <NOT <BTST <GETB ,P-SYNTAX ,P-SLOC2> ,SMANY>>>
	       <SET LOSS 2>)>
	<COND (.LOSS
	       <TELL "You can't use multiple ">
	       <COND (<EQUAL? .LOSS 2> <TELL "in">)>
	       <TELL "direct objects with \"">
	       <SET TMP <GET ,P-ITBL ,P-VERBN>>
	       <COND (<ZERO? .TMP> <TELL "tell">)
		     (<OR ,P-OFLAG ,P-MERGED>
		      <PRINTB <GET .TMP 0>>)
		     (T
		      <WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>)>
	       <TELL "\"." CR>
	       <RFALSE>)
	      (T)>>

<ROUTINE ZMEMQ (ITM TBL "OPTIONAL" (SIZE -1) "AUX" (CNT 1))
	<COND (<NOT .TBL> <RFALSE>)>
	<COND (<NOT <L? .SIZE 0>> <SET CNT 0>)
	      (ELSE <SET SIZE <GET .TBL 0>>)>
	<REPEAT ()
		<COND (<EQUAL? .ITM <GET .TBL .CNT>>
		       <RETURN <REST .TBL <* .CNT 2>>>)
		      (<IGRTR? CNT .SIZE> <RFALSE>)>>>

<ROUTINE ZMEMQB (ITM TBL SIZE "AUX" (CNT 0))
	<REPEAT ()
		<COND (<EQUAL? .ITM <GETB .TBL .CNT>>
		       <RTRUE>)
		      (<IGRTR? CNT .SIZE>
		       <RFALSE>)>>>

<GLOBAL ALWAYS-LIT <>>

<ROUTINE LIT? (RM "OPTIONAL" (RMBIT T) "AUX" OHERE (LIT <>))
	<COND (<AND ,ALWAYS-LIT <EQUAL? ,WINNER ,PLAYER>>
	       <RTRUE>)>
	<SETG P-GWIMBIT ,ONBIT>
	<SET OHERE ,HERE>
	<SETG HERE .RM>
	<COND (<AND .RMBIT
		    <FSET? .RM ,ONBIT>>
	       <SET LIT T>)
	      (T
	       <PUT ,P-MERGE ,P-MATCHLEN 0>
	       <SETG P-TABLE ,P-MERGE>
	       <SETG P-SLOCBITS -1>
	       <COND (<EQUAL? .OHERE .RM>
		      <DO-SL ,WINNER 1 1>
		      <COND (<AND <NOT <EQUAL? ,WINNER ,PLAYER>>
				  <IN? ,PLAYER .RM>>
			     <DO-SL ,PLAYER 1 1>)>)>
	       <DO-SL .RM 1 1>
	       <COND (<G? <GET ,P-TABLE ,P-MATCHLEN> 0> <SET LIT T>)>)>
	<SETG HERE .OHERE>
	<SETG P-GWIMBIT 0>
	.LIT>

<ROUTINE THIS-IT? (OBJ TBL "AUX" SYNS)
 <COND (<FSET? .OBJ ,INVISIBLE> <RFALSE>)
       (<AND ,P-NAM
	     <NOT <ZMEMQ ,P-NAM
			 <SET SYNS <GETPT .OBJ ,P?SYNONYM>>
			 <- </ <PTSIZE .SYNS> 2> 1>>>>
	<RFALSE>)
       (<AND ,P-ADJ
	     <OR <NOT <SET SYNS <GETPT .OBJ ,P?ADJECTIVE>>>
		 <NOT <ZMEMQB ,P-ADJ .SYNS <- <PTSIZE .SYNS> 1>>>>>
	<RFALSE>)
       (<AND <NOT <ZERO? ,P-GWIMBIT>> <NOT <FSET? .OBJ ,P-GWIMBIT>>>
	<RFALSE>)>
 <RTRUE>>

<ROUTINE ACCESSIBLE? (OBJ "AUX" (L <LOC .OBJ>)) ;"can player TOUCH object?"
	 ;"revised 5/2/84 by SEM and SWG"
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       ;(<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? ,LAST-PSEUDO-LOC ,HERE>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<NOT .L>
		<RFALSE>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<RTRUE>)
	       (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
	       (<NOT <EQUAL? <META-LOC .OBJ> ,HERE <LOC ,WINNER>>>
		<RFALSE>)
	       (<EQUAL? .L ,WINNER ,HERE <LOC ,WINNER>>
		<RTRUE>)
	       (<AND <FSET? .L ,OPENBIT>
		     <ACCESSIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ>
			<RFALSE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)>
		 <COND (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (T
			<SET OBJ <LOC .OBJ>>)>>>

;-------------------------------------------------------
"SYNTAX"
;-------------------------------------------------------
			"Generic SYNTAX file for
			    The ZORK Trilogy
		       started on 7/21/83 by SEM"

^L

"Buzzwords, Prepositions and Directions"

<BUZZ AGAIN G OOPS>

<BUZZ A AN THE IS AND OF THEN ALL ONE BUT EXCEPT \. \, \" YES NO Y HERE>

<COND (<==? ,ZORK-NUMBER 2>
       <BUZZ FEEBLE FUMBLE FEAR FILCH FREEZE FALL FRY FLUORESCE
	     FERMENT FIERCE FLOAT FIREPROOF FENCE FUDGE FANTASIZE
	     FROTZ OZMOO>)
      (<==? ,ZORK-NUMBER 3>
       <BUZZ FROTZ OZMOO>)>

<SYNONYM WITH USING THROUGH THRU>
<SYNONYM IN INSIDE INTO>
<SYNONYM ON ONTO>
<SYNONYM UNDER UNDERNEATH BENEATH BELOW>

<SYNONYM NORTH N>
<SYNONYM SOUTH S>
<SYNONYM EAST E>
<SYNONYM WEST W>
<SYNONYM DOWN D>
<SYNONYM UP U>
<SYNONYM NW NORTHWEST>
<SYNONYM NE NORTHE>
<SYNONYM SW SOUTHWEST>
<SYNONYM SE SOUTHE>

^L

<SYNTAX FOO OBJECT = V-FOO>
<SYNTAX FOOH OBJECT (HAVE)= V-FOO>
<SYNTAX FOOHHE OBJECT (HAVE HELD)= V-FOO>
<SYNTAX FOOHC OBJECT (HAVE CARRIED)= V-FOO>
<SYNTAX FOODHHEC OBJECT (HAVE HELD CARRIED) = V-FOO>
<SYNTAX FOOHE OBJECT (HELD) = V-FOO>
<SYNTAX FOOHEC OBJECT (HELD CARRIED)= V-FOO>
<SYNTAX FOOC OBJECT (CARRIED) = V-FOO>
<SYNTAX FOOHE-HE OBJECT (HELD) WITH OBJECT (HELD) = V-FOO>

<ROUTINE V-FOO () <TELL "You FOO the object." CR> <RTRUE>>

"Game Commands"

<SYNTAX VERBOSE = V-VERBOSE>

<SYNTAX BRIEF = V-BRIEF>

<SYNTAX SUPER = V-SUPER-BRIEF>
<SYNONYM SUPER SUPERBRIEF>

<SYNTAX DIAGNOSE = V-DIAGNOSE>

<SYNTAX INVENTORY = V-INVENTORY>
<SYNONYM INVENTORY I>

<SYNTAX QUIT = V-QUIT>
<SYNONYM QUIT Q>

<SYNTAX RESTART = V-RESTART>

<SYNTAX RESTORE = V-RESTORE>

<SYNTAX SAVE = V-SAVE>

<SYNTAX SCORE = V-SCORE>

<SYNTAX SCRIPT = V-SCRIPT>

<SYNTAX UNSCRIPT = V-UNSCRIPT>

<SYNTAX VERSION = V-VERSION>

<SYNTAX $VERIFY = V-VERIFY>

<SYNTAX \#RANDOM OBJECT = V-RANDOM>

<SYNTAX \#COMMAND = V-COMMAND-FILE>

<SYNTAX \#RECORD = V-RECORD>

<SYNTAX \#UNRECORD = V-UNRECORD>

^L

"Real Verbs"

<SYNTAX ACTIVATE OBJECT (FIND LIGHTBIT)
	(HELD CARRIED ON-GROUND IN-ROOM) = V-LAMP-ON>

<SYNTAX ANSWER = V-ANSWER>
<SYNTAX ANSWER OBJECT = V-REPLY>
<SYNONYM ANSWER REPLY>

<SYNTAX APPLY OBJECT TO OBJECT = V-PUT PRE-PUT>

<COND (<==? ,ZORK-NUMBER 2>
       <SYNTAX ATTACK OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM)
	       = V-ATTACK>)>

<SYNTAX ATTACK OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM)
	WITH OBJECT (FIND WEAPONBIT) (HELD CARRIED HAVE) = V-ATTACK>
<SYNONYM ATTACK FIGHT HURT INJURE HIT>

<SYNTAX BACK = V-BACK>

<SYNTAX BLAST = V-BLAST>

<SYNTAX BLOW OUT OBJECT = V-LAMP-OFF>
<SYNTAX BLOW UP	OBJECT WITH
	OBJECT (FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CARRIED) = V-INFLATE>
<SYNTAX BLOW UP OBJECT = V-BLAST>
<SYNTAX BLOW IN OBJECT = V-BREATHE>

<SYNTAX BOARD OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-BOARD PRE-BOARD>

<SYNTAX BRUSH OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-BRUSH>
<SYNTAX BRUSH OBJECT (HELD CARRIED ON-GROUND IN-ROOM)
	WITH OBJECT = V-BRUSH>
<SYNONYM BRUSH CLEAN>

<SYNTAX BUG = V-BUG>

<SYNTAX BURN OBJECT (FIND BURNBIT) (HELD CARRIED ON-GROUND IN-ROOM)
	WITH OBJECT (FIND FLAMEBIT) (HELD CARRIED ON-GROUND IN-ROOM HAVE)
	= V-BURN PRE-BURN>
<SYNTAX BURN DOWN OBJECT (FIND BURNBIT) (HELD CARRIED ON-GROUND IN-ROOM)
	WITH OBJECT (FIND FLAMEBIT) (HELD CARRIED ON-GROUND IN-ROOM HAVE)
	= V-BURN PRE-BURN>
<SYNONYM BURN INCINERATE IGNITE>

<SYNTAX CHOMP = V-CHOMP>
<SYNONYM CHOMP LOSE BARF>

<SYNTAX CLIMB UP OBJECT (FIND RMUNGBIT) = V-CLIMB-UP>
<SYNTAX CLIMB UP OBJECT (FIND CLIMBBIT) (ON-GROUND IN-ROOM) = V-CLIMB-UP>
<SYNTAX CLIMB DOWN OBJECT (FIND RMUNGBIT) = V-CLIMB-DOWN>
<SYNTAX CLIMB DOWN OBJECT (FIND CLIMBBIT) (ON-GROUND IN-ROOM) = V-CLIMB-DOWN>
<SYNTAX CLIMB OBJECT (FIND CLIMBBIT) (ON-GROUND IN-ROOM) = V-CLIMB-FOO>
<SYNTAX CLIMB IN OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-BOARD PRE-BOARD>
<SYNTAX CLIMB ON OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-CLIMB-ON>
<SYNTAX CLIMB WITH OBJECT = V-THROUGH>
<SYNONYM CLIMB SIT>	

<SYNTAX CLOSE OBJECT (FIND DOORBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-CLOSE>

<SYNTAX COMMAND OBJECT (FIND ACTORBIT) = V-COMMAND>

<SYNTAX COUNT OBJECT = V-COUNT>

<SYNTAX CROSS OBJECT = V-CROSS>
<SYNONYM CROSS FORD>

<SYNTAX CUT OBJECT WITH OBJECT (FIND WEAPONBIT) (CARRIED HELD) = V-CUT>
<SYNONYM CUT SLICE PIERCE>

<SYNTAX CURSE = V-CURSES>
<SYNTAX CURSE OBJECT (FIND ACTORBIT) = V-CURSES>
<SYNONYM CURSE SHIT FUCK DAMN>

<SYNTAX DEFLATE OBJECT = V-DEFLATE>

<SYNTAX DESTROY OBJECT (ON-GROUND IN-ROOM HELD CARRIED)
	WITH OBJECT (HELD CARRIED TAKE)	= V-MUNG PRE-MUNG>
<SYNTAX DESTROY DOWN OBJECT (ON-GROUND IN-ROOM HELD CARRIED)
	WITH OBJECT (HELD CARRIED TAKE)	= V-MUNG PRE-MUNG>
<SYNTAX DESTROY IN OBJECT (ON-GROUND IN-ROOM HELD CARRIED) = V-OPEN>
<SYNONYM DESTROY DAMAGE BREAK BLOCK SMASH>

<SYNTAX DIG IN OBJECT (ON-GROUND IN-ROOM) = V-DIG>
<SYNTAX DIG IN OBJECT (ON-GROUND IN-ROOM)
	WITH OBJECT (FIND TOOLBIT) (HELD CARRIED HAVE) = V-DIG>
<SYNTAX DIG OBJECT (ON-GROUND IN-ROOM)
	WITH OBJECT (FIND TOOLBIT) (HELD CARRIED HAVE) = V-DIG>

<SYNTAX DISEMBARK OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM)
	= V-DISEMBARK>

<SYNTAX DISENCHANT OBJECT = V-DISENCHANT>

<SYNTAX DRINK OBJECT (FIND DRINKBIT) (HELD CARRIED ON-GROUND IN-ROOM)
	= V-DRINK>
<SYNTAX DRINK FROM OBJECT (HELD CARRIED) = V-DRINK-FROM>
<SYNONYM DRINK IMBIBE SWALLOW>

<SYNTAX DROP OBJECT (HELD MANY HAVE) = V-DROP PRE-DROP>
<SYNTAX DROP OBJECT (HELD MANY HAVE) DOWN OBJECT = V-PUT PRE-PUT>
<SYNTAX DROP OBJECT (HELD MANY HAVE) IN OBJECT = V-PUT PRE-PUT>
<SYNTAX DROP OBJECT (HELD MANY HAVE) ON OBJECT = V-PUT-ON PRE-PUT>

<SYNTAX EAT OBJECT (FIND FOODBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE)
	= V-EAT>
<SYNONYM EAT CONSUME TASTE BITE>

<SYNTAX ECHO = V-ECHO>

<SYNTAX ENCHANT OBJECT (ON-GROUND IN-ROOM) = V-ENCHANT>

<SYNTAX ENTER = V-ENTER>
<SYNTAX ENTER OBJECT = V-THROUGH>
<SYNTAX EXIT = V-EXIT>
<SYNTAX EXIT OBJECT = V-EXIT>

<SYNTAX EXAMINE OBJECT (MANY) = V-EXAMINE>
<SYNTAX EXAMINE IN OBJECT (HELD CARRIED IN-ROOM ON-GROUND MANY)
	= V-LOOK-INSIDE>
<SYNTAX EXAMINE ON OBJECT (HELD CARRIED IN-ROOM ON-GROUND MANY)
	= V-LOOK-INSIDE>
<SYNONYM EXAMINE DESCRIBE WHAT WHATS>

<SYNTAX EXORCISE OBJECT = V-EXORCISE>
<SYNTAX EXORCISE OUT OBJECT (FIND ACTORBIT) = V-EXORCISE>
<SYNTAX EXORCISE AWAY OBJECT (FIND ACTORBIT) = V-EXORCISE>
<SYNONYM EXORCISE BANISH CAST DRIVE BEGONE>

<SYNTAX EXTINGUISH OBJECT (FIND ONBIT)
	(HELD CARRIED ON-GROUND IN-ROOM TAKE HAVE) = V-LAMP-OFF>
<SYNONYM EXTINGUISH DOUSE>

<SYNTAX FILL OBJECT (FIND CONTBIT) (HELD CARRIED ON-GROUND IN-ROOM)
	WITH OBJECT = V-FILL PRE-FILL>
<SYNTAX FILL OBJECT (FIND CONTBIT)
	(HELD CARRIED ON-GROUND IN-ROOM) = V-FILL PRE-FILL>

<SYNTAX FIND OBJECT = V-FIND>
<SYNONYM FIND WHERE SEEK SEE>

<SYNTAX FOLLOW = V-FOLLOW>
<SYNTAX FOLLOW OBJECT = V-FOLLOW>
<SYNONYM FOLLOW PURSUE CHASE COME>

<SYNTAX FROBOZZ = V-FROBOZZ>

<SYNTAX GIVE OBJECT (MANY HELD HAVE)
	TO OBJECT (FIND ACTORBIT) (ON-GROUND) = V-GIVE PRE-GIVE>
<SYNTAX GIVE OBJECT (FIND ACTORBIT) (ON-GROUND)
	OBJECT (MANY HELD HAVE)	= V-SGIVE PRE-SGIVE>
<SYNONYM GIVE DONATE OFFER FEED>
<COND (<N==? ,ZORK-NUMBER 3>
       <SYNONYM GIVE HAND>)>

<SYNTAX HATCH OBJECT = V-HATCH>

<SYNTAX HELLO = V-HELLO>
<SYNTAX HELLO OBJECT = V-HELLO>
<SYNONYM HELLO HI>

<SYNTAX INCANT = V-INCANT>
<SYNONYM INCANT CHANT>

<SYNTAX INFLAT OBJECT WITH
	OBJECT (FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CARRIED) = V-INFLATE>

<SYNTAX JUMP = V-LEAP>
<SYNTAX JUMP OVER OBJECT = V-LEAP>
<SYNTAX JUMP ACROSS OBJECT = V-LEAP>
<SYNTAX JUMP IN OBJECT = V-LEAP>
<SYNTAX JUMP FROM OBJECT = V-LEAP>
<SYNTAX JUMP OFF OBJECT = V-LEAP>
<SYNONYM JUMP LEAP DIVE>

<SYNTAX KICK OBJECT = V-KICK>
<SYNONYM KICK TAUNT>

<COND (<==? ,ZORK-NUMBER 2>
       <SYNTAX KILL OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM)
	       = V-ATTACK>)>

<SYNTAX KILL OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM)
	WITH OBJECT (FIND WEAPONBIT) (HELD CARRIED HAVE) = V-ATTACK>
<SYNONYM KILL MURDER SLAY DISPATCH>

<SYNTAX STAB OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-STAB>
<SYNTAX STAB OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM)
	WITH OBJECT (FIND WEAPONBIT) (HELD CARRIED HAVE) = V-ATTACK>

<SYNTAX KISS OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-KISS>

<SYNTAX KNOCK AT OBJECT = V-KNOCK>
<SYNTAX KNOCK ON OBJECT = V-KNOCK>
<SYNTAX KNOCK DOWN OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-ATTACK>
<SYNONYM KNOCK RAP>

<SYNTAX LAUNCH OBJECT (FIND VEHBIT) = V-LAUNCH>

<SYNTAX LEAN ON OBJECT (HELD HAVE) = V-LEAN-ON>

<SYNTAX LEAVE = V-LEAVE>
<SYNTAX LEAVE OBJECT = V-DROP PRE-DROP>

<SYNTAX LIGHT OBJECT (FIND LIGHTBIT)
	(HELD CARRIED ON-GROUND IN-ROOM TAKE HAVE) = V-LAMP-ON>
<SYNTAX LIGHT OBJECT (FIND LIGHTBIT) (HELD CARRIED ON-GROUND IN-ROOM)
	WITH OBJECT (FIND FLAMEBIT) (HELD CARRIED TAKE HAVE) = V-BURN PRE-BURN>

<SYNTAX LISTEN TO OBJECT = V-LISTEN>
<SYNTAX LISTEN FOR OBJECT = V-LISTEN>

<SYNTAX LOCK OBJECT (ON-GROUND IN-ROOM)	WITH
	OBJECT (FIND TOOLBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE) = V-LOCK>

<SYNTAX LOOK = V-LOOK>
<SYNTAX LOOK AROUND OBJECT (FIND RMUNGBIT) = V-LOOK>
<SYNTAX LOOK UP OBJECT (FIND RMUNGBIT) = V-LOOK>
<SYNTAX LOOK DOWN OBJECT (FIND RMUNGBIT) = V-LOOK>
<SYNTAX LOOK AT OBJECT (HELD CARRIED ON-GROUND IN-ROOM MANY) = V-EXAMINE>
<SYNTAX LOOK ON OBJECT = V-LOOK-ON>
<SYNTAX LOOK WITH OBJECT (HELD CARRIED ON-GROUND IN-ROOM MANY) = V-LOOK-INSIDE>
<SYNTAX LOOK UNDER OBJECT = V-LOOK-UNDER>
<SYNTAX LOOK BEHIND OBJECT = V-LOOK-BEHIND>
<SYNTAX LOOK IN OBJECT (HELD CARRIED ON-GROUND IN-ROOM MANY) = V-LOOK-INSIDE>
<SYNTAX LOOK AT OBJECT (HELD CARRIED ON-GROUND IN-ROOM)
	WITH OBJECT = V-READ PRE-READ>
<SYNTAX LOOK FOR OBJECT = V-FIND>
<SYNONYM LOOK L STARE GAZE>

<SYNTAX LOWER OBJECT = V-LOWER>

<SYNTAX LUBRICATE OBJECT WITH OBJECT (HELD CARRIED) = V-OIL>
<SYNONYM LUBRICATE OIL GREASE>

<SYNTAX MAKE OBJECT = V-MAKE>

<SYNTAX MELT OBJECT
	WITH OBJECT (FIND FLAMEBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-MELT>
<SYNONYM MELT LIQUIFY>

<SYNTAX MOVE OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
<SYNTAX MOVE OBJECT (ON-GROUND IN-ROOM) OBJECT = V-PUSH-TO>
<SYNTAX MOVE OBJECT (ON-GROUND IN-ROOM) TO OBJECT = V-PUSH-TO>
<SYNTAX MOVE OBJECT (HELD MANY HAVE) IN OBJECT = V-PUT PRE-PUT>
<SYNTAX MOVE OBJECT WITH OBJECT (FIND TOOLBIT) = V-TURN PRE-TURN>
<SYNTAX ROLL UP OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
<SYNTAX ROLL OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>

<SYNTAX MUMBLE = V-MUMBLE>
<SYNONYM MUMBLE SIGH>

<SYNTAX ODYSSEUS = V-ODYSSEUS>
<SYNONYM ODYSSEUS ULYSSES>

<SYNTAX OPEN OBJECT (FIND DOORBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-OPEN>
<SYNTAX OPEN UP	OBJECT (FIND DOORBIT) (HELD CARRIED ON-GROUND IN-ROOM)
	= V-OPEN>
<SYNTAX OPEN OBJECT (FIND DOORBIT) (HELD CARRIED ON-GROUND IN-ROOM) WITH
	OBJECT (FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CARRIED HAVE) = V-OPEN>

<SYNTAX PICK OBJECT = V-PICK>
<SYNTAX PICK OBJECT WITH OBJECT = V-PICK>
<SYNTAX PICK UP	OBJECT (FIND TAKEBIT) (ON-GROUND MANY) = V-TAKE PRE-TAKE>

<SYNTAX PLAY OBJECT = V-PLAY>

<SYNTAX PLUG OBJECT WITH OBJECT = V-PLUG>
<SYNONYM PLUG GLUE PATCH REPAIR FIX>

<SYNTAX PLUGH = V-ADVENT>
<SYNONYM PLUGH XYZZY>

<SYNTAX POKE OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM)
	WITH OBJECT (FIND WEAPONBIT) (HELD CARRIED HAVE) = V-MUNG PRE-MUNG>
<SYNTAX PUNCTURE OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM)
	WITH OBJECT (FIND WEAPONBIT) (HELD CARRIED HAVE) = V-MUNG PRE-MUNG>

<SYNTAX POUR OBJECT (HELD CARRIED) = V-DROP PRE-DROP>
<SYNTAX POUR OBJECT (HELD CARRIED) IN OBJECT = V-DROP PRE-DROP>
<SYNTAX POUR OBJECT (HELD CARRIED) ON OBJECT = V-POUR-ON>
<SYNTAX POUR OBJECT (HELD CARRIED) FROM OBJECT = V-DROP PRE-DROP>
<SYNONYM POUR SPILL>

<SYNTAX PRAY = V-PRAY>

<SYNTAX PULL OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
<SYNTAX PULL ON OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
<SYNTAX PULL UP OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
<SYNONYM PULL TUG YANK>

<SYNTAX PUMP UP OBJECT = V-PUMP>
<SYNTAX PUMP UP OBJECT WITH OBJECT = V-PUMP>

<SYNTAX PUSH OBJECT (IN-ROOM ON-GROUND) OBJECT = V-PUSH-TO>
<SYNTAX PUSH OBJECT (IN-ROOM ON-GROUND) TO OBJECT = V-PUSH-TO>
<SYNTAX PUSH OBJECT (IN-ROOM ON-GROUND MANY) = V-PUSH>
<SYNTAX PUSH ON OBJECT (IN-ROOM ON-GROUND MANY) = V-PUSH>
<SYNTAX PUSH OBJECT WITH OBJECT (FIND TOOLBIT) = V-TURN PRE-TURN>
<SYNTAX PUSH OBJECT UNDER OBJECT = V-PUT-UNDER>
<SYNONYM PUSH PRESS>

<SYNTAX PUT OBJECT (HELD MANY HAVE) IN OBJECT = V-PUT PRE-PUT>
<SYNTAX PUT OBJECT (HELD MANY HAVE) ON OBJECT = V-PUT-ON PRE-PUT>
<SYNTAX PUT DOWN OBJECT (HELD MANY) = V-DROP PRE-DROP>
<SYNTAX PUT OBJECT (HELD HAVE) UNDER OBJECT = V-PUT-UNDER> 
<SYNTAX PUT OUT OBJECT (FIND ONBIT)
	(HELD CARRIED ON-GROUND IN-ROOM TAKE HAVE) = V-LAMP-OFF>
<SYNTAX PUT ON OBJECT (IN-ROOM ON-GROUND CARRIED MANY) = V-WEAR>
<SYNTAX PUT OBJECT (HELD MANY HAVE) BEHIND OBJECT = V-PUT-BEHIND>
<SYNONYM PUT STUFF INSERT PLACE HIDE>

<SYNTAX RAISE OBJECT = V-RAISE>
<SYNTAX RAISE UP OBJECT = V-RAISE>
<SYNONYM RAISE LIFT>

<SYNTAX RAPE OBJECT (FIND ACTORBIT) = V-RAPE>
<SYNONYM RAPE MOLEST>

<SYNTAX READ OBJECT (FIND READBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE)
	= V-READ PRE-READ>
<SYNTAX READ FROM OBJECT (FIND READBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE)
	= V-READ PRE-READ>
<SYNTAX READ OBJECT (FIND READBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE)
	WITH OBJECT = V-READ PRE-READ>
<SYNTAX READ OBJECT (FIND READBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE)
	OBJECT = V-READ-PAGE>
<SYNONYM READ SKIM>

<SYNTAX REPENT = V-REPENT>

<SYNTAX RING OBJECT (TAKE) = V-RING>
<SYNTAX RING OBJECT (TAKE) WITH OBJECT = V-RING>
<SYNONYM RING PEAL>

<SYNTAX RUB OBJECT = V-RUB>
<SYNTAX RUB OBJECT WITH OBJECT = V-RUB>
<SYNONYM RUB TOUCH FEEL PAT PET>

<SYNTAX TALK TO OBJECT (FIND ACTORBIT) (IN-ROOM) = V-TELL>
<SYNTAX SAY = V-SAY>

<SYNTAX SEARCH OBJECT = V-SEARCH>
<SYNTAX SEARCH IN OBJECT = V-SEARCH>
<SYNTAX SEARCH FOR OBJECT = V-FIND>

<SYNTAX SEND FOR OBJECT = V-SEND>

<SYNTAX SHAKE OBJECT (HAVE) = V-SHAKE>

<SYNTAX SKIP = V-SKIP>
<SYNONYM SKIP HOP>

<SYNTAX SLIDE OBJECT UNDER OBJECT = V-PUT-UNDER>
<SYNTAX SLIDE OBJECT (IN-ROOM ON-GROUND) OBJECT = V-PUSH-TO>
<SYNTAX SLIDE OBJECT (IN-ROOM ON-GROUND) TO OBJECT = V-PUSH-TO>

<SYNTAX SMELL OBJECT = V-SMELL>
<SYNONYM SMELL SNIFF>

<SYNTAX SPIN OBJECT = V-SPIN>

<SYNTAX SPRAY OBJECT ON OBJECT = V-SPRAY>
<SYNTAX SPRAY OBJECT WITH OBJECT = V-SSPRAY>

<SYNTAX SQUEEZE OBJECT = V-SQUEEZE>
<SYNTAX SQUEEZE OBJECT ON OBJECT = V-PUT PRE-PUT>

<SYNTAX STAND = V-STAND>
<SYNTAX STAND UP OBJECT (FIND RMUNGBIT) = V-STAND>

<SYNTAX STAY = V-STAY>

<SYNTAX STRIKE OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT
	(FIND WEAPONBIT) (HELD CARRIED ON-GROUND IN-ROOM HAVE) = V-ATTACK>
<SYNTAX STRIKE OBJECT (ON-GROUND IN-ROOM HELD CARRIED) = V-STRIKE>

<SYNTAX SWIM = V-SWIM>
<SYNTAX SWIM IN OBJECT = V-SWIM>
<SYNTAX SWIM ACROSS OBJECT = V-SWIM>
<SYNONYM SWIM BATHE WADE>

<SYNTAX SWING OBJECT (FIND WEAPONBIT) (HELD CARRIED HAVE) = V-SWING>
<SYNTAX SWING OBJECT (FIND WEAPONBIT) (HELD CARRIED HAVE)
	AT OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-SWING>
<SYNONYM SWING THRUST>

<SYNTAX TAKE OBJECT (FIND TAKEBIT) (ON-GROUND IN-ROOM MANY) = V-TAKE PRE-TAKE>
<SYNTAX TAKE IN OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-BOARD PRE-BOARD>
<SYNTAX TAKE OUT OBJECT (FIND RMUNGBIT) (ON-GROUND IN-ROOM) = V-DISEMBARK>
<SYNTAX TAKE ON OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-CLIMB-ON>
<SYNTAX TAKE UP OBJECT (FIND RMUNGBIT) = V-STAND>
<SYNTAX TAKE OBJECT (FIND TAKEBIT) (CARRIED IN-ROOM MANY)
	OUT OBJECT = V-TAKE PRE-TAKE>
<SYNTAX TAKE OBJECT (FIND TAKEBIT) (CARRIED IN-ROOM MANY)
	OFF OBJECT = V-TAKE PRE-TAKE>
<SYNTAX TAKE OBJECT (FIND TAKEBIT) (IN-ROOM CARRIED MANY)
	FROM OBJECT = V-TAKE PRE-TAKE>
<SYNONYM TAKE GET HOLD CARRY REMOVE GRAB CATCH>

<SYNTAX TELL OBJECT (FIND ACTORBIT) (IN-ROOM) = V-TELL>
<SYNTAX TELL OBJECT (FIND ACTORBIT) (IN-ROOM) ABOUT OBJECT = V-TELL>
<SYNONYM TELL ASK>

<SYNTAX THROW OBJECT (HELD CARRIED HAVE)
	AT OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-THROW>
<SYNTAX THROW OBJECT (HELD CARRIED HAVE)
	WITH OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-THROW>
<SYNTAX THROW OBJECT OBJECT = V-OVERBOARD>
<SYNTAX THROW OBJECT (HELD CARRIED HAVE) IN OBJECT = V-PUT PRE-PUT>
<SYNTAX THROW OBJECT (HELD CARRIED HAVE) ON OBJECT = V-PUT-ON PRE-PUT>
<SYNTAX THROW OBJECT (HELD CARRIED HAVE) OFF OBJECT = V-THROW-OFF>
<SYNTAX THROW OBJECT (HELD CARRIED HAVE) OVER OBJECT = V-THROW-OFF>
<SYNONYM THROW HURL CHUCK TOSS>

<SYNTAX TIE OBJECT TO OBJECT = V-TIE>
<SYNTAX TIE UP OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT
	(FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CARRIED HAVE) = V-TIE-UP>
<SYNONYM TIE FASTEN SECURE ATTACH>

<SYNTAX TREASURE = V-TREASURE>
<SYNONYM TREASURE TEMPLE>

<SYNTAX TURN OBJECT (FIND TURNBIT) (HELD CARRIED ON-GROUND IN-ROOM)
	WITH OBJECT (FIND RMUNGBIT) = V-TURN PRE-TURN>
<SYNTAX TURN ON	OBJECT (FIND LIGHTBIT)
	(HELD CARRIED ON-GROUND IN-ROOM) = V-LAMP-ON>
<SYNTAX TURN ON OBJECT WITH OBJECT (HAVE) = V-LAMP-ON>
<SYNTAX TURN OFF OBJECT (FIND ONBIT)
	(HELD CARRIED ON-GROUND IN-ROOM TAKE HAVE) = V-LAMP-OFF>
<SYNTAX TURN OBJECT (FIND TURNBIT) TO OBJECT = V-TURN PRE-TURN>
<SYNTAX TURN OBJECT (FIND TURNBIT) FOR OBJECT = V-TURN PRE-TURN>
<SYNONYM TURN SET FLIP SHUT>

<SYNTAX UNLOCK OBJECT (ON-GROUND IN-ROOM) WITH OBJECT
	(FIND TOOLBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE) = V-UNLOCK>

<SYNTAX UNTIE OBJECT (ON-GROUND IN-ROOM HELD CARRIED) = V-UNTIE>
<SYNTAX UNTIE OBJECT (ON-GROUND IN-ROOM HELD CARRIED)
	FROM OBJECT = V-UNTIE>
<SYNONYM UNTIE FREE RELEASE UNFASTEN UNATTACH UNHOOK>

<SYNTAX WAIT = V-WAIT>
<SYNONYM WAIT Z>

<SYNTAX WAKE OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-ALARM>
<SYNTAX WAKE UP OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-ALARM>
<SYNONYM WAKE AWAKE SURPRISE STARTLE>

<SYNTAX WALK = V-WALK-AROUND>
<SYNTAX WALK OBJECT = V-WALK>
<SYNTAX WALK AWAY OBJECT = V-WALK>
<SYNTAX WALK IN OBJECT = V-THROUGH>
<SYNTAX WALK WITH OBJECT = V-THROUGH>
<SYNTAX WALK ON OBJECT = V-THROUGH>
<SYNTAX WALK OVER OBJECT = V-LEAP>
<SYNTAX WALK TO OBJECT = V-WALK-TO>
<SYNTAX WALK AROUND OBJECT = V-WALK-AROUND>
<SYNTAX WALK UP OBJECT (FIND CLIMBBIT) (ON-GROUND IN-ROOM) = V-CLIMB-UP>
<SYNTAX WALK DOWN OBJECT (FIND CLIMBBIT) (ON-GROUND IN-ROOM) = V-CLIMB-DOWN>
<SYNONYM WALK GO RUN PROCEED STEP>

<SYNTAX WAVE OBJECT (HELD CARRIED TAKE HAVE) = V-WAVE>
<SYNTAX WAVE OBJECT (HELD CARRIED TAKE HAVE) AT OBJECT = V-WAVE>
<SYNTAX WAVE AT OBJECT = V-WAVE>
<SYNONYM WAVE BRANDISH>

<SYNTAX WEAR OBJECT = V-WEAR>

<SYNTAX WIN = V-WIN>
<SYNONYM WIN WINNAGE>

<SYNTAX WIND OBJECT = V-WIND>
<SYNTAX WIND UP OBJECT = V-WIND>

<SYNTAX WISH = V-WISH>

<SYNTAX YELL = V-YELL>
<SYNONYM YELL SCREAM SHOUT>

<SYNTAX ZORK = V-ZORK>

;-------------------------------------------------------
"MACROS"
;-------------------------------------------------------
"GMACROS for
			    The Zork Trilogy
	 (c) Copyright 1983 Infocom, Inc.  All Rights Reserved"

<SETG C-ENABLED? 0>
<SETG C-ENABLED 1>
<SETG C-DISABLED 0>

<DEFMAC TELL ("ARGS" A)
	<FORM PROG ()
	      !<MAPF ,LIST
		     <FUNCTION ("AUX" E P O)
			  <COND (<EMPTY? .A> <MAPSTOP>)
				(<SET E <NTH .A 1>>
				 <SET A <REST .A>>)>
			  <COND (<TYPE? .E ATOM>
				 <COND (<OR <=? <SET P <SPNAME .E>>
						"CRLF">
					    <=? .P "CR">>
					<MAPRET '<CRLF>>)
				       (<EMPTY? .A>
					<ERROR INDICATOR-AT-END? .E>)
				       (ELSE
					<SET O <NTH .A 1>>
					<SET A <REST .A>>
					<COND (<OR <=? <SET P <SPNAME .E>>
						       "DESC">
						   <=? .P "D">
						   <=? .P "OBJ">
						   <=? .P "O">>
					       <MAPRET <FORM PRINTD .O>>)
					      (<OR <=? .P "A">
						   <=? .P "AN">>
					       <MAPRET <FORM PRINTA .O>>)
					      (<OR <=? .P "NUM">
						   <=? .P "N">>
					       <MAPRET <FORM PRINTN .O>>)
					      (<OR <=? .P "CHAR">
						   <=? .P "CHR">
						   <=? .P "C">>
					       <MAPRET <FORM PRINTC .O>>)
					      (ELSE
					       <MAPRET
						 <FORM PRINT
						       <FORM GETP .O .E>>>)>)>)
				(<TYPE? .E STRING ZSTRING>
				 <MAPRET <FORM PRINTI .E>>)
				(<TYPE? .E FORM LVAL GVAL>
				 <MAPRET <FORM PRINT .E>>)
				(ELSE <ERROR UNKNOWN-TYPE .E>)>>>>>

<DEFMAC VERB? ("ARGS" ATMS)
	<MULTIFROB PRSA .ATMS>>

<DEFMAC PRSO? ("ARGS" ATMS)
	<MULTIFROB PRSO .ATMS>>

<DEFMAC PRSI? ("ARGS" ATMS)
	<MULTIFROB PRSI .ATMS>>

<DEFMAC ROOM? ("ARGS" ATMS)
	<MULTIFROB HERE .ATMS>>

<DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (L ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .OO 1> <ERROR .X>)
				       (<LENGTH? .OO 2> <NTH .OO 2>)
				       (ELSE <CHTYPE .OO FORM>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<COND (<TYPE? .ATM ATOM>
				     <FORM GVAL
					   <COND (<==? .X PRSA>
						  <PARSE
						    <STRING "V?"
							    <SPNAME .ATM>>>)
						 (ELSE .ATM)>>)
				    (ELSE .ATM)>
			      !.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O <REST <PUTREST .O (<FORM EQUAL? <FORM GVAL .X> !.L>)>>>
		<SET L ()>>>

<DEFMAC BSET ('OBJ "ARGS" BITS)
	<MULTIBITS FSET .OBJ .BITS>>

<DEFMAC BCLEAR ('OBJ "ARGS" BITS)
	<MULTIBITS FCLEAR .OBJ .BITS>>

<DEFMAC BSET? ('OBJ "ARGS" BITS)
	<MULTIBITS FSET? .OBJ .BITS>>

<DEFINE MULTIBITS (X OBJ ATMS "AUX" (O ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
				       (<==? .X FSET?> <FORM OR !.O>)
				       (ELSE <FORM PROG () !.O>)>>)>
		<SET ATM <NTH .ATMS 1>>
		<SET ATMS <REST .ATMS>>
		<SET O
		     (<FORM .X
			    .OBJ
			    <COND (<TYPE? .ATM FORM> .ATM)
				  (ELSE <FORM GVAL .ATM>)>>
		      !.O)>>>

<DEFMAC RFATAL ()
	'<PROG () <PUSH 2> <RSTACK>>>

<DEFMAC PROB ('BASE? "OPTIONAL" 'LOSER?)
	<COND (<ASSIGNED? LOSER?> <FORM ZPROB .BASE?>)
	      (ELSE <FORM G? .BASE? '<RANDOM 100>>)>>

<ROUTINE ZPROB
	 (BASE)
	 <COND (,LUCKY <G? .BASE <RANDOM 100>>)
	       (ELSE <G? .BASE <RANDOM 300>>)>>

<ROUTINE RANDOM-ELEMENT (FROB)
	 <GET .FROB <RANDOM <GET .FROB 0>>>>

<ROUTINE PICK-ONE (FROB
		   "AUX" (L <GET .FROB 0>) (CNT <GET .FROB 1>) RND MSG RFROB)
	 <SET L <- .L 1>>
	 <SET FROB <REST .FROB 2>>
	 <SET RFROB <REST .FROB <* .CNT 2>>>
	 <SET RND <RANDOM <- .L .CNT>>>
	 <SET MSG <GET .RFROB .RND>>
	 <PUT .RFROB .RND <GET .RFROB 1>>
	 <PUT .RFROB 1 .MSG>
	 <SET CNT <+ .CNT 1>>
	 <COND (<==? .CNT .L> <SET CNT 0>)>
	 <PUT .FROB 0 .CNT>
	 .MSG>

<DEFMAC ENABLE ('INT) <FORM PUT .INT ,C-ENABLED? 1>>

<DEFMAC DISABLE ('INT) <FORM PUT .INT ,C-ENABLED? 0>>

<DEFMAC FLAMING? ('OBJ)
	<FORM AND <FORM FSET? .OBJ ',FLAMEBIT>
	          <FORM FSET? .OBJ ',ONBIT>>>

<DEFMAC OPENABLE? ('OBJ)
	<FORM OR <FORM FSET? .OBJ ',DOORBIT>
	         <FORM FSET? .OBJ ',CONTBIT>>> 

<DEFMAC ABS ('NUM)
	<FORM COND (<FORM L? .NUM 0> <FORM - 0 .NUM>)
	           (T .NUM)>>
			   
;-------------------------------------------------------
"VERBS"
;-------------------------------------------------------
 			"Generic VERBS file for
			    The ZORK Trilogy
		       started on 7/25/83 by SEM"

^L

"Verb Functions for Game Commands"

<GLOBAL VERBOSE <>>
<GLOBAL SUPER-BRIEF <>>
<GDECL (VERBOSE SUPER-BRIEF) <OR ATOM FALSE>>

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSE T>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Maximum verbosity." CR>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSE <>>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Brief descriptions." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG SUPER-BRIEF T>
	 <TELL "Superbrief descriptions." CR>>

;"V-DIAGNOSE is in ACTIONS.ZIL"

<ROUTINE V-INVENTORY ()
	 <COND (<FIRST? ,WINNER> <PRINT-CONT ,WINNER>)
	       (T <TELL "You are empty-handed." CR>)>>

<ROUTINE FINISH ("AUX" WRD)
	 <V-SCORE>
	 <REPEAT ()
		 <CRLF>
		 <TELL
"Would you like to restart the game from the beginning, restore a saved
game position, or end this session of the game?|
(Type RESTART, RESTORE, or QUIT):|
>">
		 <READ ,P-INBUF ,P-LEXV>
		 <SET WRD <GET ,P-LEXV 1>>
		 <COND (<EQUAL? .WRD ,W?RESTART>
			<RESTART>
			<TELL "Failed." CR>)
		       (<EQUAL? .WRD ,W?RESTORE>
			<COND (<RESTORE>
			       <TELL "Ok." CR>)
			      (T
			       <TELL "Failed." CR>)>)
		       (<EQUAL? .WRD ,W?QUIT ,W?Q>
			<QUIT>)>>>

<ROUTINE V-QUIT ("AUX" SCOR)
	 <V-SCORE>
	 <TELL 
"Do you wish to leave the game? (Y is affirmative): ">
	 <COND (<YES?>
		<QUIT>)
	       (ELSE <TELL "Ok." CR>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE T>
	 <TELL "Do you wish to restart? (Y is affirmative): ">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL "Failed." CR>)>>

<ROUTINE V-RESTORE ()
	 <COND (<RESTORE>
		<TELL "Ok." CR>
		<V-FIRST-LOOK>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-SAVE ()
	 <COND (<SAVE>
	        <TELL "Ok." CR>)
	       (T
		<TELL "Failed." CR>)>>

;"V-SCORE is in ACTIONS.ZIL"

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TELL "Here begins a transcript of interaction with" CR>
	<V-VERSION>
	<RTRUE>>

<ROUTINE V-UNSCRIPT ()
	<TELL "Here ends a transcript of interaction with" CR>
	<V-VERSION>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<ROUTINE V-VERSION ("AUX" (CNT 17))
	%<COND (<==? ,ZORK-NUMBER 1>
		'<TELL "ZORK I: The Great Underground Empire|
Infocom interactive fiction - a fantasy story|
|
This version i slightly modified to allow unlimited carry capacity and almost|
unlimited batteries in the lantern.|
|
Copyright (c) 1981, 1982, 1983, 1984, 1985, 1986">)
	       (<==? ,ZORK-NUMBER 2>
		'<TELL "ZORK II: The Wizard of Frobozz|
Infocom interactive fiction - a fantasy story|
Copyright (c) 1981, 1982, 1983, 1986">)
	       (<==? ,ZORK-NUMBER 3>
		'<TELL "ZORK III: The Dungeon Master|
Infocom interactive fiction - a fantasy story|
Copyright 1982, 1983, 1984, 1986">)>
	<TELL " Infocom, Inc. All rights reserved." CR>
	<TELL "ZORK is a registered trademark of Infocom, Inc.|
Release ">
	<PRINTN <BAND <GET 0 1> *3777*>>
	<TELL " / Serial number ">
	<REPEAT ()
		<COND (<G? <SET CNT <+ .CNT 1>> 23>
		       <RETURN>)
		      (T
		       <PRINTC <GETB 0 .CNT>>)>>
	<CRLF>>

<ROUTINE V-VERIFY ()
	 <TELL "Verifying disk..." CR>
	 <COND (<VERIFY>
		<TELL "The disk is correct." CR>)
	       (T
		<TELL CR "** Disk Failure **" CR>)>>

<ROUTINE V-COMMAND-FILE ()
	 <DIRIN 1>
	 <RTRUE>>

<ROUTINE V-RANDOM ()
	 <COND (<NOT <EQUAL? ,PRSO ,INTNUM>>
		<TELL "Illegal call to #RND." CR>)
	       (T
		<RANDOM <- 0 ,P-NUMBER>>
		<RTRUE>)>>

<ROUTINE V-RECORD ()
	 <DIROUT 4>
	 <RTRUE>>

<ROUTINE V-UNRECORD ()
	 <DIROUT -4>
	 <RTRUE>>

^L

"Real Verb Functions"

<ROUTINE V-ADVENT ()
	 <TELL "A hollow voice says \"Fool.\"" CR>>

<ROUTINE V-ALARM ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND %<COND (<==? ,ZORK-NUMBER 1>
			      '(<L? <GETP ,PRSO ,P?STRENGTH> 0>
		                <TELL "The " D ,PRSO " is rudely awakened." CR>
		                <AWAKEN ,PRSO>))
			     (T
			      '(<NULL-F> <RTRUE>))>
		      (T
		       <TELL
"He's wide awake, or haven't you noticed..." CR>)>)
	       (T
		<TELL "The " D ,PRSO " isn't sleeping." CR>)>>

<ROUTINE V-ANSWER ()
	 <TELL "Nobody seems to be awaiting your answer." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-ATTACK ()
	 <COND (<NOT <FSET? ,PRSO ,ACTORBIT>>
		<TELL
"I've known strange people, but fighting a " D ,PRSO "?" CR>)
	       (<OR <NOT ,PRSI>
		    <EQUAL? ,PRSI ,HANDS>>
		<TELL
"Trying to attack a " D ,PRSO " with your bare hands is suicidal." CR>)
	       (<NOT <IN? ,PRSI ,WINNER>>
		<TELL "You aren't even holding the " D ,PRSI "." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL
"Trying to attack the " D ,PRSO " with a " D ,PRSI " is suicidal." CR>)
	       (T
	        %<COND (<==? ,ZORK-NUMBER 1>
			'<HERO-BLOW>)
		       (T
			'<TELL "You can't." CR>)>)>>

<ROUTINE V-BACK ()
	 <TELL "Sorry, my memory is poor. Please give a direction." CR>>

<ROUTINE V-BLAST ()
	 <TELL "You can't blast anything by using words." CR>>

<ROUTINE PRE-BOARD ("AUX" AV)
	 <SET AV <LOC ,WINNER>>
	 <COND %<COND (<==? ,ZORK-NUMBER 3>
		       '(<EQUAL? ,PRSO ,WATER-CHANNEL ,TM-SEAT ,LAKE>
		         <RFALSE>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (<FSET? ,PRSO ,VEHBIT>
		<COND (<NOT <IN? ,PRSO ,HERE>>
		       <TELL
"The " D ,PRSO " must be on the ground to be boarded." CR>)
		      (<FSET? .AV ,VEHBIT>
		       <TELL "You are already in the " D .AV "!" CR>)
		      (T
		       <RFALSE>)>)
	       (<EQUAL? ,PRSO ,WATER ,GLOBAL-WATER>
		<PERFORM ,V?SWIM ,PRSO>
		<RTRUE>)
	       (T
		<TELL
"You have a theory on how to board a " D ,PRSO ", perhaps?" CR>)>
	 <RFATAL>>

<ROUTINE V-BOARD ("AUX" AV)
	 <TELL "You are now in the " D ,PRSO "." CR>
	 <MOVE ,WINNER ,PRSO>
	 <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>
	 <RTRUE>>

<ROUTINE V-BREATHE ()
	 <PERFORM ,V?INFLATE ,PRSO ,LUNGS>>

<ROUTINE V-BRUSH ()
	 <TELL "If you wish, but heaven only knows why." CR>>

<ROUTINE V-BUG ()
	 <TELL
"Bug? Not in a flawless program like this! (Cough, cough)." CR>>

<ROUTINE TELL-NO-PRSI ()
	 <TELL "You didn't say with what!" CR>>

<ROUTINE PRE-BURN ()
	 <COND (<NOT ,PRSI>
		<TELL-NO-PRSI>)
	       (<FLAMING? ,PRSI>
	        <RFALSE>)
	       (T
	        <TELL "With a " D ,PRSI "??!?" CR>)>>

<ROUTINE V-BURN ()
	 <COND %<COND (<==? ,ZORK-NUMBER 2>
		       '(<EQUAL? <LOC ,PRSO> ,RECEPTACLE>
		         <BALLOON-BURN>
		         <RTRUE>))
		      (T
		       '(<NULL-F> <RFALSE>))>
	       (<FSET? ,PRSO ,BURNBIT>
		<COND (<OR <IN? ,PRSO ,WINNER>
			   <IN? ,WINNER ,PRSO>>
		       <REMOVE-CAREFULLY ,PRSO>
		       <TELL "The " D ,PRSO>
		       <TELL
" catches fire. Unfortunately, you were ">
		       <COND (<IN? ,WINNER ,PRSO>
			      <TELL "in">)
			     (T <TELL "holding">)>
		       <JIGS-UP " it at the time.">)
		      (T
		       <REMOVE-CAREFULLY ,PRSO>
		       <TELL
"The " D ,PRSO " catches fire and is consumed." CR>)>)
	       (T
		<TELL "You can't burn a " D ,PRSO "." CR>)>>

<ROUTINE V-CHOMP ()
	 <TELL "Preposterous!" CR>>

<ROUTINE V-CLIMB-DOWN () <V-CLIMB-UP ,P?DOWN ,PRSO>>

<ROUTINE V-CLIMB-FOO ()
	 %<COND (<==? ,ZORK-NUMBER 3>
		 '<V-CLIMB-UP <COND (<EQUAL? ,PRSO ,ROPE ,GLOBAL-ROPE>
				     ,P?DOWN)
				    (T ,P?UP)>
			      T>)
		(ELSE
		 '<V-CLIMB-UP ,P?UP ,PRSO>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		%<COND (<==? ,ZORK-NUMBER 3>
			'<V-CLIMB-UP ,P?UP T>)
		       (ELSE
			'<PERFORM ,V?BOARD ,PRSO>)>
		<RTRUE>)
	       (T
		<TELL "You can't climb onto the " D ,PRSO "." CR>)>>

<ROUTINE V-CLIMB-UP ("OPTIONAL" (DIR ,P?UP) (OBJ <>) "AUX" X TX)
	 <COND (<AND .OBJ <NOT <EQUAL? ,PRSO ,ROOMS>>>
		<SET OBJ ,PRSO>)>
	 <COND (<SET TX <GETPT ,HERE .DIR>>
		<COND (.OBJ
		       <SET X <PTSIZE .TX>>
		       <COND (<OR <EQUAL? .X ,NEXIT>
				  <AND <EQUAL? .X ,CEXIT ,DEXIT ,UEXIT>
				       <NOT <GLOBAL-IN? ,PRSO <GETB .TX 0>>>>>
			      <TELL "The " D .OBJ " do">
			      <COND (<NOT <EQUAL? .OBJ ,STAIRS>>
				     <TELL "es">)>
			      <TELL "n't lead ">
			      <COND (<==? .DIR ,P?UP>
				     <TELL "up">)
				    (T <TELL "down">)>
			      <TELL "ward." CR>
			      <RTRUE>)>)>
		<DO-WALK .DIR>
		<RTRUE>)
	       (<AND .OBJ
		     <ZMEMQ ,W?WALL
			    <SET X <GETPT ,PRSO ,P?SYNONYM>> <PTSIZE .X>>>
		<TELL "Climbing the walls is to no avail." CR>)
	       (%<COND (<==? ,ZORK-NUMBER 1>
			'<AND <NOT <EQUAL? ,HERE ,PATH>>
			      <EQUAL? .OBJ <> ,TREE>
			      <GLOBAL-IN? ,TREE ,HERE>>)
		       (ELSE '<NULL-F>)>
		<TELL "There are no climbable trees here." CR>
		<RTRUE>)
	       (<EQUAL? .OBJ <> ,ROOMS>
		<TELL "You can't go that way." CR>)
	       (T
	        <TELL "You can't do that!" CR>)>>

<ROUTINE V-CLOSE ()
	 <COND (<AND <NOT <FSET? ,PRSO ,CONTBIT>>
		     <NOT <FSET? ,PRSO ,DOORBIT>>>
		<TELL "You must tell me how to do that to a " D ,PRSO "." CR>)
	       (<AND <NOT <FSET? ,PRSO ,SURFACEBIT>>
		     <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Closed." CR>
		       <COND (<AND ,LIT <NOT <SETG LIT <LIT? ,HERE>>>>
			      <TELL "It is now pitch black." CR>)>
		       <RTRUE>)
		      (T
	 	       <TELL "It is already closed." CR>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "The " D ,PRSO " is now closed." CR>)
		      (T
	 	       <TELL "It is already closed." CR>)>)
	       (T
		<TELL "You cannot close that." CR>)>>

<ROUTINE V-COMMAND ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "The " D ,PRSO " pays no attention." CR>)
	       (T
		<TELL "You cannot talk to that!" CR>)>>

<ROUTINE V-COUNT ()
	 <COND (<EQUAL? ,PRSO ,BLESSINGS>
	 	<TELL "Well, for one, you are playing Zork..." CR>)
	       (T
		<TELL "You have lost your mind." CR>)>>

<ROUTINE V-CROSS ()
	 <TELL "You can't cross that!" CR>>

<ROUTINE V-CURSES ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "Insults of this nature won't help you." CR>)
		      (T
		       <TELL "What a loony!" CR>)>)
	       (T
		<TELL
"Such language in a high-class establishment like this!" CR>)>>

<ROUTINE V-CUT ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?ATTACK ,PRSO ,PRSI>)
	       (<AND <FSET? ,PRSO ,BURNBIT>
		     <FSET? ,PRSI ,WEAPONBIT>>
		<COND (<IN? ,WINNER ,PRSO>
		       <TELL
"Not a bright idea, especially since you're in it." CR>
		       <RTRUE>)>
		<REMOVE-CAREFULLY ,PRSO>
		<TELL "Your skillful " D ,PRSI "smanship slices the " D ,PRSO
" into innumerable slivers which blow away." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL
"The \"cutting edge\" of a " D ,PRSI " is hardly adequate." CR>)
	       (T
		<TELL "Strange concept, cutting the " D ,PRSO "...." CR>)>>

<ROUTINE V-DEFLATE ()
	 <TELL "Come on, now!" CR>>

<ROUTINE V-DIG ()
	 <COND (<NOT ,PRSI>
		<SETG PRSI ,HANDS>)>
	 %<COND (<==? ,ZORK-NUMBER 1>
		 '<COND (<EQUAL? ,PRSI ,SHOVEL>
			 <TELL "There's no reason to be digging here." CR>
			 <RTRUE>)>)
		(ELSE T)>
	 <COND (<FSET? ,PRSI ,TOOLBIT>
		<TELL "Digging with the " D ,PRSI " is slow and tedious." CR>)
	       (T
		<TELL "Digging with a " D ,PRSI " is silly." CR>)>>

<ROUTINE V-DISEMBARK ()
	 <COND (<AND <EQUAL? ,PRSO ,ROOMS>
		     <FSET? <LOC ,WINNER> ,VEHBIT>>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (<NOT <EQUAL? <LOC ,WINNER> ,PRSO>>
		<TELL "You're not in that!" CR>
		<RFATAL>)
	       (<FSET? ,HERE ,RLANDBIT>
		<TELL "You are on your own feet again." CR>
		<MOVE ,WINNER ,HERE>)
	       (T
		<TELL
"You realize that getting out here would be fatal." CR>
		<RFATAL>)>>

<ROUTINE V-DISENCHANT ()
	 %<COND (<==? ,ZORK-NUMBER 2>
		 '<COND (<NOT <IN? ,PRSO ,HERE>>
		         <RTRUE>)
	                (<OR <EQUAL? ,SPELL-USED ,W?FEEBLE ,W?FUMBLE ,W?FEAR>
		          <EQUAL? ,SPELL-USED ,W?FREEZE ,W?FALL ,W?FERMENT>
		          <EQUAL? ,SPELL-USED ,W?FIERCE ,W?FENCE ,W?FANTASIZE>>
		          <COND (<FSET? ,PRSO ,ACTORBIT>
		                 <COND (<EQUAL? ,SPELL-USED ,W?FEEBLE>
			                <TELL
"The " D ,PRSO " seems stronger now." CR>)
			               (<EQUAL? ,SPELL-USED ,W?FUMBLE>
			                <TELL
"The " D ,PRSO " no longer appears clumsy." CR>)
			               (<EQUAL? ,SPELL-USED ,W?FEAR>
			                <TELL
"The " D ,PRSO " no longer appears afraid." CR>)
			               (<EQUAL? ,SPELL-USED ,W?FREEZE>
			                <TELL
"The " D ,PRSO " moves again." CR>)
			               (<EQUAL? ,SPELL-USED ,W?FERMENT>
			                <TELL
"The " D ,PRSO " stops swaying." CR>)
			               (<EQUAL? ,SPELL-USED ,W?FIERCE>
			                <TELL
"The " D ,PRSO " appears more peaceful." CR>)>)>)
	                        (<EQUAL? ,SPELL-USED ,W?FLOAT>
		                 <TELL
"The " D ,PRSO " sinks to the ground." CR>)
	                        (<EQUAL? ,SPELL-USED ,W?FUDGE>
		                 <TELL "The sweet smell has dispersed." CR>)>)
		(T
		 '<TELL "Nothing happens." CR>)>>

<ROUTINE V-DRINK ()
	 <V-EAT>>

<ROUTINE V-DRINK-FROM ()
	 <TELL "How peculiar!" CR>>

<ROUTINE PRE-DROP ()
	 <COND (<EQUAL? ,PRSO <LOC ,WINNER>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)>>

<ROUTINE V-DROP ()
	 <COND (<IDROP>
		<TELL "Dropped." CR>)>>

<ROUTINE V-EAT ("AUX" (EAT? <>) (DRINK? <>) (NOBJ <>))
	 <COND (<SET EAT? <FSET? ,PRSO ,FOODBIT>>
		<COND (<AND <NOT <IN? ,PRSO ,WINNER>>
			    <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		       <TELL "You're not holding that." CR>)
		      (<VERB? DRINK>
		       <TELL "How can you drink that?">)
		      (T
		       <TELL "Thank you very much. It really hit the spot.">
		       <REMOVE-CAREFULLY ,PRSO>)>
		<CRLF>)
	       (<FSET? ,PRSO ,DRINKBIT>
		<SET DRINK? T>
		<SET NOBJ <LOC ,PRSO>>
		<COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
			   <GLOBAL-IN? ,GLOBAL-WATER ,HERE>
			   <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		       <HIT-SPOT>)
		      (<OR <NOT .NOBJ>
			   <NOT <ACCESSIBLE? .NOBJ>>>
		       <TELL
"There isn't any water here." CR>)
		      (<AND <ACCESSIBLE? .NOBJ>
			    <NOT <IN? .NOBJ ,WINNER>>>
		       <TELL
"You have to be holding the " D .NOBJ " first." CR>)
		      (<NOT <FSET? .NOBJ ,OPENBIT>>
		       <TELL
"You'll have to open the " D .NOBJ " first." CR>)
		      (T
		       <HIT-SPOT>)>)
	       (<NOT <OR .EAT? .DRINK?>>
		<TELL
"I don't think that the " D ,PRSO " would agree with you." CR>)>>

<ROUTINE HIT-SPOT ()
	 <COND (<AND <EQUAL? ,PRSO ,WATER>
		     <NOT <GLOBAL-IN? ,GLOBAL-WATER ,HERE>>>
		<REMOVE-CAREFULLY ,PRSO>)>
	 <TELL
"Thank you very much. I was rather thirsty (from all this talking,
probably)." CR>>

<ROUTINE V-ECHO ("AUX" LST MAX (ECH 0) CNT) 
	 #DECL ((LST) <PRIMTYPE VECTOR> (MAX CNT ECH) FIX)
	 %<COND (<==? ,ZORK-NUMBER 1>
		 '<COND (<G? <GETB ,P-LEXV ,P-LEXWORDS> 0>
	                 <SET LST <REST 
				   ,P-LEXV
				   <* <GETB ,P-LEXV ,P-LEXWORDS> ,P-WORDLEN>>>
	                 <SET MAX <- <+ <GETB .LST 0> <GETB .LST 1>> 1>>
	                 <REPEAT ()
		            <COND (<G? <SET ECH <+ .ECH 1>> 2>
			           <TELL "..." CR>
				   <RETURN>)
			          (T
			           <SET CNT <- <GETB .LST 1> 1>>
			           <REPEAT ()
				      <COND (<G? <SET CNT <+ .CNT 1>> .MAX>
					     <RETURN>)
					    (T
					     <PRINTC <GETB ,P-INBUF .CNT>>)>>
			           <TELL " ">)>>)
			(T <TELL "echo echo ..." CR>)>)
		(T
		 '<TELL "echo echo ..." CR>)>>

<ROUTINE V-ENCHANT ()
%<COND (<==? ,ZORK-NUMBER 2>
	'<COND (,WAND-ON <SETG SPELL-VICTIM ,WAND-ON>)>)
       (T
	'<NULL-F>)>
%<COND (<==? ,ZORK-NUMBER 2>
	'<COND (,SPELL-VICTIM
		<COND (<NOT ,SPELL-USED>
		       <TELL "You must be more specific." CR>
		       <RTRUE>)>
		<COND (<OR <EQUAL? ,SPELL-USED ,W?FEEBLE ,W?FUMBLE ,W?FEAR>
			   <EQUAL? ,SPELL-USED ,W?FREEZE ,W?FALL ,W?FERMENT>
			   <EQUAL? ,SPELL-USED ,W?FIERCE ,W?FENCE ,W?FANTASIZE>>
		       <COND (<FSET? ,PRSO ,ACTORBIT>
			      <TELL
"The wand stops glowing, but there is no other obvious effect." CR>)
			     (T
			      <TELL
"That might have done something, but it's hard to tell with a " D ,PRSO "." CR>)>)
		      ;(<EQUAL? ,SPELL-USED ,W?FIREPROOF>
		       <RTRUE>)
		      (<EQUAL? ,SPELL-USED ,W?FUDGE>
		       <TELL
"A strong odor of chocolate permeates the room." CR>)
		      (<EQUAL? ,SPELL-USED ,W?FLUORESCE>
		       <FSET ,PRSO ,LIGHTBIT>
		       <FSET ,PRSO ,ONBIT>
		       <SETG LIT T>
		       <TELL
"The " D ,PRSO " begins to glow." CR>)
		      (<EQUAL? ,SPELL-USED ,W?FILCH>
		       <SETG SPELL-HANDLED? T>
		       <COND (<FSET? ,PRSO ,TAKEBIT>
			      <MOVE ,PRSO ,WINNER>
			      <SCORE-OBJ ,PRSO>
			      <TELL "Filched!" CR>)
			     (ELSE
			      <TELL "You can't filch the " D ,PRSO "!" CR>)>)
		      (<AND <EQUAL? ,SPELL-USED ,W?FLOAT>
			    <FSET? ,PRSO ,TAKEBIT>>
		       <COND (<AND <EQUAL? ,SPELL-VICTIM ,COLLAR>
				   <IN? ,COLLAR ,CERBERUS>>
			      <SETG SPELL-VICTIM ,CERBERUS>)>
		       <TELL
"The " D ,PRSO " floats serenely in midair." CR>)
		      (<AND <EQUAL? ,SPELL-USED ,W?FRY>
			    <FSET? ,PRSO ,TAKEBIT>>
		       <SETG SPELL-HANDLED? T>
		       <REMOVE-CAREFULLY ,PRSO>
		       <TELL "The " D ,PRSO " goes up in a puff of smoke." CR>)
		      (ELSE
		       <SETG SPELL-VICTIM <>>
		       <TELL
"The wand stops glowing, but there is no other apparent effect." CR>)>)
	       (ELSE
		<SETG SPELL-VICTIM <>>
		<TELL "Nothing happens." CR>)>)
       (T
	'<V-DISENCHANT>)>>

<ROUTINE REMOVE-CAREFULLY (OBJ "AUX" OLIT)
	 <COND (<EQUAL? .OBJ ,P-IT-OBJECT>
		<SETG P-IT-OBJECT <>>)>
	 <SET OLIT ,LIT>
	 <REMOVE .OBJ>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND .OLIT <NOT <EQUAL? .OLIT ,LIT>>>
		<TELL "You are left in the dark..." CR>)>
	 T>

<ROUTINE V-ENTER ()
	<DO-WALK ,P?IN>>

<ROUTINE V-EXAMINE ()
	 <COND (<GETP ,PRSO ,P?TEXT>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
	       (<OR <FSET? ,PRSO ,CONTBIT>
		    <FSET? ,PRSO ,DOORBIT>>
		<V-LOOK-INSIDE>)
	       (T
		<TELL "There's nothing special about the " D ,PRSO "." CR>)>>

<ROUTINE V-EXIT ()
	 <COND (<AND <EQUAL? ,PRSO <> ,ROOMS>
		     <FSET? <LOC ,WINNER> ,VEHBIT>>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (<AND ,PRSO <IN? ,WINNER ,PRSO>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (ELSE
		<DO-WALK ,P?OUT>)>>

<ROUTINE V-EXORCISE ()
	 <TELL "What a bizarre concept!" CR>>

<ROUTINE PRE-FILL ("AUX" TX)
	 <COND (<NOT ,PRSI>
		<SET TX <GETPT ,HERE ,P?GLOBAL>>
		<COND (<AND .TX <ZMEMQB ,GLOBAL-WATER .TX <- <PTSIZE .TX> 1>>>
		       <PERFORM ,V?FILL ,PRSO ,GLOBAL-WATER>
		       <RTRUE>)
		      (<IN? ,WATER <LOC ,WINNER>>
		       <PERFORM ,V?FILL ,PRSO ,WATER>
		       <RTRUE>)
		      (T
		       <TELL "There is nothing to fill it with." CR>
		       <RTRUE>)>)>
	 <COND (<EQUAL? ,PRSI ,WATER>
		<RFALSE>)
	       (<NOT <EQUAL? ,PRSI ,GLOBAL-WATER>>
		<PERFORM ,V?PUT ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-FILL ()
	 <COND (<NOT ,PRSI>
		<COND (<GLOBAL-IN? ,GLOBAL-WATER ,HERE>
		       <PERFORM ,V?FILL ,PRSO ,GLOBAL-WATER>
		       <RTRUE>)
		      (<IN? ,WATER <LOC ,WINNER>>
		       <PERFORM ,V?FILL ,PRSO ,WATER>
		       <RTRUE>)
		      (T
		       <TELL "There's nothing to fill it with." CR>)>)
	       (T
		<TELL "You may know how to do that, but I don't." CR>)>>

<ROUTINE V-FIND ("AUX" (L <LOC ,PRSO>))
	 <COND (<EQUAL? ,PRSO ,HANDS ,LUNGS>
		<TELL
"Within six feet of your head, assuming you haven't left that
somewhere." CR>)
	       (<EQUAL? ,PRSO ,ME>
		<TELL "You're around here somewhere..." CR>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<TELL "You find it." CR>)
	       (<IN? ,PRSO ,WINNER>
		<TELL "You have it." CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>
		    <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		<TELL "It's right here." CR>)
	       (<FSET? .L ,ACTORBIT>
		<TELL "The " D .L " has it." CR>)
	       (<FSET? .L ,SURFACEBIT>
		<TELL "It's on the " D .L "." CR>)
	       (<FSET? .L ,CONTBIT>
		<TELL "It's in the " D .L "." CR>)
	       (T
		<TELL "Beats me." CR>)>>

<ROUTINE V-FOLLOW ()
	 <TELL "You're nuts!" CR>>

<ROUTINE V-FROBOZZ ()
	 <TELL
"The FROBOZZ Corporation created, owns, and operates this dungeon." CR>>

<ROUTINE PRE-GIVE ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL 
"That's easy for you to say since you don't even have the " D ,PRSO "." CR>)>>

<ROUTINE V-GIVE ()
	 <COND (<NOT <FSET? ,PRSI ,ACTORBIT>>
		<TELL "You can't give a " D ,PRSO " to a " D ,PRSI "!" CR>)
	       (T
		<TELL "The " D ,PRSI " refuses it politely." CR>)>>

<ROUTINE V-HATCH ()
	 <TELL "Bizarre!" CR>>

<GLOBAL HS 0> ;"counts occurences of HELLO, SAILOR"

<ROUTINE V-HELLO ()
	 <COND (,PRSO
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL
"The " D ,PRSO " bows his head to you in greeting." CR>)
		      (T
		       <TELL
"It's a well known fact that only schizophrenics say \"Hello\" to a "
D ,PRSO "." CR>)>)
	       (T
		<TELL <PICK-ONE ,HELLOS> CR>)>>

<ROUTINE V-INCANT ()
%<COND (<==? ,ZORK-NUMBER 2>
	'<COND (,SPELL-USED
		<TELL "Nothing happens." CR>)
	       (,WAND-ON
		<SETG SPELL-VICTIM ,WAND-ON>
		<SETG SPELL-USED <GET ,P-LEXV ,P-CONT>>
		<TELL "The wand glows very brightly for a moment." CR>
		<ENABLE <QUEUE I-SPELL <+ 10 <RANDOM 10>>>>
		<SETG WAND-ON <>>
		<PERFORM ,V?ENCHANT ,SPELL-VICTIM>)
	       (T
		<TELL
"The incantation echoes back faintly, but nothing else happens." CR>)>)
       (T
	'<TELL
"The incantation echoes back faintly, but nothing else happens." CR>)>
	 <SETG QUOTE-FLAG <>>
	 <SETG P-CONT <>>
	 <RTRUE>>

<ROUTINE V-INFLATE ()
	 <TELL "How can you inflate that?" CR>>

<ROUTINE V-KICK () <HACK-HACK "Kicking the ">>

<ROUTINE V-KISS ()
	 <TELL "I'd sooner kiss a pig." CR>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "Nobody's home." CR>)
	       (T
		<TELL "Why knock on a " D ,PRSO "?" CR>)>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<NOT <FSET? ,PRSO ,ONBIT>>
		       <TELL "It is already off." CR>)
		      (T
		       <FCLEAR ,PRSO ,ONBIT>
		       <COND (,LIT
			      <SETG LIT <LIT? ,HERE>>)>
		       <TELL "The " D ,PRSO " is now off." CR>
		       <COND (<NOT ,LIT>
			      <TELL "It is now pitch black." CR>)>)>)
	       (T
		<TELL "You can't turn that off." CR>)>
	 <RTRUE>>

<ROUTINE V-LAMP-ON ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL "It is already on." CR>)
		      (T
		       <FSET ,PRSO ,ONBIT>
		       <TELL "The " D ,PRSO " is now on." CR>
		       <COND (<NOT ,LIT>
			      <SETG LIT <LIT? ,HERE>>
			      <CRLF>
			      <V-LOOK>)>)>)
	       (<FSET? ,PRSO ,BURNBIT>
		<TELL
"If you wish to burn the " D ,PRSO ", you should say so." CR>)
	       (T
		<TELL "You can't turn that on." CR>)>
	 <RTRUE>>

<ROUTINE V-LAUNCH ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<TELL "You can't launch that by saying \"launch\"!" CR>)
	       (T
		<TELL "That's pretty weird." CR>)>>

<ROUTINE V-LEAN-ON ()
	 <TELL "Getting tired?" CR>>

<ROUTINE V-LEAP ("AUX" TX S)
	 <COND (,PRSO
		<COND (<IN? ,PRSO ,HERE>
		       <COND (<FSET? ,PRSO ,ACTORBIT>
			      <TELL
"The " D ,PRSO " is too big to jump over." CR>)
			     (T
			      <V-SKIP>)>)
		      (T
		       <TELL "That would be a good trick." CR>)>)
	       (<SET TX <GETPT ,HERE ,P?DOWN>>
		<SET S <PTSIZE .TX>>
		<COND (<OR <EQUAL? .S 2> ;NEXIT
       			   <AND <EQUAL? .S 4> ;CEXIT
				<NOT <VALUE <GETB .TX 1>>>>>
		       <TELL
"This was not a very safe place to try jumping." CR>
		       <JIGS-UP <PICK-ONE ,JUMPLOSS>>)
		      %<COND (<==? ,ZORK-NUMBER 1>
			      '(<EQUAL? ,HERE ,UP-A-TREE>
		                <TELL
"In a feat of unaccustomed daring, you manage to land on your feet without
killing yourself." CR CR>
		                <DO-WALK ,P?DOWN>
		                <RTRUE>))
			     (T '(<NULL-F> T))>
		      (T
		       <V-SKIP>)>)
	       (T
		<V-SKIP>)>>

<GLOBAL JUMPLOSS
	<LTABLE 0
	       "You should have looked before you leaped."
	       "In the movies, your life would be passing before your eyes."
	       "Geronimo...">>

<ROUTINE V-LEAVE () <DO-WALK ,P?OUT>>

<ROUTINE V-LISTEN ()
	 <TELL "The " D ,PRSO " makes no sound." CR>>

<ROUTINE V-LOCK ()
	 <TELL "It doesn't seem to work." CR>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS T>)>>

<ROUTINE V-LOOK-BEHIND ()
	 <TELL "There is nothing behind the " D ,PRSO "." CR>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL
"The " D ,PRSO " is open, but I can't tell what's beyond it.">)
		      (T
		       <TELL "The " D ,PRSO " is closed.">)>
		<CRLF>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "There is nothing special to be seen." CR>)
		      (<SEE-INSIDE? ,PRSO>
		       <COND (<AND <FIRST? ,PRSO>
				   <PRINT-CONT ,PRSO>>
			      <RTRUE>)
			     %<COND (<==? ,ZORK-NUMBER 3>
				     '(<FSET? ,PRSO ,SURFACEBIT>
				       <TELL
"There is nothing on the " D ,PRSO "." CR>))
				    (ELSE '(<NULL-F> <RTRUE>))>
			     (T
			      <TELL "The " D ,PRSO " is empty." CR>)>)
		      (T
		       <TELL "The " D ,PRSO " is closed." CR>)>)
	       (T
		<TELL "You can't look inside a " D ,PRSO "." CR>)>>

<ROUTINE V-LOOK-ON ()
	 <COND (<FSET? ,PRSO ,SURFACEBIT>
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)
	       (T
		<TELL "Look on a " D ,PRSO "???" CR>)>>

<ROUTINE V-LOOK-UNDER ()
	 <TELL "There is nothing but dust there." CR>>

<ROUTINE V-LOWER () <HACK-HACK "Playing in this way with the ">>

<ROUTINE V-MAKE ()
    	<TELL "You can't do that." CR>>

<ROUTINE V-MELT ()
	 <TELL "It's not clear that a " D ,PRSO " can be melted." CR>>

<ROUTINE PRE-MOVE ()
	 <COND (<HELD? ,PRSO>
		<TELL "You aren't an accomplished enough juggler." CR>)>>

<ROUTINE V-MOVE ()
	 <COND (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving the " D ,PRSO " reveals nothing." CR>)
	       (T
		<TELL "You can't move the " D ,PRSO "." CR>)>>

<ROUTINE V-MUMBLE ()
	 <TELL "You'll have to speak up if you expect me to hear you!" CR>>

<ROUTINE PRE-MUNG ()
	 <COND %<COND (<==? ,ZORK-NUMBER 3>
		       '(<EQUAL? ,PRSO ,BEAM>
		         <RFALSE>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (<OR <NOT ,PRSI>
		    <NOT <FSET? ,PRSI ,WEAPONBIT>>>
		<TELL "Trying to destroy the " D ,PRSO " with ">
		<COND (<NOT ,PRSI>
		       <TELL "your bare hands">)
		      (T
		       <TELL "a " D ,PRSI>)>
		<TELL " is futile." CR>)>>

<ROUTINE V-MUNG ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?ATTACK ,PRSO ,PRSI>
		<RTRUE>)
	       (T
		<TELL "Nice try." CR>)>>

<ROUTINE V-ODYSSEUS ()
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<AND <EQUAL? ,HERE ,CYCLOPS-ROOM>
			      <IN? ,CYCLOPS ,HERE>
			      <NOT ,CYCLOPS-FLAG>>
		         <DISABLE <INT I-CYCLOPS>>
		         <SETG CYCLOPS-FLAG T>
		         <TELL 
"The cyclops, hearing the name of his father's deadly nemesis, flees the room
by knocking down the wall on the east of the room." CR>
		        <SETG MAGIC-FLAG T>
		        <FCLEAR ,CYCLOPS ,FIGHTBIT>
		        <REMOVE-CAREFULLY ,CYCLOPS>))
		      (T
		       '(<NULL-F> T))>
	       (T
		<TELL "Wasn't he a sailor?" CR>)>>

<ROUTINE V-OIL ()
	 <TELL "You probably put spinach in your gas tank, too." CR>>

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<AND <FSET? ,PRSO ,CONTBIT>
		     <NOT <EQUAL? <GETP ,PRSO ,P?CAPACITY> 0>>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "It is already open." CR>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <FSET ,PRSO ,TOUCHBIT>
		       <COND (<OR <NOT <FIRST? ,PRSO>> <FSET? ,PRSO ,TRANSBIT>>
			      <TELL "Opened." CR>)
			     (<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <NOT <FSET? .F ,TOUCHBIT>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <TELL "The " D ,PRSO " opens." CR>
			      <TELL .STR CR>)
			     (T
			      <TELL "Opening the " D ,PRSO " reveals ">
			      <PRINT-CONTENTS ,PRSO>
			      <TELL "." CR>)>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "It is already open." CR>)
		      (T
		       <TELL "The " D ,PRSO " opens." CR>
		       <FSET ,PRSO ,OPENBIT>)>)
	       (T
		<TELL
"You must tell me how to do that to a " D ,PRSO "." CR>)>>

<ROUTINE V-OVERBOARD ("AUX" LOCN)
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,PRSI ,TEETH>
			 <COND (<FSET? <SET LOCN <LOC ,WINNER>> ,VEHBIT>
				<MOVE ,PRSO <LOC .LOCN>>
				<TELL "Ahoy -- " D ,PRSO " overboard!" CR>)
			       (T
				<TELL "You're not in anything!" CR>)>))
		      (T '(<NULL-F> T))>
	       (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?THROW ,PRSO>
		<RTRUE>)
	       (T
		<TELL "Huh?" CR>)>>

<ROUTINE V-PICK () <TELL "You can't pick that." CR>>

<ROUTINE V-PLAY ()
    <COND (<FSET? ,PRSO ,ACTORBIT>
	   <TELL
"You become so engrossed in the role of the " D ,PRSO " that
you kill yourself, just as he might have done!" CR>
	   <JIGS-UP "">)
	  (ELSE <TELL "That's silly!" CR>)>>

<ROUTINE V-PLUG ()
	 <TELL "This has no effect." CR>>

<ROUTINE V-POUR-ON ()
	 <COND (<EQUAL? ,PRSO ,WATER>
		<REMOVE-CAREFULLY ,PRSO>
	        <COND (<FLAMING? ,PRSI>
		       <TELL "The " D ,PRSI " is extinguished." CR>
		       %<COND (<==? ,ZORK-NUMBER 2>
			       '<COND (<EQUAL? ,PRSI ,BINF-FLAG>
				       <SETG BINF-FLAG <>>)>)
			      (ELSE '<NULL-F>)>
		       <FCLEAR ,PRSI ,ONBIT>
		       <FCLEAR ,PRSI ,FLAMEBIT>)
	              (T
		       <TELL
"The water spills over the " D ,PRSI ", to the floor, and evaporates." CR>)>)
	       %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,PRSO ,PUTTY>
			 <PERFORM ,V?PUT ,PUTTY ,PRSI>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (T
		<TELL "You can't pour that." CR>)>>

<ROUTINE V-PRAY ()
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,HERE ,SOUTH-TEMPLE>
		         <GOTO ,FOREST-1>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (T
		<TELL
"If you pray enough, your prayers may be answered." CR>)>>

<ROUTINE V-PUMP ()
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<AND ,PRSI <NOT <EQUAL? ,PRSI ,PUMP>>>
		         <TELL "Pump it up with a " D ,PRSI "?" CR>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       %<COND (<==? ,ZORK-NUMBER 1>
		       '(<IN? ,PUMP ,WINNER>
		         <PERFORM ,V?INFLATE ,PRSO ,PUMP>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (T
		<TELL "It's really not clear how." CR>)>>

<ROUTINE V-PUSH () <HACK-HACK "Pushing the ">>

<ROUTINE V-PUSH-TO ()
	 <TELL "You can't push things to that." CR>>

<ROUTINE PRE-PUT ()
	 <COND %<COND (<==? ,ZORK-NUMBER 3>
		       '(<EQUAL? ,PRSO ,SHORT-POLE>
		         <RFALSE>))
		      (T
		       '(<NULL-F>
			 <RFALSE>))>
	       (T
		<PRE-GIVE>)>> ;"That's easy for you to say..."

<ROUTINE V-PUT ()
	 <COND (<OR <FSET? ,PRSI ,OPENBIT>
		    <OPENABLE? ,PRSI>
		    <FSET? ,PRSI ,VEHBIT>>)
	       (T
		<TELL "You can't do that." CR>
		<RTRUE>)>
	 <COND (<NOT <FSET? ,PRSI ,OPENBIT>>
		<TELL "The " D ,PRSI " isn't open." CR>
		<THIS-IS-IT ,PRSI>)
	       (<EQUAL? ,PRSI ,PRSO>
		<TELL "How can you do that?" CR>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "The " D ,PRSO " is already in the " D ,PRSI "." CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "There's no room." CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <FSET? ,PRSO ,TRYTAKEBIT>>
		<TELL "You don't have the " D ,PRSO "." CR>
		<RTRUE>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <NOT <ITAKE>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<SCORE-OBJ ,PRSO>
		<TELL "Done." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL "That hiding place is too obvious." CR>>

<ROUTINE V-PUT-ON ()
	 <COND (<EQUAL? ,PRSI ,GROUND>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (T
		<TELL "There's no good surface on the " D ,PRSI "." CR>)>>

<ROUTINE V-PUT-UNDER ()
	 <TELL "You can't do that." CR>>

<ROUTINE V-RAISE ()
	 <V-LOWER>>

<ROUTINE V-RAPE ()
	 <TELL "What a (ahem!) strange idea." CR>>

<ROUTINE PRE-READ ()
	 <COND (<NOT ,LIT>
		<TELL "It is impossible to read in the dark." CR>)
	       (<AND ,PRSI <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<TELL "How does one look through a " D ,PRSI "?" CR>)>>

<ROUTINE V-READ ()
	 <COND (<NOT <FSET? ,PRSO ,READBIT>>
		<TELL "How does one read a " D ,PRSO "?" CR>)
	       (T
		<TELL <GETP ,PRSO ,P?TEXT> CR>)>>

<ROUTINE V-READ-PAGE ()
	 <PERFORM ,V?READ ,PRSO>
	 <RTRUE>>

<ROUTINE V-REPENT ()
	 <TELL "It could very well be too late!" CR>>

<ROUTINE V-REPLY ()
	 <TELL "It is hardly likely that the " D ,PRSO " is interested." CR>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE V-RING ()
	 <TELL "How, exactly, can you ring that?" CR>>

<ROUTINE V-RUB () <HACK-HACK "Fiddling with the ">>

<ROUTINE V-SAY ("AUX" V)
	 %<COND (<==? ,ZORK-NUMBER 2>
		 '<COND (<OR ,SPELL-USED ,WAND-ON>
		         <PERFORM ,V?INCANT>
		         <RTRUE>)>)
		(<==? ,ZORK-NUMBER 3>
		 '<COND (<AND <FSET? ,FRONT-DOOR ,TOUCHBIT>
		              <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?FROTZ>
		              <EQUAL? <GET ,P-LEXV <+ ,P-CONT 2>> ,W?OZMOO>>
		         <SETG P-CONT <>>
		         <COND (<EQUAL? ,HERE ,MSTAIRS>
		                <CRLF>
		                <GOTO ,FRONT-DOOR>)
		               (T
		                <TELL "Nothing happens." CR>)>
		                <RTRUE>)>)
		(T
		 '<COND (<NOT ,P-CONT>
			 <TELL "Say what?" CR>
			 <RTRUE>)>)>
	 <SETG QUOTE-FLAG <>>
	 <COND (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<TELL "You must address the " D .V " directly." CR>
		<SETG P-CONT <>>)
	       (<NOT <EQUAL? <GET ,P-LEXV ,P-CONT> ,W?HELLO>>
	        <SETG P-CONT <>>
		<TELL
"Talking to yourself is a sign of impending mental collapse." CR>)>
	 <RTRUE>>

<ROUTINE V-SEARCH ()
	 <TELL "You find nothing unusual." CR>>

<ROUTINE V-SEND ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Why would you send for the " D ,PRSO "?" CR>)
	       (T
		<TELL "That doesn't make sends." CR>)>>

<ROUTINE PRE-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SGIVE ()
	 <TELL "Foo!" CR>>

<ROUTINE V-SHAKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "This seems to have no effect." CR>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL "You can't take it; thus, you can't shake it!" CR>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <COND (<FIRST? ,PRSO>
			      <SHAKE-LOOP>
			      <TELL "The contents of the " D, PRSO " spill ">
	                      <COND (%<COND (<==? ,ZORK-NUMBER 3>
					     '<FSET? ,HERE ,NONLANDBIT>)
					    (ELSE
					     '<NOT <FSET? ,HERE ,RLANDBIT>>)>
		                     <TELL "out and disappear">)
	                            (T
		                     <TELL "to the ground">)>
	                      <TELL "." CR>)
			     (T
			      <TELL "Shaken." CR>)>)
		      (T
		       <COND (<FIRST? ,PRSO>
			      <TELL
"It sounds like there is something inside the " D ,PRSO "." CR>)
			     (T
			      <TELL "The " D, PRSO " sounds empty." CR>)>)>)
	       (T
		<TELL "Shaken." CR>)>>

<ROUTINE SHAKE-LOOP ("AUX" X)
	 <REPEAT ()
		 <COND (<SET X <FIRST? ,PRSO>>
			<FSET .X ,TOUCHBIT>
			<MOVE .X
			      %<COND (<==? ,ZORK-NUMBER 1>
				      '<COND (<EQUAL? ,HERE ,UP-A-TREE>
				              ,PATH)
				             (<NOT <FSET? ,HERE ,RLANDBIT>>
				              ,PSEUDO-OBJECT)
				             (T
				              ,HERE)>)
				     (<==? ,ZORK-NUMBER 2>
				      '<COND (<EQUAL? .X ,WATER>
				              ,PSEUDO-OBJECT)
				             (<NOT <FSET? ,HERE ,RLANDBIT>>
				              ,PSEUDO-OBJECT)
				             (T
				              ,HERE)>)
				     (T
				      '<COND (<EQUAL? ,HERE ,ON-LAKE>
					      ,IN-LAKE)
					     (T
					      ,HERE)>)>>)
		       (T
			<RETURN>)>>>

<ROUTINE V-SKIP ()
	 <TELL <PICK-ONE ,WHEEEEE> CR>>

<GLOBAL WHEEEEE
	<LTABLE 0 "Very good. Now you can go to the second grade."
	       "Are you enjoying yourself?"
	       "Wheeeeeeeeee!!!!!"
	       "Do you expect me to applaud?">>

<ROUTINE V-SMELL ()
	 <TELL "It smells like a " D ,PRSO "." CR>>

<ROUTINE V-SPIN ()
	 <TELL "You can't spin that!" CR>>

<ROUTINE V-SPRAY ()
	 <V-SQUEEZE>>

<ROUTINE V-SQUEEZE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "The " D ,PRSO " does not understand this.">)
	       (T
		<TELL "How singularly useless.">)>
	 <CRLF>>

<ROUTINE V-SSPRAY ()
	 <PERFORM ,V?SPRAY ,PRSI ,PRSO>>

<ROUTINE V-STAB ("AUX" W)
	 <COND (<SET W <FIND-WEAPON ,WINNER>>
		<PERFORM ,V?ATTACK ,PRSO .W>
		<RTRUE>)
	       (T
		<TELL
"No doubt you propose to stab the " D ,PRSO " with your pinky?" CR>)>>

<ROUTINE V-STAND ()
	 <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,WINNER>>
		<RTRUE>)
	       (T
		<TELL "You are already standing, I think." CR>)>>

<ROUTINE V-STAY ()
	 <TELL "You will be lost without me!" CR>>

<ROUTINE V-STRIKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL
"Since you aren't versed in hand-to-hand combat, you'd better attack the "
D ,PRSO " with a weapon." CR>)
	       (T
		<PERFORM ,V?LAMP-ON ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SWIM ()
	 <COND %<COND (<OR <==? ,ZORK-NUMBER 1>
			   <==? ,ZORK-NUMBER 2>>
		       '(<GLOBAL-IN? ,GLOBAL-WATER ,HERE>
		         <TELL "Swimming isn't usually allowed in the ">
		         <COND (<NOT <EQUAL? ,PRSO ,WATER ,GLOBAL-WATER>>
	                        <TELL D ,PRSO ".">)
		               (T
		                <TELL "dungeon.">)>
		         <CRLF>))
		      (T
		       '(<EQUAL? ,HERE ,ON-LAKE ,IN-LAKE>
		         <TELL "What do you think you're doing?" CR>))>
	       %<COND (<==? ,ZORK-NUMBER 3>
		       '(<EQUAL? ,HERE ,FLATHEAD-OCEAN>
		         <TELL
"Between the rocks and waves, you wouldn't last a minute!" CR>))
		      (T
		       '(<NULL-F>
			 <RFALSE>))>
	       (T
		<TELL "Go jump in a lake!" CR>)>>

<ROUTINE V-SWING ()
	 <COND (<NOT ,PRSI>
		<TELL "Whoosh!" CR>)
	       (T
		<PERFORM ,V?ATTACK ,PRSI ,PRSO>)>>

<ROUTINE PRE-TAKE ()
	 <COND (<IN? ,PRSO ,WINNER>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL "You are already wearing it." CR>)
		      (T
		       <TELL "You already have that!" CR>)>)
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL
"You can't reach something that's inside a closed container." CR>
		<RTRUE>)
	       (,PRSI
		<COND (<EQUAL? ,PRSI ,GROUND>
		       <SETG PRSI <>>
		       <RFALSE>)>
		%<COND (<==? ,ZORK-NUMBER 2>
			'<COND (<EQUAL? ,PRSO ,DOOR-KEEPER>
				<SETG PRSI <>>
				<RFALSE>)>)
		       (ELSE
			'<NULL-F>)>
		<COND (<NOT <EQUAL? ,PRSI <LOC ,PRSO>>>
		       <TELL "The " D ,PRSO " isn't in the " D ,PRSI "." CR>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<EQUAL? ,PRSO <LOC ,WINNER>>
		<TELL "You're inside of it!" CR>)>>

<ROUTINE V-TAKE ()
	 <COND (<EQUAL? <ITAKE> T>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL "You are now wearing the " D ,PRSO "." CR>)
		      (T
		       <TELL "Taken." CR>)>)>>

<ROUTINE V-TELL ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       <SETG HERE <LOC ,WINNER>>)
		      (T
		       <TELL "The " D ,PRSO
" pauses for a moment, perhaps thinking that you should reread
the manual." CR>)>)
	       (T
		<TELL "You can't talk to the " D ,PRSO "!" CR>
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<RFATAL>)>>

<ROUTINE V-THROUGH ("OPTIONAL" (OBJ <>) "AUX" M)
	#DECL ((OBJ) <OR OBJECT FALSE> (M) <PRIMTYPE VECTOR>)
	<COND (<AND <FSET? ,PRSO ,DOORBIT>
		    <SET M <OTHER-SIDE ,PRSO>>>
	       <DO-WALK .M>
	       <RTRUE>)
	      (<AND <NOT .OBJ> <FSET? ,PRSO ,VEHBIT>>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<OR .OBJ <NOT <FSET? ,PRSO ,TAKEBIT>>>
	       %<COND (<==? ,ZORK-NUMBER 2>
		       '<COND (<AND ,SCOL-ROOM
				   <OR .OBJ <EQUAL? ,PRSO ,CURTAIN>>>
			      <SCOL-GO .OBJ>
			      <RTRUE>)
			     (<AND <EQUAL? ,HERE ,DEPOSITORY>
				   <EQUAL? ,PRSO ,SNWL>
				   ,SCOL-ROOM>
			      <SCOL-GO .OBJ>
			      <RTRUE>)
			     (<AND <EQUAL? ,HERE ,SCOL-ACTIVE>
				   <EQUAL? ,PRSO 
					   <GET <SET M <GET-WALL ,HERE>> 1>>>
			      <SETG SCOL-ROOM <GET .M 2>>
			      <SETG PRSO <GETP ,PRSO ,P?SIZE>>
			      <COND (.OBJ <SCOL-OBJ .OBJ 0 ,DEPOSITORY>)
				    (T
				     <SCOL-THROUGH 0 ,DEPOSITORY>)>
			      <RTRUE>)
			     (<EQUAL? ,PRSO ,CURTAIN>
			      <TELL
"You can't go more than part way through the curtain." CR>
			      <RTRUE>)>)
		      (ELSE '<NULL-F>)>
	       <TELL
"You hit your head against the " D ,PRSO " as you attempt this feat." CR>)
	      (<IN? ,PRSO ,WINNER>
	       <TELL "That would involve quite a contortion!" CR>)
	      (T
	       <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-THROW ()
	 <COND (<IDROP>
		<COND (<EQUAL? ,PRSI ,ME>
		       <TELL
"A terrific throw! The " D ,PRSO>
		       <SETG WINNER ,PLAYER>
		       <JIGS-UP " hits you squarely in the head. Normally,
this wouldn't do much damage, but by incredible mischance, you fall over
backwards trying to duck, and break your neck, justice being swift and
merciful in the Great Underground Empire.">)
		      (<AND ,PRSI <FSET? ,PRSI ,ACTORBIT>>
		       <TELL
"The " D ,PRSI " ducks as the " D ,PRSO " flies by and crashes to the ground."
CR>)
		      (T <TELL "Thrown." CR>)>)
	       (ELSE <TELL "Huh?" CR>)>>

<ROUTINE V-THROW-OFF ()
	 <TELL "You can't throw anything off of that!" CR>>

<ROUTINE V-TIE ()
	 <COND (<EQUAL? ,PRSI ,WINNER>
		<TELL "You can't tie anything to yourself." CR>)
	       (T
		<TELL "You can't tie the " D ,PRSO " to that." CR>)>>

<ROUTINE V-TIE-UP ()
	 <TELL "You could certainly never tie it with that!" CR>>

<ROUTINE V-TREASURE ()
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,HERE ,NORTH-TEMPLE>
		         <GOTO ,TREASURE-ROOM>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,HERE ,TREASURE-ROOM>
		         <GOTO ,NORTH-TEMPLE>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (T
		<TELL "Nothing happens." CR>)>>

<ROUTINE PRE-TURN ()
	 %<COND (<==? ,ZORK-NUMBER 3>
		 '<COND (<AND <EQUAL? ,PRSI <> ,ROOMS>
			      <EQUAL? ,PRSO ,DIAL ,TM-DIAL ,T-BAR>>
			 <TELL
"You should turn the " D ,PRSO " to something." CR>
			 <RTRUE>)>)
		(ELSE T)>
	 <COND (%<COND (<==? ,ZORK-NUMBER 1>
			'<AND <EQUAL? ,PRSI <> ,ROOMS>
			      <NOT <EQUAL? ,PRSO ,BOOK>>>)
		       (ELSE
			'<EQUAL? ,PRSI <> ,ROOMS>)>
		<TELL "Your bare hands don't appear to be enough." CR>)
	       (<NOT <FSET? ,PRSO ,TURNBIT>>
		<TELL "You can't turn that!" CR>)>>

<ROUTINE V-TURN ()
	 <TELL "This has no effect." CR>>

<ROUTINE V-UNLOCK ()
	 <V-LOCK>>

<ROUTINE V-UNTIE ()
	 <TELL "This cannot be tied, so it cannot be untied!" CR>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 <TELL "Time passes..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0> <RETURN>)
		       (<CLOCKER> <RETURN>)>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     %<COND (<==? ,ZORK-NUMBER 3>
				     '(<AND <EQUAL? ,HERE ,CP> ,CP-MOVED>
		                       <RTRUE>))
				    (T
				     '(<NULL-F> <RFALSE>))>
			     (T
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL "You can't go that way." CR>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <TELL "The " D .OBJ " is closed." CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)>)>)
	       (<AND <NOT ,LIT>
		     <PROB 80>
		     <EQUAL? ,WINNER ,ADVENTURER>
		     <NOT <FSET? ,HERE ,NONLANDBIT>>>
		<COND (,SPRAYED?
		       <TELL
"There are odd noises in the darkness, and there is no exit in that
direction." CR>
		       <RFATAL>)
		      %<COND (<==? ,ZORK-NUMBER 3>
			      '(<EQUAL? ,HERE ,DARK-1 ,DARK-2>
		                <JIGS-UP
"Oh, no! You have walked into a den of hungry grues and it's dinner time!">))
			     (T
			      '(<NULL-F>
				<RFALSE>))>
		      (T
		       <JIGS-UP
"Oh, no! You have walked into the slavering fangs of a lurking grue!">)>)
	       (T
		<TELL "You can't go that way." CR>
		<RFATAL>)>>

<ROUTINE V-WALK-AROUND ()
	 <TELL "Use compass directions for movement." CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<AND ,PRSO
		     <OR <IN? ,PRSO ,HERE>
			 <GLOBAL-IN? ,PRSO ,HERE>>>
		<TELL "It's here!" CR>)
	       (T
		<TELL "You should supply a direction!" CR>)>>

<ROUTINE V-WAVE ()
	 <HACK-HACK "Waving the ">>

<ROUTINE V-WEAR ()
	 <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<TELL "You can't wear the " D ,PRSO "." CR>)
	       (T
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-WIN ()
	 <TELL "Naturally!" CR>>

<ROUTINE V-WIND ()
	 <TELL "You cannot wind up a " D ,PRSO "." CR>>

<ROUTINE V-WISH ()
	 %<COND (<==? ,ZORK-NUMBER 2>
		 '<PERFORM ,V?MAKE ,WISH>)
		(T
		 '<TELL "With luck, your wish will come true." CR>)>>

<ROUTINE V-YELL () <TELL "Aaaarrrrgggghhhh!" CR>>

<ROUTINE V-ZORK () <TELL "At your service!" CR>>

^L

"Verb-Associated Routines"

"Descriptions"

<GLOBAL LIT <>>

<GLOBAL SPRAYED? <>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (<NOT ,SUPER-BRIEF>
		       <DESCRIBE-OBJECTS>)>)>>

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)
	 <SET V? <OR .LOOK? ,VERBOSE>>
	 <COND (<NOT ,LIT>
		<TELL "It is pitch black.">
		<COND (<NOT ,SPRAYED?>
		       <TELL " You are likely to be eaten by a grue.">)>
		<CRLF>
		%<COND (<==? ,ZORK-NUMBER 3>
			'<COND (<EQUAL? ,HERE ,DARK-2>
		                <TELL
"The ground continues to slope upwards away from the lake. You can barely
detect a dim light from the east." CR>)>)
		       (T
			'<NULL-F>)>
		<RFALSE>)>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET V? T>)>
	 %<COND (<==? ,ZORK-NUMBER 1>
		 '<COND (<FSET? ,HERE ,MAZEBIT>
		         <FCLEAR ,HERE ,TOUCHBIT>)>)
		(T
		 '<NULL-F>)>
	 <COND (<IN? ,HERE ,ROOMS>
		;"Was <TELL D ,HERE CR>"
		<TELL D ,HERE>
		<COND (<FSET? <SET AV <LOC ,WINNER>> ,VEHBIT>
		       <TELL ", in the " D .AV>)>
		<CRLF>)>
	 <COND (%<COND (<==? ,ZORK-NUMBER 2>
			'<OR .LOOK? <NOT ,SUPER-BRIEF> <EQUAL? ,HERE ,ZORK3>>)
		       (ELSE
			'<OR .LOOK? <NOT ,SUPER-BRIEF>>)>
		<SET AV <LOC ,WINNER>>
		;<COND (<FSET? .AV ,VEHBIT>
		       <TELL "(You are in the " D .AV ".)" CR>)>
		<COND (<AND .V? <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?LDESC>>>
		       <TELL .STR CR>)
		      (T
		       <APPLY <GETP ,HERE ,P?ACTION> ,M-FLASH>)>
		<COND (<AND <NOT <EQUAL? ,HERE .AV>> <FSET? .AV ,VEHBIT>>
		       <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>)>)>
	 T>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))
	 <COND (,LIT
		<COND (<FIRST? ,HERE>
		       <PRINT-CONT ,HERE <SET V? <OR .V? ,VERBOSE>> -1>)>)
	       (T
		<TELL "Only bats can see in the dark. And you're not one." CR>)>>

"DESCRIBE-OBJECT -- takes object and flag.  if flag is true will print a
long description (fdesc or ldesc), otherwise will print short."

<GLOBAL DESC-OBJECT <>>

<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)
	 <SETG DESC-OBJECT .OBJ>
	 <COND (<AND <0? .LEVEL>
		     <APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC>>
		<RTRUE>)
	       (<AND <0? .LEVEL>
		     <OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>>
			      <SET STR <GETP .OBJ ,P?FDESC>>>
			 <SET STR <GETP .OBJ ,P?LDESC>>>>
		<TELL .STR>)
	       (<0? .LEVEL>
		<TELL "There is a " D .OBJ " here">
		<COND (<FSET? .OBJ ,ONBIT>
		       <TELL " (providing light)">)>
		<TELL ".">)
	       (T
		<TELL <GET ,INDENTS .LEVEL>>
		<TELL "A " D .OBJ>
		<COND (<FSET? .OBJ ,ONBIT>
		       <TELL " (providing light)">)
		      (<AND <FSET? .OBJ ,WEARBIT>
			    <IN? .OBJ ,WINNER>>
		       <TELL " (being worn)">)>)>
	 %<COND (<==? ,ZORK-NUMBER 2>
		 '<COND (<AND <EQUAL? .OBJ ,SPELL-VICTIM>
		              <EQUAL? ,SPELL-USED ,W?FLOAT>>
		         <TELL " (floating in midair)">)>)
		(T
		 '<NULL-F>)>
	 <COND (<AND <0? .LEVEL>
		     <SET AV <LOC ,WINNER>>
		     <FSET? .AV ,VEHBIT>>
		<TELL " (outside the " D .AV ")">)>
	 <CRLF>
	 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>>
		<PRINT-CONT .OBJ .V? .LEVEL>)>>

<ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T) (IT? <>) (TWO? <>))
	 <COND (<SET F <FIRST? .OBJ>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (.1ST? <SET 1ST? <>>)
			      (ELSE
			       <TELL ", ">
			       <COND (<NOT .N> <TELL "and ">)>)>
			<TELL "a " D .F>
			<COND (<AND <NOT .IT?> <NOT .TWO?>>
			       <SET IT? .F>)
			      (ELSE
			       <SET TWO? T>
			       <SET IT? <>>)>
			<SET F .N>
			<COND (<NOT .F>
			       <COND (<AND .IT? <NOT .TWO?>>
				      <THIS-IS-IT .IT?>)>
			       <RTRUE>)>>)>>

<ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0)
		     "AUX" Y 1ST? SHIT AV STR (PV? <>) (INV? <>))
	 <COND (<NOT <SET Y <FIRST? .OBJ>>> <RTRUE>)>
	 <COND (<AND <SET AV <LOC ,WINNER>> <FSET? .AV ,VEHBIT>>
		T)
	       (ELSE <SET AV <>>)>
	 <SET 1ST? T>
	 <SET SHIT T>
	 <COND (<EQUAL? ,WINNER .OBJ <LOC .OBJ>>
		<SET INV? T>)
	       (ELSE
		<REPEAT ()
			<COND %<COND (<==? ,ZORK-NUMBER 2>
				      '(<NOT .Y>
					<COND (<AND <0? .LEVEL>
						    <==? ,SPELL? ,S-FANTASIZE>
						    <PROB 20>>
					       <TELL "There is a "
						     <PICK-ONE ,FANTASIES>
						     " here." CR>
					       <SET 1ST? <>>)>
					<RETURN>))
				     (ELSE
				      '(<NOT .Y>
					<RETURN>))>
			      (<EQUAL? .Y .AV> <SET PV? T>)
			      (<EQUAL? .Y ,WINNER>)
			      (<AND <NOT <FSET? .Y ,INVISIBLE>>
				    <NOT <FSET? .Y ,TOUCHBIT>>
				    <SET STR <GETP .Y ,P?FDESC>>>
			       <COND (<NOT <FSET? .Y ,NDESCBIT>>
				      <TELL .STR CR>
				      <SET SHIT <>>
				      ;<SET 1ST? <>>)>
			       <COND (<AND <SEE-INSIDE? .Y>
					   <NOT <GETP <LOC .Y> ,P?DESCFCN>>
					   <FIRST? .Y>>
				      <COND (<PRINT-CONT .Y .V? 0>
					     <SET 1ST? <>>)>)>)>
			<SET Y <NEXT? .Y>>>)>
	 <SET Y <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .Y>
			<COND (<AND .PV? .AV <FIRST? .AV>>
			       <SET LEVEL <+ .LEVEL 1>> ;"not in Zork III"
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN>)
		       (<EQUAL? .Y .AV ,ADVENTURER>)
		       (<AND <NOT <FSET? .Y ,INVISIBLE>>
			     <OR .INV?
				 <FSET? .Y ,TOUCHBIT>
				 <NOT <GETP .Y ,P?FDESC>>>>
			<COND (<NOT <FSET? .Y ,NDESCBIT>>
			       <COND (.1ST?
				      <COND (<FIRSTER .OBJ .LEVEL>
					     <COND (<L? .LEVEL 0>
						    <SET LEVEL 0>)>)>
				      <SET LEVEL <+ 1 .LEVEL>>
				      <SET 1ST? <>>)>
			       <COND (<L? .LEVEL 0> <SET LEVEL 0>)>
			       <DESCRIBE-OBJECT .Y .V? .LEVEL>)
			      (<AND <FIRST? .Y> <SEE-INSIDE? .Y>>
			       <SET LEVEL <+ .LEVEL 1>> ;"not in Zork III"
			       <PRINT-CONT .Y .V? .LEVEL>
			       <SET LEVEL <- .LEVEL 1>> ;"not in Zork III")>)>
		 <SET Y <NEXT? .Y>>>
	 <COND (<AND .1ST? .SHIT> <RFALSE>) (T <RTRUE>)>>

<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? .OBJ ,TROPHY-CASE>
		         <TELL
"Your collection of treasures consists of:" CR>))
		      (T
		       '(<NULL-F> <RTRUE>))>
	       (<EQUAL? .OBJ ,WINNER>
		<TELL "You are carrying:" CR>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Sitting on the " D .OBJ " is: " CR>)
		      (<FSET? .OBJ ,ACTORBIT>
		       <TELL "The " D .OBJ " is holding: " CR>)
		      (T
		       <TELL "The " D .OBJ " contains:" CR>)>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT> <FSET? .OBJ ,OPENBIT>>>>

"Scoring"

<GLOBAL MOVES 0>

<GLOBAL SCORE 0>

<GLOBAL BASE-SCORE 0>

<GLOBAL WON-FLAG <>>

<ROUTINE SCORE-UPD (NUM)
	 <SETG BASE-SCORE <+ ,BASE-SCORE .NUM>>
	 <SETG SCORE <+ ,SCORE .NUM>>
	 %<COND (<==? ,ZORK-NUMBER 1>
		 '<COND (<AND <EQUAL? ,SCORE 350>
		              <NOT ,WON-FLAG>>
		         <SETG WON-FLAG T>
		         <FCLEAR ,MAP ,INVISIBLE>
		         <FCLEAR ,WEST-OF-HOUSE ,TOUCHBIT>
		         <TELL
"An almost inaudible voice whispers in your ear, \"Look to your treasures
for the final secret.\"" CR>)>)
		(T
		 '<NULL-F>)>
	 T>

<ROUTINE SCORE-OBJ (OBJ "AUX" TEMP)
	 <COND (<G? <SET TEMP <GETP .OBJ ,P?VALUE>> 0>
		<SCORE-UPD .TEMP>
		<PUTP .OBJ ,P?VALUE 0>)>>

<ROUTINE YES? ()
	 <PRINTI ">">
	 <READ ,P-INBUF ,P-LEXV>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?YES ,W?Y>
		<RTRUE>)
	       (T
		<RFALSE>)>>

"Death"

<GLOBAL DEAD <>>

<GLOBAL DEATHS 0>

<GLOBAL LUCKY 1>

;"JIGS-UP is in ACTIONS.ZIL"

;"RANDOMIZE-OBJECTS is in ACTIONS.ZIL"

;"KILL-INTERRUPTS is in ACTIONS.ZIL"

"Object Manipulation"

<GLOBAL FUMBLE-NUMBER 700>      ;"Modification: Original value was 7"

<GLOBAL FUMBLE-PROB 8>

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)
	 #DECL ((VB) <OR ATOM FALSE> (CNT) FIX (OBJ) OBJECT)
	 <COND %<COND (<==? ,ZORK-NUMBER 1>
		       '(,DEAD
		         <COND (.VB
				<TELL
"Your hand passes through its object." CR>)>
		         <RFALSE>))
		      (T
		       '(<NULL-F>
			 <RFALSE>))>
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL <PICK-ONE ,YUKS> CR>)>
		<RFALSE>)
	       %<COND (<==? ,ZORK-NUMBER 2>
		       '(<AND <EQUAL? ,PRSO ,SPELL-VICTIM>
		              <EQUAL? ,SPELL-USED ,W?FLOAT ,W?FREEZE>>
		         <COND (<EQUAL? ,SPELL-USED ,W?FLOAT>
		                <TELL
"You can't reach that. It's floating above your head." CR>)
		               (T
		                <TELL "It seems rooted to the spot." CR>)>
		         <RFALSE>))
		      (T
		       '(<NULL-F>
			 <RFALSE>))>
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		;"Kludge for parser calling itake"
		<RFALSE>)
	       (<AND <NOT <IN? <LOC ,PRSO> ,WINNER>>
		     <G? <+ <WEIGHT ,PRSO> <WEIGHT ,WINNER>> ,LOAD-ALLOWED>>
		<COND (.VB
		       <TELL "Your load is too heavy">
		       <COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
			      <TELL", especially in light of your condition.">)
			     (T
			      <TELL ".">)>
		       <CRLF>)>
		<RFATAL>)
	       (<AND <VERB? TAKE>
		     <G? <SET CNT <CCOUNT ,WINNER>> ,FUMBLE-NUMBER>
		     <PROB <* .CNT ,FUMBLE-PROB>>>
		<TELL
"You're holding too many things already!" CR>
		<RFALSE>)
	       (T
		<MOVE ,PRSO ,WINNER>
		<FCLEAR ,PRSO ,NDESCBIT>
		<FSET ,PRSO ,TOUCHBIT>
		%<COND (<==? ,ZORK-NUMBER 2>
			'<COND (<EQUAL? ,SPELL? ,S-FILCH>
		                <COND (<RIPOFF ,PRSO ,WIZARD-CASE>
			               <TELL
"When you touch the " D ,PRSO " it immediately disappears!" CR>
			               <RFALSE>)>)>)
		       (T
			'<NULL-F>)>
		%<COND (<OR <==? ,ZORK-NUMBER 1>
			    <==? ,ZORK-NUMBER 2>>
			'<SCORE-OBJ ,PRSO>)
		       (T
			'<NULL-F>)>
		<RTRUE>)>>

<ROUTINE IDROP ()
	 <COND (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <IN? <LOC ,PRSO> ,WINNER>>>
		<TELL "You're not carrying the " D ,PRSO "." CR>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,WINNER>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "The " D ,PRSO " is closed." CR>
		<RFALSE>)
	       (T
		<MOVE ,PRSO <LOC ,WINNER>>
		<RTRUE>)>>

<ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .X ,WEARBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<AND <EQUAL? .OBJ ,PLAYER>
				    <FSET? .CONT ,WEARBIT>>
			       <SET WT <+ .WT 1>>)
			      (T
			       <SET WT <+ .WT <WEIGHT .CONT>>>)>
			<COND (<NOT <SET CONT <NEXT? .CONT>>> <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

"Miscellaneous"

<CONSTANT REXIT 0>
<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 1>

<GLOBAL INDENTS
	<TABLE (PURE)
	       ""
	       "  "
	       "    "
	       "      "
	       "        "
	       "          ">>

<ROUTINE HACK-HACK (STR)
	 <COND (<AND <IN? ,PRSO ,GLOBAL-OBJECTS>
		     <VERB? WAVE RAISE LOWER>>
		<TELL "The " D ,PRSO " isn't here!" CR>)
	       (T
		<TELL .STR D ,PRSO <PICK-ONE ,HO-HUM> CR>)>>

<GLOBAL HO-HUM
	<LTABLE
	 0
	 " doesn't seem to work."
	 " isn't notably helpful."
	 " has no effect.">>

<ROUTINE NO-GO-TELL (AV WLOC)
	 <COND (.AV
		<TELL "You can't go there in a " D .WLOC ".">)
	       (T
		<TELL "You can't go there without a vehicle.">)>
	 <CRLF>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T)
	       "AUX" (LB <FSET? .RM ,RLANDBIT>) (WLOC <LOC ,WINNER>)
	             (AV <>) OLIT OHERE)
	 <SET OLIT ,LIT>
	 <SET OHERE ,HERE>
	 <COND (<FSET? .WLOC ,VEHBIT>
		<SET AV <GETP .WLOC ,P?VTYPE>>)>
	 <COND (<AND <NOT .LB>
		     <NOT .AV>>
		<NO-GO-TELL .AV .WLOC>
		<RFALSE>)
	       (<AND <NOT .LB>
		     <NOT <FSET? .RM .AV>>>
		<NO-GO-TELL .AV .WLOC>
		<RFALSE>)
	       (<AND <FSET? ,HERE ,RLANDBIT>
		     .LB
		     .AV
		     <NOT <EQUAL? .AV ,RLANDBIT>>
		     <NOT <FSET? .RM .AV>>>
		<NO-GO-TELL .AV .WLOC>
		<RFALSE>)
	       (<FSET? .RM ,RMUNGBIT>
		<TELL <GETP .RM ,P?LDESC> CR>
		<RFALSE>)
	       (T
		<COND (<AND .LB
			    <NOT <FSET? ,HERE ,RLANDBIT>>
			    <NOT ,DEAD>
			    <FSET? .WLOC ,VEHBIT>>
		       %<COND (<==? ,ZORK-NUMBER 1>
			       '<TELL
"The " D .WLOC " comes to a rest on the shore." CR CR>)
			      (<==? ,ZORK-NUMBER 2>
			       '<COND (<EQUAL? .WLOC ,BALLOON>
				       <TELL
"The balloon lands." CR>)
				      (<FSET? .WLOC ,VEHBIT>
				       <TELL
"The " D .WLOC " comes to a stop." CR CR>)>)
			      (<==? ,ZORK-NUMBER 3>
			       '<COND (<FSET? .WLOC ,VEHBIT>
				       <TELL
"The " D .WLOC " comes to a stop." CR CR>)>)>)>
		<COND (.AV
		       <MOVE .WLOC .RM>)
		      (T
		       <MOVE ,WINNER .RM>)>
		<SETG HERE .RM>
		<SETG LIT <LIT? ,HERE>>
		<COND (<AND <NOT .OLIT>
			    <NOT ,LIT>
			    <PROB 80>>
		       <COND (,SPRAYED?
			      <TELL
"There are sinister gurgling noises in the darkness all around you!" CR>)
			     %<COND (<==? ,ZORK-NUMBER 3>
				     '(<EQUAL? ,HERE ,DARK-1 ,DARK-2>
		                       <JIGS-UP
"Oh, no! Dozen of lurking grues attack and devour you! You must have
stumbled into an authentic grue lair!">))
				    (T
				     '(<NULL-F>
				       <RFALSE>))>
			     (T
			      <TELL
"Oh, no! A lurking grue slithered into the ">
			      <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
				     <TELL D <LOC ,WINNER>>)
				    (T <TELL "room">)>
			      <JIGS-UP " and devoured you!">
			      <RTRUE>)>)>
		<COND (<AND <NOT ,LIT>
			    <EQUAL? ,WINNER ,ADVENTURER>>
		       <TELL "You have moved into a dark place." CR>
		       <SETG P-CONT <>>)>
		<APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
		<SCORE-OBJ .RM>
		<COND (<NOT <EQUAL? ,HERE .RM>> <RTRUE>)
		      (<AND <NOT <EQUAL? ,ADVENTURER ,WINNER>>
			    <IN? ,ADVENTURER .OHERE>>
		       <TELL "The " D ,WINNER " leaves the room." CR>)
		      %<COND (<==? ,ZORK-NUMBER 1>
			      '(<AND <EQUAL? ,HERE .OHERE>
				      ;"no double description"
				     <EQUAL? ,HERE ,ENTRANCE-TO-HADES>>
				<RTRUE>))
			     (ELSE
			      '(<NULL-F> <RTRUE>))>
		      (<AND .V?
			    <EQUAL? ,WINNER ,ADVENTURER>>
		       <V-FIRST-LOOK>)>
		<RTRUE>)>>

<ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .LEN>
			<RFALSE>)
		       (<EQUAL? <GET .TBL .CNT> .ITM>
			<COND (<EQUAL? .CNT .LEN> <RFALSE>)
			      (T
			       <RETURN <GET .TBL <+ .CNT 1>>>)>)>>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TX)
	 <COND (<SET TX <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQB .OBJ1 .TX <- <PTSIZE .TX> 1>>)>> 

<ROUTINE FIND-IN (WHERE WHAT "AUX" W)
	 <SET W <FIRST? .WHERE>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<AND <FSET? .W .WHAT>
			     <NOT <EQUAL? .W ,ADVENTURER>>>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>>
			<RETURN <>>)>>>

<ROUTINE HELD? (CAN)
	 <REPEAT ()
		 <SET CAN <LOC .CAN>>
		 <COND (<NOT .CAN> <RFALSE>)
		       (<EQUAL? .CAN ,WINNER> <RTRUE>)>>>

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TX) ;"finds room beyond given door"
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (ELSE
			<SET TX <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .TX> ,DEXIT>
				    <EQUAL? <GETB .TX ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

<ROUTINE MUNG-ROOM (RM STR)
	 %<COND (<==? ,ZORK-NUMBER 2>
		 '<COND (<EQUAL? .RM ,INSIDE-BARROW>
			 <RFALSE>)>)
		(ELSE T)>
	 <FSET .RM ,RMUNGBIT>
	 <PUTP .RM ,P?LDESC .STR>>

<ROUTINE THIS-IS-IT (OBJ)
	 <SETG P-IT-OBJECT .OBJ>>

<COND (<N==? ,ZORK-NUMBER 3>
       <GLOBAL SWIMYUKS
	       <LTABLE 0 "You can't swim in the dungeon.">>)>

<GLOBAL HELLOS
	<LTABLE 0 "Hello."
	       "Good day."
	       "Nice weather we've been having lately."
	       "Goodbye.">>

<GLOBAL YUKS
	<LTABLE
	 0
	 "A valiant attempt."
	 "You can't be serious."
	 ;"Not bloody likely."
	 "An interesting idea..."
	 "What a concept!">>

<GLOBAL DUMMY
	<LTABLE 0 
		"Look around."
	        "Too late for that."
	        "Have your eyes checked.">>
			
;-------------------------------------------------------
"GLOBALS"
;-------------------------------------------------------
			"Generic GLOBALS file for
			    The ZORK Trilogy
		       started on 7/28/83 by MARC"

"SUBTITLE GLOBAL OBJECTS"

<OBJECT GLOBAL-OBJECTS
	(FLAGS RMUNGBIT INVISIBLE TOUCHBIT SURFACEBIT TRYTAKEBIT
	       OPENBIT SEARCHBIT TRANSBIT ONBIT RLANDBIT FIGHTBIT
	       STAGGERED WEARBIT)>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZZMGCK)
	(DESCFCN PATH-OBJECT)
        (GLOBAL GLOBAL-OBJECTS)
	(ADVFCN 0)
	(FDESC "F")
	(LDESC "F")
	(PSEUDO "FOOBAR" V-WALK)
	(CONTFCN 0)
	(VTYPE 1)
	(SIZE 0)
	(CAPACITY 0)>

;"Yes, this synonym for LOCAL-GLOBALS needs to exist... sigh"

<OBJECT ROOMS
	(IN TO ROOMS)>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(SYNONYM INTNUM)
	(FLAGS TOOLBIT)
	(DESC "number")>

<OBJECT PSEUDO-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "pseudo")
	(ACTION CRETIN-FCN)>

<OBJECT IT
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THEM HER HIM)
	(DESC "random object")
	(FLAGS NDESCBIT TOUCHBIT)>

<OBJECT NOT-HERE-OBJECT
	(DESC "such thing" ;"[not here]")
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ)
	 ;"This COND is game independent (except the TELL)"
	 <COND (<AND <EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		     <EQUAL? ,PRSI ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here!" CR>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	 ;"Here is the default 'cant see any' printer"
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <COND (<EQUAL? ,WINNER ,PLAYER>
		<TELL "You can't see any ">
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!" CR>)
	       (T
		<TELL "The " D ,WINNER " seems confused. \"I don't see any ">
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!\"" CR>)>
	 <RTRUE>>

<ROUTINE NOT-HERE-PRINT (PRSO?)
 <COND (,P-OFLAG
	<COND (,P-XADJ <PRINTB ,P-XADJN>)>
	<COND (,P-XNAM <PRINTB ,P-XNAM>)>)
       (.PRSO?
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> <>>)
       (T
	<BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> <>>)>>

<ROUTINE NULL-F ("OPTIONAL" A1 A2)
	 <RFALSE>>

/^L

"Objects shared by all three Zorks go here"

<GLOBAL LOAD-MAX 10000>     ;"Modification: Original value was 100"

<GLOBAL LOAD-ALLOWED 10000> ;"Modification: Original value was 100"

<OBJECT BLESSINGS
	(IN GLOBAL-OBJECTS)
	(SYNONYM BLESSINGS GRACES)
	(DESC "blessings")
	(FLAGS NDESCBIT)>

<OBJECT STAIRS
	(IN LOCAL-GLOBALS)
	(SYNONYM STAIRS STEPS STAIRCASE STAIRWAY)
	(ADJECTIVE STONE DARK MARBLE FORBIDDING STEEP)
	(DESC "stairs")
	(FLAGS NDESCBIT CLIMBBIT)
	(ACTION STAIRS-F)>

<ROUTINE STAIRS-F ()
	 <COND (<VERB? THROUGH>
		<TELL
"You should say whether you want to go up or down." CR>)>>

<OBJECT SAILOR
	(IN GLOBAL-OBJECTS)
	(SYNONYM SAILOR FOOTPAD AVIATOR)
	(DESC "sailor")
	(FLAGS NDESCBIT)
	(ACTION SAILOR-FCN)>

<ROUTINE SAILOR-FCN ()
	  <COND (<VERB? TELL>
		 <SETG P-CONT <>>
		 <SETG QUOTE-FLAG <>>
		 <TELL "You can't talk to the sailor that way." CR>)
		(<VERB? EXAMINE>
		 %<COND (<==? ,ZORK-NUMBER 3>
			 '<COND (<NOT <FSET? ,VIKING-SHIP ,INVISIBLE>>
				 <TELL
"He looks like a sailor." CR>
				 <RTRUE>)>)
			(ELSE T)>
		 <TELL
"There is no sailor to be seen." CR>)
		(<VERB? HELLO>
		 <SETG HS <+ ,HS 1>>
		 %<COND (<==? ,ZORK-NUMBER 3>
			 '<COND (<NOT <FSET? ,VIKING-SHIP ,INVISIBLE>>
		                 <TELL
"The seaman looks up and maneuvers the boat toward shore. He cries out \"I
have waited three ages for someone to say those words and save me from
sailing this endless ocean. Please accept this gift. You may find it
useful!\" He throws something which falls near you in the sand, then sails
off toward the west, singing a lively, but somewhat uncouth, sailor song." CR>
		                 <FSET ,VIKING-SHIP ,INVISIBLE>
		                 <MOVE ,VIAL ,HERE>)
		                (<==? ,HERE ,FLATHEAD-OCEAN>
		                 <COND (,SHIP-GONE
			                <TELL "Nothing happens anymore." CR>)
			               (T
				        <TELL "Nothing happens yet." CR>)>)
				(T <TELL "Nothing happens here." CR>)>)
			(T
			 '<COND (<0? <MOD ,HS 20>>
				 <TELL
"You seem to be repeating yourself." CR>)
				(<0? <MOD ,HS 10>>
				 <TELL
"I think that phrase is getting a bit worn out." CR>)
				(T
				 <TELL "Nothing happens here." CR>)>)>)>>

<OBJECT GROUND
	(IN GLOBAL-OBJECTS)
	(SYNONYM GROUND SAND DIRT FLOOR)
	(DESC "ground")
	(ACTION GROUND-FUNCTION)>

<ROUTINE GROUND-FUNCTION ()
	 <COND (<AND <VERB? PUT PUT-ON>
		     <EQUAL? ,PRSI ,GROUND>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       %<COND (<==? ,ZORK-NUMBER 1>
		       '(<EQUAL? ,HERE ,SANDY-CAVE>
			 <SAND-FUNCTION>))
		      (T
		       '(<NULL-F>
			 <RFALSE>))>
	       (<VERB? DIG>
		<TELL "The ground is too hard for digging here." CR>)>>

<OBJECT GRUE
	(IN GLOBAL-OBJECTS)
	(SYNONYM GRUE)
	(ADJECTIVE LURKING SINISTER HUNGRY SILENT)
	(DESC "lurking grue")
	(ACTION GRUE-FUNCTION)>

<ROUTINE GRUE-FUNCTION ()
    <COND (<VERB? EXAMINE>
	   <TELL
"The grue is a sinister, lurking presence in the dark places of the
earth. Its favorite diet is adventurers, but its insatiable
appetite is tempered by its fear of light. No grue has ever been
seen by the light of day, and few have survived its fearsome jaws
to tell the tale." CR>)
	  (<VERB? FIND>
	   <TELL
"There is no grue here, but I'm sure there is at least one lurking
in the darkness nearby. I wouldn't let my light go out if I were
you!" CR>)
	  (<VERB? LISTEN>
	   <TELL
"It makes no sound but is always lurking in the darkness nearby." CR>)>>

<OBJECT LUNGS
	(IN GLOBAL-OBJECTS)
	(SYNONYM LUNGS AIR MOUTH BREATH)
	(DESC "blast of air")
	(FLAGS NDESCBIT)>

<OBJECT ME
	(IN GLOBAL-OBJECTS)
	(SYNONYM ME MYSELF SELF CRETIN)
	(DESC "you")
	(FLAGS ACTORBIT)
	(ACTION CRETIN-FCN)>

<ROUTINE CRETIN-FCN ()
	 <COND (<VERB? TELL>
		<SETG P-CONT <>>
		<SETG QUOTE-FLAG <>>
		<TELL
"Talking to yourself is said to be a sign of impending mental collapse." CR>)
	       (<AND <VERB? GIVE>
		     <EQUAL? ,PRSI ,ME>>
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)
	       (<VERB? MAKE>
		<TELL "Only you can do that." CR>)
	       (<VERB? DISEMBARK>
		<TELL "You'll have to do that on your own." CR>)
	       (<VERB? EAT>
		<TELL "Auto-cannibalism is not the answer." CR>)
	       (<VERB? ATTACK MUNG>
		<COND (<AND ,PRSI <FSET? ,PRSI ,WEAPONBIT>>
		       <JIGS-UP "If you insist.... Poof, you're dead!">)
		      (T
		       <TELL "Suicide is not the answer." CR>)>)
	       (<VERB? THROW>
		<COND (<==? ,PRSO ,ME>
		       <TELL
"Why don't you just walk like normal people?" CR>)>)
	       (<VERB? TAKE>
		<TELL "How romantic!" CR>)
	       (<VERB? EXAMINE>
		<COND %<COND (<==? ,ZORK-NUMBER 1>
			      '(<EQUAL? ,HERE <LOC ,MIRROR-1> <LOC ,MIRROR-2>>
		                <TELL
"Your image in the mirror looks tired." CR>))
			     (<==? ,ZORK-NUMBER 3>
			      '(,INVIS
				<TELL
"A good trick, as you are currently invisible." CR>))
			     (T
			      '(<NULL-F> <RTRUE>))>
		      (T
		       %<COND (<==? ,ZORK-NUMBER 3>
			       '<TELL
"What you can see looks pretty much as usual, sorry to say." CR>)
			      (ELSE
			       '<TELL
"That's difficult unless your eyes are prehensile." CR>)>)>)>>

<OBJECT ADVENTURER
	(SYNONYM ADVENTURER)
	(DESC "cretin")
	(FLAGS NDESCBIT INVISIBLE SACREDBIT ACTORBIT)
	(STRENGTH 0)
	(ACTION 0)>

<OBJECT PATHOBJ
	(IN GLOBAL-OBJECTS)
	(SYNONYM TRAIL PATH)
        (ADJECTIVE FOREST NARROW LONG WINDING)
	(DESC "passage")
	(FLAGS NDESCBIT)
	(ACTION PATH-OBJECT)>

<ROUTINE PATH-OBJECT ()
	 <COND (<VERB? TAKE FOLLOW>
		<TELL "You must specify a direction to go." CR>)
	       (<VERB? FIND>
		<TELL "I can't help you there...." CR>)
	       (<VERB? DIG>
		<TELL "Not a chance." CR>)>>

<OBJECT ZORKMID
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZORKMID)
	(DESC "zorkmid")
	(ACTION ZORKMID-FUNCTION)>

<ROUTINE ZORKMID-FUNCTION ()
    <COND (<VERB? EXAMINE>
	   <TELL
"The zorkmid is the unit of currency of the Great Underground Empire." CR>)
	  (<VERB? FIND>
	   <TELL
"The best way to find zorkmids is to go out and look for them." CR>)>>

<OBJECT HANDS
	(IN GLOBAL-OBJECTS)
	(SYNONYM PAIR HANDS HAND)
	(ADJECTIVE BARE)
	(DESC "pair of hands")
	(FLAGS NDESCBIT TOOLBIT)>
	
;-------------------------------------------------------
"DUNGEON"
;-------------------------------------------------------
"1DUNGEON for
	        Zork I: The Great Underground Empire
	(c) Copyright 1983 Infocom, Inc. All Rights Reserved."

<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>

<GLOBAL SCORE-MAX 350>

<GLOBAL FALSE-FLAG <>>

"SUBTITLE OBJECTS"

<OBJECT BOARD
	(IN LOCAL-GLOBALS)
	(SYNONYM BOARDS BOARD)
	(DESC "board")
	(FLAGS NDESCBIT)
	(ACTION BOARD-F)>

<OBJECT TEETH
	(IN GLOBAL-OBJECTS)
	(SYNONYM OVERBOARD TEETH)
	(DESC "set of teeth")
	(FLAGS NDESCBIT)
	(ACTION TEETH-F)>

<OBJECT WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL WALLS)
	(ADJECTIVE SURROUNDING)
	(DESC "surrounding wall")>

<OBJECT GRANITE-WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL)
	(ADJECTIVE GRANITE)
	(DESC "granite wall")
	(ACTION GRANITE-WALL-F)>

<OBJECT SONGBIRD
	(IN LOCAL-GLOBALS)
	(SYNONYM BIRD SONGBIRD)
	(ADJECTIVE SONG)
	(DESC "songbird")
	(FLAGS NDESCBIT)
	(ACTION SONGBIRD-F)>

<OBJECT WHITE-HOUSE	
	(IN LOCAL-GLOBALS)
	(SYNONYM HOUSE)
	(ADJECTIVE WHITE BEAUTI COLONI)
	(DESC "white house")
	(FLAGS NDESCBIT)
	(ACTION WHITE-HOUSE-F)>

<OBJECT FOREST
	(IN LOCAL-GLOBALS)
	(SYNONYM FOREST TREES PINES HEMLOCKS)
	(DESC "forest")
	(FLAGS NDESCBIT)
	(ACTION FOREST-F)>

<OBJECT TREE
	(IN LOCAL-GLOBALS)
	(SYNONYM TREE BRANCH)
	(ADJECTIVE LARGE STORM ;"-TOSSED")
	(DESC "tree")
	(FLAGS NDESCBIT CLIMBBIT)>

<OBJECT MOUNTAIN-RANGE
	(IN MOUNTAINS)
	(DESC "mountain range")
	(SYNONYM MOUNTAIN RANGE)
	(ADJECTIVE IMPASSABLE FLATHEAD)
	(FLAGS NDESCBIT CLIMBBIT)
	(ACTION MOUNTAIN-RANGE-F)>

<OBJECT GLOBAL-WATER
	(IN LOCAL-GLOBALS)
	(SYNONYM WATER QUANTITY)
	(DESC "water")
	(FLAGS DRINKBIT)
	(ACTION WATER-F)>

<OBJECT WATER
	(IN BOTTLE)
	(SYNONYM WATER QUANTITY LIQUID H2O)
	(DESC "quantity of water")
	(FLAGS TRYTAKEBIT TAKEBIT DRINKBIT)
	(ACTION WATER-F)
	(SIZE 4)>

<OBJECT	KITCHEN-WINDOW
	(IN LOCAL-GLOBALS)
	(SYNONYM WINDOW)
	(ADJECTIVE KITCHEN SMALL)
	(DESC "kitchen window")
	(FLAGS DOORBIT NDESCBIT)
	(ACTION KITCHEN-WINDOW-F)>

<OBJECT CHIMNEY
	(IN LOCAL-GLOBALS)
	(SYNONYM CHIMNEY)
	(ADJECTIVE DARK NARROW)
	(DESC "chimney")
	(ACTION CHIMNEY-F)
	(FLAGS CLIMBBIT NDESCBIT)>

<OBJECT GHOSTS
	(IN ENTRANCE-TO-HADES)
	(SYNONYM GHOSTS SPIRITS FIENDS FORCE)
	(ADJECTIVE INVISIBLE EVIL)
	(DESC "number of ghosts")
	(FLAGS ACTORBIT NDESCBIT)
	(ACTION GHOSTS-F)>

<OBJECT SKULL
	(IN LAND-OF-LIVING-DEAD)
	(SYNONYM SKULL HEAD TREASURE)
	(ADJECTIVE CRYSTAL)
	(DESC "crystal skull")
	(FDESC
"Lying in one corner of the room is a beautifully carved crystal skull.
It appears to be grinning at you rather nastily.")
	(FLAGS TAKEBIT)
	(VALUE 10)
	(TVALUE 10)>

<OBJECT LOWERED-BASKET
	(IN LOWER-SHAFT)
	(SYNONYM CAGE DUMBWAITER BASKET)
	(ADJECTIVE LOWERED)
	(LDESC "From the chain is suspended a basket.")
	(DESC "basket")
	(FLAGS TRYTAKEBIT)
	(ACTION BASKET-F)>

<OBJECT RAISED-BASKET
	(IN SHAFT-ROOM)
	(SYNONYM CAGE DUMBWAITER BASKET)
	(DESC "basket")
	(FLAGS TRANSBIT TRYTAKEBIT CONTBIT OPENBIT)
	(ACTION BASKET-F)
	(LDESC "At the end of the chain is a basket.")
	(CAPACITY 50)>

<OBJECT LUNCH
	(IN SANDWICH-BAG)
	(SYNONYM FOOD SANDWICH LUNCH DINNER)
	(ADJECTIVE HOT PEPPER)
	(DESC "lunch")
	(FLAGS TAKEBIT FOODBIT)
	(LDESC "A hot pepper sandwich is here.")>

<OBJECT BAT
	(IN BAT-ROOM)
	(SYNONYM BAT VAMPIRE)
	(ADJECTIVE VAMPIRE DERANGED)
	(DESC "bat")
	(FLAGS ACTORBIT TRYTAKEBIT)
	(DESCFCN BAT-D)
	(ACTION BAT-F)>

<OBJECT BELL
	(IN NORTH-TEMPLE)
	(SYNONYM BELL)
	(ADJECTIVE SMALL BRASS)
	(DESC "brass bell")
	(FLAGS TAKEBIT)
	(ACTION BELL-F)>

<OBJECT HOT-BELL
	(SYNONYM BELL)
	(ADJECTIVE BRASS HOT RED SMALL)
	(DESC "red hot brass bell")
	(FLAGS TRYTAKEBIT)
	(ACTION HOT-BELL-F)
	(LDESC "On the ground is a red hot bell.")>

<OBJECT AXE
	(IN TROLL)
	(SYNONYM AXE AX)
	(ADJECTIVE BLOODY)
	(DESC "bloody axe")
	(FLAGS WEAPONBIT TRYTAKEBIT TAKEBIT NDESCBIT)
	(ACTION AXE-F)
	(SIZE 25)>

<OBJECT BOLT
	(IN DAM-ROOM)
	(SYNONYM BOLT NUT)
	(ADJECTIVE METAL LARGE)
	(DESC "bolt")
	(FLAGS NDESCBIT TURNBIT TRYTAKEBIT)
	(ACTION BOLT-F)>

<OBJECT BUBBLE
	(IN DAM-ROOM)
	(SYNONYM BUBBLE)
	(ADJECTIVE SMALL GREEN PLASTIC)
	(DESC "green bubble")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION BUBBLE-F)>

<OBJECT ALTAR
	(IN SOUTH-TEMPLE)
	(SYNONYM ALTAR)
	(DESC "altar")
	(FLAGS NDESCBIT SURFACEBIT CONTBIT OPENBIT)
	(CAPACITY 50)>

<OBJECT BOOK
	(IN ALTAR)
	(SYNONYM BOOK PRAYER PAGE BOOKS)
	(ADJECTIVE LARGE BLACK)
	(DESC "black book")
	(FLAGS READBIT TAKEBIT CONTBIT BURNBIT TURNBIT)
	(ACTION BLACK-BOOK)
	(FDESC "On the altar is a large black book, open to page 569.")
	(SIZE 10)
	(TEXT
"Commandment #12592|
|
Oh ye who go about saying unto each:  \"Hello sailor\":|
Dost thou know the magnitude of thy sin before the gods?|
Yea, verily, thou shalt be ground between two stones.|
Shall the angry gods cast thy body into the whirlpool?|
Surely, thy eye shall be put out with a sharp stick!|
Even unto the ends of the earth shalt thou wander and|
Unto the land of the dead shalt thou be sent at last.|
Surely thou shalt repent of thy cunning." )>

<OBJECT BROKEN-LAMP
	(SYNONYM LAMP LANTERN)
	(ADJECTIVE BROKEN)
	(DESC "broken lantern")
	(FLAGS TAKEBIT)>

<OBJECT SCEPTRE
	(IN COFFIN)
	(SYNONYM SCEPTRE SCEPTER TREASURE)
	(ADJECTIVE SHARP EGYPTIAN ANCIENT ENAMELED)
	(DESC "sceptre")
	(FLAGS TAKEBIT WEAPONBIT)
	(ACTION SCEPTRE-FUNCTION)
	(LDESC
"An ornamented sceptre, tapering to a sharp point, is here.")
	(FDESC
"A sceptre, possibly that of ancient Egypt itself, is in the coffin. The
sceptre is ornamented with colored enamel, and tapers to a sharp point.")
	(SIZE 3)
	(VALUE 4)
	(TVALUE 6)>

<OBJECT TIMBERS
	(IN TIMBER-ROOM)
	(SYNONYM TIMBERS PILE)
	(ADJECTIVE WOODEN BROKEN)
	(DESC "broken timber")
	(FLAGS TAKEBIT)
	(SIZE 50)>

<OBJECT	SLIDE
	(IN LOCAL-GLOBALS)
	(SYNONYM CHUTE RAMP SLIDE)
	(ADJECTIVE STEEP METAL TWISTING)
	(DESC "chute")
	(FLAGS CLIMBBIT)
	(ACTION SLIDE-FUNCTION)>

<OBJECT KITCHEN-TABLE
	(IN KITCHEN)
	(SYNONYM TABLE)
	(ADJECTIVE KITCHEN)
	(DESC "kitchen table")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
	(CAPACITY 50)>

<OBJECT ATTIC-TABLE
	(IN ATTIC)
	(SYNONYM TABLE)
	(DESC "table")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
	(CAPACITY 40)>

<OBJECT SANDWICH-BAG
	(IN KITCHEN-TABLE)
	(SYNONYM BAG SACK)
	(ADJECTIVE BROWN ELONGATED SMELLY)
	(DESC "brown sack")
	(FLAGS TAKEBIT CONTBIT BURNBIT)
	(FDESC
"On the table is an elongated brown sack, smelling of hot peppers.")
	(CAPACITY 9)
	(SIZE 9)
	(ACTION SANDWICH-BAG-FCN)>

<OBJECT TOOL-CHEST
	(IN MAINTENANCE-ROOM)
	(SYNONYM CHEST CHESTS GROUP TOOLCHESTS)
	(ADJECTIVE TOOL)
	(DESC "group of tool chests")
	(FLAGS CONTBIT OPENBIT TRYTAKEBIT SACREDBIT)
	(ACTION TOOL-CHEST-FCN)>

<OBJECT YELLOW-BUTTON
	(IN MAINTENANCE-ROOM)
	(SYNONYM BUTTON SWITCH)
	(ADJECTIVE YELLOW)
	(DESC "yellow button")
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT BROWN-BUTTON
	(IN MAINTENANCE-ROOM)
	(SYNONYM BUTTON SWITCH)
	(ADJECTIVE BROWN)
	(DESC "brown button")
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT RED-BUTTON
	(IN MAINTENANCE-ROOM)
	(SYNONYM BUTTON SWITCH)
	(ADJECTIVE RED)
	(DESC "red button")
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT BLUE-BUTTON
	(IN MAINTENANCE-ROOM)
	(SYNONYM BUTTON SWITCH)
	(ADJECTIVE BLUE)
	(DESC "blue button")
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT TROPHY-CASE	;"first obj so L.R. desc looks right."
	(IN LIVING-ROOM)
	(SYNONYM CASE)
	(ADJECTIVE TROPHY)
	(DESC "trophy case")
	(FLAGS TRANSBIT CONTBIT NDESCBIT TRYTAKEBIT SEARCHBIT)
	(ACTION TROPHY-CASE-FCN)
	(CAPACITY 10000)>

<OBJECT RUG
	(IN LIVING-ROOM)
	(SYNONYM RUG CARPET)
	(ADJECTIVE LARGE ORIENTAL)
	(DESC "carpet")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION RUG-FCN)>

<OBJECT CHALICE
	(IN TREASURE-ROOM)
	(SYNONYM CHALICE CUP SILVER TREASURE)
	(ADJECTIVE SILVER ENGRAVINGS) ;"engravings exists..."
	(DESC "chalice")
	(FLAGS TAKEBIT TRYTAKEBIT CONTBIT)
	(ACTION CHALICE-FCN)
	(LDESC "There is a silver chalice, intricately engraved, here.")
	(CAPACITY 5)
	(SIZE 10)
	(VALUE 10)
	(TVALUE 5)>

<OBJECT GARLIC
	(IN SANDWICH-BAG)
	(SYNONYM GARLIC CLOVE)
	(DESC "clove of garlic")
	(FLAGS TAKEBIT FOODBIT)
	(ACTION GARLIC-F)
	(SIZE 4)>

<OBJECT TRIDENT
	(IN ATLANTIS-ROOM)
	(SYNONYM TRIDENT FORK TREASURE)
	(ADJECTIVE POSEIDON OWN CRYSTAL)
	(DESC "crystal trident")
	(FLAGS TAKEBIT)
	(FDESC "On the shore lies Poseidon's own crystal trident.")
	(SIZE 20)
	(VALUE 4)
	(TVALUE 11)>

<OBJECT CYCLOPS
	(IN CYCLOPS-ROOM)
	(SYNONYM CYCLOPS MONSTER EYE)
	(ADJECTIVE HUNGRY GIANT)
	(DESC "cyclops")
	(FLAGS ACTORBIT NDESCBIT TRYTAKEBIT)
	(ACTION CYCLOPS-FCN)
	(STRENGTH 10000)>

<OBJECT DAM
	(IN DAM-ROOM)
	(SYNONYM DAM GATE GATES FCD\#3)
	(DESC "dam")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION DAM-FUNCTION)>

<OBJECT TRAP-DOOR
	(IN LOCAL-GLOBALS)
	(SYNONYM DOOR TRAPDOOR TRAP-DOOR COVER)
	(ADJECTIVE TRAP DUSTY)
	(DESC "trap door")
	(FLAGS DOORBIT NDESCBIT INVISIBLE)
	(ACTION TRAP-DOOR-FCN)>

<OBJECT BOARDED-WINDOW
	(IN LOCAL-GLOBALS)
        (SYNONYM WINDOW)
	(ADJECTIVE BOARDED)
	(DESC "boarded window")
	(FLAGS NDESCBIT)
	(ACTION BOARDED-WINDOW-FCN)>

<OBJECT FRONT-DOOR
	(IN WEST-OF-HOUSE)
	(SYNONYM DOOR)
	(ADJECTIVE FRONT BOARDED)
	(DESC "door")
	(FLAGS DOORBIT NDESCBIT)
	(ACTION FRONT-DOOR-FCN)>

<OBJECT BARROW-DOOR	
	(IN STONE-BARROW)
	(SYNONYM DOOR)
	(ADJECTIVE HUGE STONE)
	(DESC "stone door")
	(FLAGS DOORBIT NDESCBIT OPENBIT)
	(ACTION BARROW-DOOR-FCN)>

<OBJECT BARROW
	(IN STONE-BARROW)
	(SYNONYM BARROW TOMB)
	(ADJECTIVE MASSIVE STONE)
	(DESC "stone barrow")
	(FLAGS NDESCBIT)
	(ACTION BARROW-FCN)>

<OBJECT BOTTLE
	(IN KITCHEN-TABLE)
	(SYNONYM BOTTLE CONTAINER)
	(ADJECTIVE CLEAR GLASS)
	(DESC "glass bottle")
	(FLAGS TAKEBIT TRANSBIT CONTBIT)
	(ACTION BOTTLE-FUNCTION)
	(FDESC "A bottle is sitting on the table.")
	(CAPACITY 4)>

<OBJECT CRACK
	(IN LOCAL-GLOBALS)
	(SYNONYM CRACK)
	(ADJECTIVE NARROW)
	(DESC "crack")
	(FLAGS NDESCBIT)
	(ACTION CRACK-FCN)>

<OBJECT COFFIN
	(IN EGYPT-ROOM)
	(SYNONYM COFFIN CASKET TREASURE)
	(ADJECTIVE SOLID GOLD)
	(DESC "gold coffin")
	(FLAGS TAKEBIT CONTBIT SACREDBIT SEARCHBIT)
	(LDESC
"The solid-gold coffin used for the burial of Ramses II is here.")
	(CAPACITY 35)
	(SIZE 55)
	(VALUE 10)
	(TVALUE 15)>

<OBJECT GRATE
	(IN LOCAL-GLOBALS)
	(SYNONYM GRATE GRATING)
	(DESC "grating")
	(FLAGS DOORBIT NDESCBIT INVISIBLE)
	(ACTION GRATE-FUNCTION)>

<OBJECT PUMP
	(IN RESERVOIR-NORTH)
	(SYNONYM PUMP AIR-PUMP TOOL TOOLS)
	(ADJECTIVE SMALL HAND-HELD)
	(DESC "hand-held air pump")
	(FLAGS TAKEBIT TOOLBIT)>

<OBJECT DIAMOND
	(SYNONYM DIAMOND TREASURE)
	(ADJECTIVE HUGE ENORMOUS)
	(DESC "huge diamond")
	(FLAGS TAKEBIT)
	(LDESC "There is an enormous diamond (perfectly cut) here.")
	(VALUE 10)
	(TVALUE 10)>

<OBJECT JADE
	(IN BAT-ROOM)
	(SYNONYM FIGURINE TREASURE)
	(ADJECTIVE EXQUISITE JADE)
	(DESC "jade figurine")
	(FLAGS TAKEBIT)
	(LDESC "There is an exquisite jade figurine here.")
	(SIZE 10)
	(VALUE 5)
	(TVALUE 5)>

<OBJECT KNIFE
	(IN ATTIC-TABLE)
	(SYNONYM KNIVES KNIFE BLADE)
	(ADJECTIVE NASTY UNRUSTY)
	(DESC "nasty knife")
	(FLAGS TAKEBIT WEAPONBIT TRYTAKEBIT)
	(FDESC "On a table is a nasty-looking knife.")
	(ACTION KNIFE-F)>

<OBJECT BONES
	(IN MAZE-5)
	(SYNONYM BONES SKELETON BODY)
	(DESC "skeleton")
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION SKELETON)>

<OBJECT BURNED-OUT-LANTERN
	(IN MAZE-5)
	(SYNONYM LANTERN LAMP)
	(ADJECTIVE RUSTY BURNED DEAD USELESS)
	(DESC "burned-out lantern")
	(FLAGS TAKEBIT)
	(FDESC "The deceased adventurer's useless lantern is here.")
	(SIZE 20)>

<OBJECT BAG-OF-COINS
	(IN MAZE-5)
	(SYNONYM BAG COINS TREASURE)
	(ADJECTIVE OLD LEATHER)
	(DESC "leather bag of coins")
	(FLAGS TAKEBIT)
	(LDESC "An old leather bag, bulging with coins, is here.")
	(ACTION BAG-OF-COINS-F)
	(SIZE 15)
	(VALUE 10)
	(TVALUE 5)>

<OBJECT LAMP
	(IN LIVING-ROOM)
	(SYNONYM LAMP LANTERN LIGHT)
	(ADJECTIVE BRASS)
	(DESC "brass lantern")
	(FLAGS TAKEBIT LIGHTBIT)
	(ACTION LANTERN)
	(FDESC "A battery-powered brass lantern is on the trophy case.")
	(LDESC "There is a brass lantern (battery-powered) here.")
	(SIZE 15)>

<OBJECT EMERALD
	(IN BUOY)
	(SYNONYM EMERALD TREASURE)
	(ADJECTIVE LARGE)
	(DESC "large emerald")
	(FLAGS TAKEBIT)
	(VALUE 5)
	(TVALUE 10)>

<OBJECT ADVERTISEMENT
	(IN MAILBOX)
	(SYNONYM ADVERTISEMENT LEAFLET BOOKLET MAIL)
	(ADJECTIVE SMALL)
	(DESC "leaflet")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(LDESC "A small leaflet is on the ground.")
	(TEXT
"\"WELCOME TO ZORK!|
|
ZORK is a game of adventure, danger, and low cunning. In it you
will explore some of the most amazing territory ever seen by mortals.
No computer should be without one!\"")
	(SIZE 2)>

<OBJECT LEAK
	(IN MAINTENANCE-ROOM)
	(SYNONYM LEAK DRIP PIPE)
	(DESC "leak")
	(FLAGS NDESCBIT INVISIBLE)
	(ACTION LEAK-FUNCTION)>

<OBJECT MACHINE
	(IN MACHINE-ROOM)
	(SYNONYM MACHINE PDP10 DRYER LID)
	(DESC "machine")
	(FLAGS CONTBIT NDESCBIT TRYTAKEBIT)
	(ACTION MACHINE-F)
	(CAPACITY 50)>

<OBJECT INFLATED-BOAT
	(SYNONYM BOAT RAFT)
	(ADJECTIVE INFLAT MAGIC PLASTIC SEAWORTHY)
	(DESC "magic boat")
	(FLAGS TAKEBIT BURNBIT VEHBIT OPENBIT SEARCHBIT)
	(ACTION RBOAT-FUNCTION)
	(CAPACITY 100)
	(SIZE 20)
	(VTYPE NONLANDBIT)>

<OBJECT MAILBOX
	(IN WEST-OF-HOUSE)
	(SYNONYM MAILBOX BOX)
	(ADJECTIVE SMALL)
	(DESC "small mailbox")
	(FLAGS CONTBIT TRYTAKEBIT)
	(CAPACITY 10)
	(ACTION MAILBOX-F)>

<OBJECT MATCH
	(IN DAM-LOBBY)
	(SYNONYM MATCH MATCHES MATCHBOOK)
	(ADJECTIVE MATCH)
	(DESC "matchbook")
	(FLAGS READBIT TAKEBIT)
	(ACTION MATCH-FUNCTION)
	(LDESC
"There is a matchbook whose cover says \"Visit Beautiful FCD#3\" here.")
	(SIZE 2)
	(TEXT
"|
(Close cover before striking)|
|
YOU too can make BIG MONEY in the exciting field of PAPER SHUFFLING!|
|
Mr. Anderson of Muddle, Mass. says: \"Before I took this course I
was a lowly bit twiddler. Now with what I learned at GUE Tech
I feel really important and can obfuscate and confuse with the best.\"|
|
Dr. Blank had this to say: \"Ten short days ago all I could look
forward to was a dead-end job as a doctor. Now I have a promising
future and make really big Zorkmids.\"|
|
GUE Tech can't promise these fantastic results to everyone. But when
you earn your degree from GUE Tech, your future will be brighter." )>

<OBJECT MIRROR-2
	(IN MIRROR-ROOM-2)
	(SYNONYM REFLECTION MIRROR ENORMOUS)
	(DESC "mirror")
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION MIRROR-MIRROR)>

<OBJECT MIRROR-1
	(IN MIRROR-ROOM-1)
	(SYNONYM REFLECTION MIRROR ENORMOUS)
	(DESC "mirror")
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION MIRROR-MIRROR)>

<OBJECT PAINTING
	(IN GALLERY)
	(SYNONYM PAINTING ART CANVAS TREASURE)
	(ADJECTIVE BEAUTI)
	(DESC "painting")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION PAINTING-FCN)
	(FDESC
"Fortunately, there is still one chance for you to be a vandal, for on
the far wall is a painting of unparalleled beauty.")
	(LDESC "A painting by a neglected genius is here.")
	(SIZE 15)
	(VALUE 4)
	(TVALUE 6)>

<OBJECT CANDLES
	(IN SOUTH-TEMPLE)
	(SYNONYM CANDLES PAIR)
	(ADJECTIVE BURNING)
	(DESC "pair of candles")
	(FLAGS TAKEBIT FLAMEBIT ONBIT LIGHTBIT)
	(ACTION CANDLES-FCN)
	(FDESC "On the two ends of the altar are burning candles.")
	(SIZE 10)>

<OBJECT GUNK
	(SYNONYM GUNK PIECE SLAG)
	(ADJECTIVE SMALL VITREOUS)
	(DESC "small piece of vitreous slag")
	(FLAGS TAKEBIT TRYTAKEBIT)
	(ACTION GUNK-FUNCTION)
	(SIZE 10)>

<OBJECT BODIES
	(IN LOCAL-GLOBALS)
	(SYNONYM BODIES BODY REMAINS PILE)
	(ADJECTIVE MANGLED)
	(DESC "pile of bodies")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION BODY-FUNCTION)>

<OBJECT LEAVES
	(IN GRATING-CLEARING)
	(SYNONYM LEAVES LEAF PILE)
	(DESC "pile of leaves")
	(FLAGS TAKEBIT BURNBIT TRYTAKEBIT)
	(ACTION LEAF-PILE)
	(LDESC "On the ground is a pile of leaves.")
	(SIZE 25)>

<OBJECT PUNCTURED-BOAT
	(SYNONYM BOAT PILE PLASTIC)
	(ADJECTIVE PLASTIC PUNCTURE LARGE)
	(DESC "punctured boat")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION DBOAT-FUNCTION)
	(SIZE 20)>

<OBJECT INFLATABLE-BOAT
	(IN DAM-BASE)
	(SYNONYM BOAT PILE PLASTIC VALVE)
	(ADJECTIVE PLASTIC INFLAT)
	(DESC "pile of plastic")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION IBOAT-FUNCTION)
	(LDESC
"There is a folded pile of plastic here which has a small valve
attached.")
	(SIZE 20)>

<OBJECT BAR
	(IN LOUD-ROOM)
	(SYNONYM BAR PLATINUM TREASURE)
	(ADJECTIVE PLATINUM LARGE)
	(DESC "platinum bar")
	(FLAGS TAKEBIT SACREDBIT)
	(LDESC "On the ground is a large platinum bar.")
	(SIZE 20)
	(VALUE 10)
	(TVALUE 5)>

<OBJECT POT-OF-GOLD
	(IN END-OF-RAINBOW)
	(SYNONYM POT GOLD TREASURE)
	(ADJECTIVE GOLD)
	(DESC "pot of gold")
	(FLAGS TAKEBIT INVISIBLE)
	(FDESC "At the end of the rainbow is a pot of gold.")
	(SIZE 15)
	(VALUE 10)
	(TVALUE 10)>

<OBJECT PRAYER
	(IN NORTH-TEMPLE)
	(SYNONYM PRAYER INSCRIPTION)
	(ADJECTIVE ANCIENT OLD)
	(DESC "prayer")
	(FLAGS READBIT SACREDBIT NDESCBIT)
	(TEXT
"The prayer is inscribed in an ancient script, rarely used today. It seems
to be a philippic against small insects, absent-mindedness, and the picking
up and dropping of small objects. The final verse consigns trespassers to
the land of the dead. All evidence indicates that the beliefs of the ancient
Zorkers were obscure." )>

<OBJECT RAILING
	(IN DOME-ROOM)
	(SYNONYM RAILING RAIL)
	(ADJECTIVE WOODEN)
	(DESC "wooden railing")
	(FLAGS NDESCBIT)>

<OBJECT RAINBOW
	(IN LOCAL-GLOBALS)
	(SYNONYM RAINBOW)
	(DESC "rainbow")
	(FLAGS NDESCBIT CLIMBBIT)
	(ACTION RAINBOW-FCN)>

<OBJECT RIVER
	(IN LOCAL-GLOBALS)
	(DESC "river")
	(SYNONYM RIVER)
	(ADJECTIVE FRIGID)
	(ACTION RIVER-FUNCTION)
	(FLAGS NDESCBIT)>

<OBJECT BUOY
	(IN RIVER-4)
	(SYNONYM BUOY)
	(ADJECTIVE RED)
	(DESC "red buoy")
	(FLAGS TAKEBIT CONTBIT)
	(FDESC "There is a red buoy here (probably a warning).")
	(CAPACITY 20)
	(SIZE 10)
	(ACTION TREASURE-INSIDE)>

<ROUTINE TREASURE-INSIDE ()
	 <COND (<VERB? OPEN>
		<SCORE-OBJ ,EMERALD>
		<RFALSE>)>>
<OBJECT ROPE
	(IN ATTIC)
	(SYNONYM ROPE HEMP COIL)
	(ADJECTIVE LARGE)
	(DESC "rope")
	(FLAGS TAKEBIT SACREDBIT TRYTAKEBIT)
	(ACTION ROPE-FUNCTION)
	(FDESC "A large coil of rope is lying in the corner.")
	(SIZE 10)>

<OBJECT RUSTY-KNIFE
	(IN MAZE-5)
	(SYNONYM KNIVES KNIFE)
	(ADJECTIVE RUSTY)
	(DESC "rusty knife")
	(FLAGS TAKEBIT TRYTAKEBIT WEAPONBIT TOOLBIT)
	(ACTION RUSTY-KNIFE-FCN)
	(FDESC "Beside the skeleton is a rusty knife.")
	(SIZE 20)>

<OBJECT SAND
	(IN SANDY-CAVE)
	(SYNONYM SAND)
	(DESC "sand")
	(FLAGS NDESCBIT)
	(ACTION SAND-FUNCTION)>

<OBJECT BRACELET
	(IN GAS-ROOM)
	(SYNONYM BRACELET JEWEL SAPPHIRE TREASURE)
	(ADJECTIVE SAPPHIRE)
	(DESC "sapphire-encrusted bracelet")
	(FLAGS TAKEBIT)
	(SIZE 10)
	(VALUE 5)
	(TVALUE 5)>

<OBJECT SCREWDRIVER
	(IN MAINTENANCE-ROOM)
	(SYNONYM SCREWDRIVER TOOL TOOLS DRIVER)
	(ADJECTIVE SCREW)
	(DESC "screwdriver")
	(FLAGS TAKEBIT TOOLBIT)>

<OBJECT KEYS
	(IN MAZE-5)
	(SYNONYM KEY)
	(ADJECTIVE SKELETON)
	(DESC "skeleton key")
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 10)>

<OBJECT SHOVEL
	(IN SANDY-BEACH)
	(SYNONYM SHOVEL TOOL TOOLS)
	(DESC "shovel")
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 15)>

<OBJECT COAL
	(IN DEAD-END-5)
	(SYNONYM COAL PILE HEAP)
	(ADJECTIVE SMALL)
	(DESC "small pile of coal")
	(FLAGS TAKEBIT BURNBIT)
	(SIZE 20)>

<OBJECT LADDER
	(IN LOCAL-GLOBALS)
	(SYNONYM LADDER)
	(ADJECTIVE WOODEN RICKETY NARROW)
	(DESC "wooden ladder")
	(FLAGS NDESCBIT CLIMBBIT)>

<OBJECT SCARAB
	(IN SANDY-CAVE)
	(SYNONYM SCARAB BUG BEETLE TREASURE)
	(ADJECTIVE BEAUTI CARVED JEWELED)
	(DESC "beautiful jeweled scarab")
	(FLAGS TAKEBIT INVISIBLE)
	(SIZE 8)
	(VALUE 5)
	(TVALUE 5)>

<OBJECT LARGE-BAG
	(IN THIEF)
	(SYNONYM BAG)
	(ADJECTIVE LARGE THIEFS)
	(DESC "large bag")
	(ACTION LARGE-BAG-F)
	(FLAGS TRYTAKEBIT NDESCBIT)>  

<OBJECT STILETTO
	(IN THIEF)
	(SYNONYM STILETTO)
	(ADJECTIVE VICIOUS)
	(DESC "stiletto")
	(ACTION STILETTO-FUNCTION)
	(FLAGS WEAPONBIT TRYTAKEBIT TAKEBIT NDESCBIT)
	(SIZE 10)>

<OBJECT MACHINE-SWITCH
	(IN MACHINE-ROOM)
	(SYNONYM SWITCH)
	(DESC "switch")
	(FLAGS NDESCBIT TURNBIT)
	(ACTION MSWITCH-FUNCTION)>

<OBJECT WOODEN-DOOR
	(IN LOCAL-GLOBALS)
	(SYNONYM DOOR LETTERING WRITING)
	(ADJECTIVE WOODEN GOTHIC STRANGE WEST)
	(DESC "wooden door")
	(FLAGS READBIT DOORBIT NDESCBIT TRANSBIT)
	(ACTION FRONT-DOOR-FCN)
	(TEXT
"The engravings translate to \"This space intentionally left blank.\"")>

<OBJECT SWORD
	(IN LIVING-ROOM)
	(SYNONYM SWORD ORCRIST GLAMDRING BLADE)
	(ADJECTIVE ELVISH OLD ANTIQUE)
	(DESC "sword")
	(FLAGS TAKEBIT WEAPONBIT TRYTAKEBIT)
	(ACTION SWORD-FCN)
	(FDESC
"Above the trophy case hangs an elvish sword of great antiquity.")
	(SIZE 30)
	(TVALUE 0)>

<OBJECT MAP
	(IN TROPHY-CASE)
	(SYNONYM PARCHMENT MAP)
	(ADJECTIVE ANTIQUE OLD ANCIENT)
	(DESC "ancient map")
	(FLAGS INVISIBLE READBIT TAKEBIT)
	(FDESC
"In the trophy case is an ancient parchment which appears to be a map.")
	(SIZE 2)
	(TEXT
"The map shows a forest with three clearings. The largest clearing contains
a house. Three paths leave the large clearing. One of these paths, leading
southwest, is marked \"To Stone Barrow\".")>

<OBJECT BOAT-LABEL
	(IN INFLATED-BOAT)
	(SYNONYM LABEL FINEPRINT PRINT)
	(ADJECTIVE TAN FINE)
	(DESC "tan label")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(SIZE 2)
	(TEXT
"  !!!!FROBOZZ MAGIC BOAT COMPANY!!!!|
|
Hello, Sailor!|
|
Instructions for use:|
|
   To get into a body of water, say \"Launch\".|
   To get to shore, say \"Land\" or the direction in which you want
to maneuver the boat.|
|
Warranty:|
|
  This boat is guaranteed against all defects for a period of 76
milliseconds from date of purchase or until first used, whichever comes first.|
|
Warning:|
   This boat is made of thin plastic.|
   Good Luck!" )>

<OBJECT THIEF
	(IN ROUND-ROOM)
	(SYNONYM THIEF ROBBER MAN PERSON)
	(ADJECTIVE SHADY SUSPICIOUS SEEDY)
	(DESC "thief")
	(FLAGS ACTORBIT INVISIBLE CONTBIT OPENBIT TRYTAKEBIT)
	(ACTION ROBBER-FUNCTION)
	(LDESC
"There is a suspicious-looking individual, holding a large bag, leaning
against one wall. He is armed with a deadly stiletto.")
	(STRENGTH 5)>

<OBJECT PEDESTAL
	(IN TORCH-ROOM)
	(SYNONYM PEDESTAL)
	(ADJECTIVE WHITE MARBLE)
	(DESC "pedestal")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
	(ACTION DUMB-CONTAINER)
	(CAPACITY 30)>

<OBJECT TORCH
	(IN PEDESTAL)
	(SYNONYM TORCH IVORY TREASURE)
	(ADJECTIVE FLAMING IVORY)
	(DESC "torch")
	(FLAGS TAKEBIT FLAMEBIT ONBIT LIGHTBIT)
	(ACTION TORCH-OBJECT)
	(FDESC "Sitting on the pedestal is a flaming torch, made of ivory.")
	(SIZE 20)
	(VALUE 14)
	(TVALUE 6)>

<OBJECT GUIDE
	(IN DAM-LOBBY)
	(SYNONYM GUIDE BOOK BOOKS GUIDEBOOKS)
	(ADJECTIVE TOUR GUIDE)
	(DESC "tour guidebook")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(FDESC
"Some guidebooks entitled \"Flood Control Dam #3\" are on the reception
desk.")
	(TEXT
"\"	Flood Control Dam #3|
|
FCD#3 was constructed in year 783 of the Great Underground Empire to
harness the mighty Frigid River. This work was supported by a grant of
37 million zorkmids from your omnipotent local tyrant Lord Dimwit
Flathead the Excessive. This impressive structure is composed of
370,000 cubic feet of concrete, is 256 feet tall at the center, and 193
feet wide at the top. The lake created behind the dam has a volume
of 1.7 billion cubic feet, an area of 12 million square feet, and a
shore line of 36 thousand feet.|
|
The construction of FCD#3 took 112 days from ground breaking to
the dedication. It required a work force of 384 slaves, 34 slave
drivers, 12 engineers, 2 turtle doves, and a partridge in a pear
tree. The work was managed by a command team composed of 2345
bureaucrats, 2347 secretaries (at least two of whom could type),
12,256 paper shufflers, 52,469 rubber stampers, 245,193 red tape
processors, and nearly one million dead trees.|
|
We will now point out some of the more interesting features
of FCD#3 as we conduct you on a guided tour of the facilities:|
|
        1) You start your tour here in the Dam Lobby. You will notice
on your right that...." )>

<OBJECT TROLL
	(IN TROLL-ROOM)
	(SYNONYM TROLL)
	(ADJECTIVE NASTY)
	(DESC "troll")
	(FLAGS ACTORBIT OPENBIT TRYTAKEBIT)
	(ACTION TROLL-FCN)
	(LDESC
"A nasty-looking troll, brandishing a bloody axe, blocks all passages
out of the room.")
	(STRENGTH 2)>

<OBJECT TRUNK
	(IN RESERVOIR)
	(SYNONYM TRUNK CHEST JEWELS TREASURE)
	(ADJECTIVE OLD)
	(DESC "trunk of jewels")
	(FLAGS TAKEBIT INVISIBLE)
	(FDESC
"Lying half buried in the mud is an old trunk, bulging with jewels.")
	(LDESC "There is an old trunk here, bulging with assorted jewels.")
	(ACTION TRUNK-F)
	(SIZE 35)
	(VALUE 15)
	(TVALUE 5)>

<OBJECT TUBE
	(IN MAINTENANCE-ROOM)
	(SYNONYM TUBE TOOTH PASTE)
	(DESC "tube")
	(FLAGS TAKEBIT CONTBIT READBIT)
	(ACTION TUBE-FUNCTION)
	(LDESC
	 "There is an object which looks like a tube of toothpaste here.")
	(CAPACITY 7)
	(SIZE 5)
	(TEXT
"---> Frobozz Magic Gunk Company <---|
          All-Purpose Gunk")>

<OBJECT PUTTY
	(IN TUBE)
	(SYNONYM MATERIAL GUNK)
	(ADJECTIVE VISCOUS)
	(DESC "viscous material")
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 6)
	(ACTION PUTTY-FCN)>

<OBJECT ENGRAVINGS
	(IN ENGRAVINGS-CAVE)
	(SYNONYM WALL ENGRAVINGS INSCRIPTION)
	(ADJECTIVE OLD ANCIENT)
	(DESC "wall with engravings")
	(FLAGS READBIT SACREDBIT)
	(LDESC "There are old engravings on the walls here.")
	(TEXT
"The engravings were incised in the living rock of the cave wall by
an unknown hand. They depict, in symbolic form, the beliefs of the
ancient Zorkers. Skillfully interwoven with the bas reliefs are excerpts
illustrating the major religious tenets of that time. Unfortunately, a
later age seems to have considered them blasphemous and just as skillfully
excised them.")>

<OBJECT OWNERS-MANUAL
	(IN STUDIO)
	(SYNONYM MANUAL PIECE PAPER)
	(ADJECTIVE ZORK OWNERS SMALL)
	(DESC "ZORK owner's manual")
	(FLAGS READBIT TAKEBIT)
	(FDESC "Loosely attached to a wall is a small piece of paper.")
	(TEXT
"Congratulations!|
|
You are the privileged owner of ZORK I: The Great Underground Empire,
a self-contained and self-maintaining universe. If used and maintained
in accordance with normal operating practices for small universes, ZORK
will provide many months of trouble-free operation.")>

<OBJECT CLIMBABLE-CLIFF
	(IN LOCAL-GLOBALS)
	(SYNONYM WALL CLIFF WALLS LEDGE)
	(ADJECTIVE ROCKY SHEER)
	(DESC "cliff")
	(ACTION CLIFF-OBJECT)
	(FLAGS NDESCBIT CLIMBBIT)>

<OBJECT WHITE-CLIFF
	(IN LOCAL-GLOBALS)
	(SYNONYM CLIFF CLIFFS)
	(ADJECTIVE WHITE)
	(DESC "white cliffs")
	(FLAGS NDESCBIT CLIMBBIT)
	(ACTION WCLIF-OBJECT)>

<OBJECT WRENCH
	(IN MAINTENANCE-ROOM)
	(SYNONYM WRENCH TOOL TOOLS)
	(DESC "wrench")
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 10)>

<OBJECT CONTROL-PANEL
	(IN DAM-ROOM)
	(SYNONYM PANEL)
	(ADJECTIVE CONTROL)
	(DESC "control panel")
	(FLAGS NDESCBIT)>

<OBJECT NEST
	(IN UP-A-TREE)
	(SYNONYM NEST)
	(ADJECTIVE BIRDS)
	(DESC "bird's nest")
	(FLAGS TAKEBIT BURNBIT CONTBIT OPENBIT SEARCHBIT)
	(FDESC "Beside you on the branch is a small bird's nest.")
	(CAPACITY 20)>

<OBJECT EGG
	(IN NEST)
	(SYNONYM EGG TREASURE)
	(ADJECTIVE BIRDS ENCRUSTED JEWELED)
	(DESC "jewel-encrusted egg")
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(ACTION EGG-OBJECT)
	(VALUE 5)
	(TVALUE 5)
	(CAPACITY 6)
	(FDESC
"In the bird's nest is a large egg encrusted with precious jewels,
apparently scavenged by a childless songbird. The egg is covered with
fine gold inlay, and ornamented in lapis lazuli and mother-of-pearl.
Unlike most eggs, this one is hinged and closed with a delicate looking
clasp. The egg appears extremely fragile.")>

<OBJECT BROKEN-EGG
	(SYNONYM EGG TREASURE)
	(ADJECTIVE BROKEN BIRDS ENCRUSTED JEWEL)
	(DESC "broken jewel-encrusted egg")
	(FLAGS TAKEBIT CONTBIT OPENBIT)
	(CAPACITY 6)
	(TVALUE 2)
	(LDESC "There is a somewhat ruined egg here.")>

<OBJECT BAUBLE
	(SYNONYM BAUBLE TREASURE)
	(ADJECTIVE BRASS BEAUTI)
	(DESC "beautiful brass bauble")
	(FLAGS TAKEBIT)
	(VALUE 1)
	(TVALUE 1)>

<OBJECT CANARY
	(IN EGG)
	(SYNONYM CANARY TREASURE)
	(ADJECTIVE CLOCKWORK GOLD GOLDEN)
	(DESC "golden clockwork canary")
	(FLAGS TAKEBIT SEARCHBIT)
	(ACTION CANARY-OBJECT)
	(VALUE 6)
	(TVALUE 4)
	(FDESC
"There is a golden clockwork canary nestled in the egg. It has ruby
eyes and a silver beak. Through a crystal window below its left
wing you can see intricate machinery inside. It appears to have
wound down.")>

<OBJECT BROKEN-CANARY
	(IN BROKEN-EGG)
	(SYNONYM CANARY TREASURE)
	(ADJECTIVE BROKEN CLOCKWORK GOLD GOLDEN)
	(DESC "broken clockwork canary")
	(FLAGS TAKEBIT)
	(ACTION CANARY-OBJECT)
	(TVALUE 1)
	(FDESC
"There is a golden clockwork canary nestled in the egg. It seems to
have recently had a bad experience. The mountings for its jewel-like
eyes are empty, and its silver beak is crumpled. Through a cracked
crystal window below its left wing you can see the remains of
intricate machinery. It is not clear what result winding it would
have, as the mainspring seems sprung.")>

\

"SUBTITLE ROOMS"

"SUBTITLE CONDITIONAL EXIT FLAGS"

<GLOBAL CYCLOPS-FLAG <>>
<GLOBAL DEFLATE <>>
<GLOBAL DOME-FLAG <>>
<GLOBAL EMPTY-HANDED <>>
<GLOBAL LLD-FLAG <>>
<GLOBAL LOW-TIDE <>>
<GLOBAL MAGIC-FLAG <>>
<GLOBAL RAINBOW-FLAG <>>
<GLOBAL TROLL-FLAG <>>
;<GLOBAL WON-FLAG <>>
<GLOBAL COFFIN-CURE <>>

"SUBTITLE FOREST AND OUTSIDE OF HOUSE"

<ROOM WEST-OF-HOUSE
      (IN ROOMS)
      (DESC "West of House")
      (NORTH TO NORTH-OF-HOUSE)
      (SOUTH TO SOUTH-OF-HOUSE)
      (NE TO NORTH-OF-HOUSE)
      (SE TO SOUTH-OF-HOUSE)
      (WEST TO FOREST-1)
      (EAST "The door is boarded and you can't remove the boards.")
      (SW TO STONE-BARROW IF WON-FLAG)
      (IN TO STONE-BARROW IF WON-FLAG)
      (ACTION WEST-HOUSE)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL WHITE-HOUSE BOARD FOREST)>

<ROOM STONE-BARROW
      (IN ROOMS)
      (LDESC
"You are standing in front of a massive barrow of stone. In the east face
is a huge stone door which is open. You cannot see into the dark of the tomb.")
      (DESC "Stone Barrow")
      (NE TO WEST-OF-HOUSE)
      (ACTION STONE-BARROW-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROOM NORTH-OF-HOUSE
      (IN ROOMS)
      (LDESC
"You are facing the north side of a white house. There is no door here,
and all the windows are boarded up. To the north a narrow path winds through
the trees.")
      (DESC "North of House")
      (SW TO WEST-OF-HOUSE)
      (SE TO EAST-OF-HOUSE)
      (WEST TO WEST-OF-HOUSE)
      (EAST TO EAST-OF-HOUSE)
      (NORTH TO PATH)
      (SOUTH "The windows are all boarded.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL BOARDED-WINDOW BOARD WHITE-HOUSE FOREST)>

<ROOM SOUTH-OF-HOUSE
      (IN ROOMS)
      (LDESC
"You are facing the south side of a white house. There is no door here,
and all the windows are boarded.")
      (DESC "South of House")
      (WEST TO WEST-OF-HOUSE)
      (EAST TO EAST-OF-HOUSE)
      (NE TO EAST-OF-HOUSE)
      (NW TO WEST-OF-HOUSE)
      (SOUTH TO FOREST-3)
      (NORTH "The windows are all boarded.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL BOARDED-WINDOW BOARD WHITE-HOUSE FOREST)>

<ROOM EAST-OF-HOUSE
      (IN ROOMS)
      (DESC "Behind House")
      (NORTH TO NORTH-OF-HOUSE)
      (SOUTH TO SOUTH-OF-HOUSE)
      (SW TO SOUTH-OF-HOUSE)
      (NW TO NORTH-OF-HOUSE)
      (EAST TO CLEARING)
      (WEST TO KITCHEN IF KITCHEN-WINDOW IS OPEN)
      (IN TO KITCHEN IF KITCHEN-WINDOW IS OPEN)
      (ACTION EAST-HOUSE)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL WHITE-HOUSE KITCHEN-WINDOW FOREST)>

<ROOM FOREST-1
      (IN ROOMS)
      (LDESC
"This is a forest, with trees in all directions. To the east,
there appears to be sunlight.")
      (DESC "Forest")
      (UP "There is no tree here suitable for climbing.")
      (NORTH TO GRATING-CLEARING)
      (EAST TO PATH)
      (SOUTH TO FOREST-3)
      (WEST "You would need a machete to go further west.")
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM FOREST-2
      (IN ROOMS)
      (LDESC "This is a dimly lit forest, with large trees all around.")
      (DESC "Forest")
      (UP "There is no tree here suitable for climbing.")
      (NORTH "The forest becomes impenetrable to the north.")
      (EAST TO MOUNTAINS)
      (SOUTH TO CLEARING)
      (WEST TO PATH)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM MOUNTAINS
      (IN ROOMS)
      (LDESC "The forest thins out, revealing impassable mountains.")
      (DESC "Forest")
      (UP "The mountains are impassable.")
      (NORTH TO FOREST-2)
      (EAST "The mountains are impassable.")
      (SOUTH TO FOREST-2)
      (WEST TO FOREST-2)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE WHITE-HOUSE)>

<ROOM FOREST-3
      (IN ROOMS)
      (LDESC "This is a dimly lit forest, with large trees all around.")
      (DESC "Forest")
      (UP "There is no tree here suitable for climbing.")
      (NORTH TO CLEARING)
      (EAST "The rank undergrowth prevents eastward movement.")
      (SOUTH "Storm-tossed trees block your way.")
      (WEST TO FOREST-1)
      (NW TO SOUTH-OF-HOUSE)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM PATH
      (IN ROOMS)
      (LDESC
"This is a path winding through a dimly lit forest. The path heads
north-south here. One particularly large tree with some low branches
stands at the edge of the path.")
      (DESC "Forest Path")
      (UP TO UP-A-TREE)
      (NORTH TO GRATING-CLEARING)
      (EAST TO FOREST-2)
      (SOUTH TO NORTH-OF-HOUSE)
      (WEST TO FOREST-1)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM UP-A-TREE
      (IN ROOMS)
      (DESC "Up a Tree")
      (DOWN TO PATH)
      (UP "You cannot climb any higher.")
      (ACTION TREE-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE FOREST SONGBIRD WHITE-HOUSE)>

<ROOM GRATING-CLEARING
      (IN ROOMS)
      (DESC "Clearing")
      (NORTH "The forest becomes impenetrable to the north.")
      (EAST TO FOREST-2)
      (WEST TO FOREST-1)
      (SOUTH TO PATH)
      (DOWN PER GRATING-EXIT)
      (ACTION CLEARING-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL WHITE-HOUSE GRATE)>

<ROUTINE GRATING-EXIT ()
	 <COND (,GRATE-REVEALED
		<COND (<FSET? ,GRATE ,OPENBIT>
		       ,GRATING-ROOM)
		      (T
		       <TELL "The grating is closed!" CR>
		       <THIS-IS-IT ,GRATE>
		       <RFALSE>)>)
	       (T <TELL "You can't go that way." CR> <RFALSE>)>>

<ROOM CLEARING
      (IN ROOMS)
      (LDESC
"You are in a small clearing in a well marked forest path that
extends to the east and west.")
      (DESC "Clearing")
      (UP "There is no tree here suitable for climbing.")
      (EAST TO CANYON-VIEW)
      (NORTH TO FOREST-2)
      (SOUTH TO FOREST-3)
      (WEST TO EAST-OF-HOUSE)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

\

"SUBTITLE HOUSE"

<ROOM KITCHEN
      (IN ROOMS)
      (DESC "Kitchen")
      (EAST TO EAST-OF-HOUSE IF KITCHEN-WINDOW IS OPEN)
      (WEST TO LIVING-ROOM)
      (OUT TO EAST-OF-HOUSE IF KITCHEN-WINDOW IS OPEN)
      (UP TO ATTIC)
      (DOWN TO STUDIO IF FALSE-FLAG ELSE
	 "Only Santa Claus climbs down chimneys.")
      (ACTION KITCHEN-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (VALUE 10)
      (GLOBAL KITCHEN-WINDOW CHIMNEY STAIRS)>

<ROOM ATTIC
      (IN ROOMS)
      (LDESC "This is the attic. The only exit is a stairway leading down.")
      (DESC "Attic")
      (DOWN TO KITCHEN)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL STAIRS)>

<ROOM LIVING-ROOM
      (IN ROOMS)
      (DESC "Living Room")
      (EAST TO KITCHEN)
      (WEST TO STRANGE-PASSAGE IF MAGIC-FLAG ELSE "The door is nailed shut.")
      (DOWN PER TRAP-DOOR-EXIT)
      (ACTION LIVING-ROOM-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL WOODEN-DOOR TRAP-DOOR STAIRS)
      (PSEUDO "NAILS" NAILS-PSEUDO "NAIL" NAILS-PSEUDO)>

\

"SUBTITLE CELLAR AND VICINITY"

<ROOM CELLAR
      (IN ROOMS)
      (DESC "Cellar")
      (NORTH TO TROLL-ROOM)
      (SOUTH TO EAST-OF-CHASM)
      (UP TO LIVING-ROOM IF TRAP-DOOR IS OPEN)
      (WEST
"You try to ascend the ramp, but it is impossible, and you slide back down.")
      (ACTION CELLAR-FCN)
      (FLAGS RLANDBIT)
      (VALUE 25)
      (GLOBAL TRAP-DOOR SLIDE STAIRS)>

<ROOM TROLL-ROOM
      (IN ROOMS)
      (LDESC
"This is a small room with passages to the east and south and a
forbidding hole leading west. Bloodstains and deep scratches
(perhaps made by an axe) mar the walls.")
      (DESC "The Troll Room")
      (SOUTH TO CELLAR)
      (EAST TO EW-PASSAGE
       IF TROLL-FLAG ELSE "The troll fends you off with a menacing gesture.")
      (WEST TO MAZE-1
       IF TROLL-FLAG ELSE "The troll fends you off with a menacing gesture.")
      (FLAGS RLANDBIT)
      (ACTION TROLL-ROOM-F)>

<ROOM EAST-OF-CHASM
      (IN ROOMS)
      (LDESC
"You are on the east edge of a chasm, the bottom of which cannot be
seen. A narrow passage goes north, and the path you are on continues
to the east.")
      (DESC "East of Chasm")
      (NORTH TO CELLAR)
      (EAST TO GALLERY)
      (DOWN "The chasm probably leads straight to the infernal regions.")
      (FLAGS RLANDBIT)
      (PSEUDO "CHASM" CHASM-PSEUDO)>

<ROOM GALLERY
      (IN ROOMS)
      (LDESC
"This is an art gallery. Most of the paintings have been stolen by
vandals with exceptional taste. The vandals left through either the
north or west exits.")
      (DESC "Gallery")
      (WEST TO EAST-OF-CHASM)
      (NORTH TO STUDIO)
      (FLAGS RLANDBIT ONBIT)>

<ROOM STUDIO
      (IN ROOMS)
      (LDESC
"This appears to have been an artist's studio. The walls and floors are
splattered with paints of 69 different colors. Strangely enough, nothing
of value is hanging here. At the south end of the room is an open door
(also covered with paint). A dark and narrow chimney leads up from a
fireplace; although you might be able to get up it, it seems unlikely
you could get back down.")
      (DESC "Studio")
      (SOUTH TO GALLERY)
      (UP PER UP-CHIMNEY-FUNCTION)
      (FLAGS RLANDBIT)
      (GLOBAL CHIMNEY)
      (PSEUDO "DOOR" DOOR-PSEUDO "PAINT" PAINT-PSEUDO)>

\

"SUBTITLE MAZE"

<ROOM MAZE-1
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (EAST TO TROLL-ROOM)
      (NORTH TO MAZE-1)
      (SOUTH TO MAZE-2)
      (WEST TO MAZE-4)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-2
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (SOUTH TO MAZE-1)
      (DOWN PER MAZE-DIODES) ;"to MAZE-4"
      (EAST TO MAZE-3)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-3
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (WEST TO MAZE-2)
      (NORTH TO MAZE-4)
      (UP TO MAZE-5)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-4
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (WEST TO MAZE-3)
      (NORTH TO MAZE-1)
      (EAST TO DEAD-END-1)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-1
      (IN ROOMS)
      (DESC "Dead End")
      (LDESC "You have come to a dead end in the maze.")
      (SOUTH TO MAZE-4)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-5
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.
A skeleton, probably the remains of a luckless adventurer, lies here.")
      (DESC "Maze")
      (EAST TO DEAD-END-2)
      (NORTH TO MAZE-3)
      (SW TO MAZE-6)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-2
      (IN ROOMS)
      (DESC "Dead End")
      (LDESC "You have come to a dead end in the maze.")
      (WEST TO MAZE-5)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-6
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (DOWN TO MAZE-5)
      (EAST TO MAZE-7)
      (WEST TO MAZE-6)
      (UP TO MAZE-9)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-7
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (UP TO MAZE-14)
      (WEST TO MAZE-6)
      (DOWN PER MAZE-DIODES) ;"to DEAD-END-1"
      (EAST TO MAZE-8)
      (SOUTH TO MAZE-15)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-8
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (NE TO MAZE-7)
      (WEST TO MAZE-8)
      (SE TO DEAD-END-3)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-3
      (IN ROOMS)
      (DESC "Dead End")
      (LDESC "You have come to a dead end in the maze.")
      (NORTH TO MAZE-8)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-9
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (NORTH TO MAZE-6)
      (DOWN PER MAZE-DIODES) ;"to MAZE-11"
      (EAST TO MAZE-10)
      (SOUTH TO MAZE-13)
      (WEST TO MAZE-12)
      (NW TO MAZE-9)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-10
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (EAST TO MAZE-9)
      (WEST TO MAZE-13)
      (UP TO MAZE-11)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-11
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
       (NE TO GRATING-ROOM)
      (DOWN TO MAZE-10)
      (NW TO MAZE-13)
      (SW TO MAZE-12)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM GRATING-ROOM
      (IN ROOMS)
      (DESC "Grating Room")
      (SW TO MAZE-11)
      (UP TO GRATING-CLEARING
       IF GRATE IS OPEN ELSE "The grating is closed.")
      (ACTION MAZE-11-FCN)
      (GLOBAL GRATE)
      (FLAGS RLANDBIT)>

<ROOM MAZE-12
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (DOWN PER MAZE-DIODES) ;"to MAZE-5"
      (SW TO MAZE-11)
      (EAST TO MAZE-13)
      (UP TO MAZE-9)
      (NORTH TO DEAD-END-4)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-4
      (IN ROOMS)
      (DESC "Dead End")
      (LDESC "You have come to a dead end in the maze.")
      (SOUTH TO MAZE-12)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-13
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (EAST TO MAZE-9)
      (DOWN TO MAZE-12)
      (SOUTH TO MAZE-10)
      (WEST TO MAZE-11)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-14
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
       (WEST TO MAZE-15)
      (NW TO MAZE-14)
      (NE TO MAZE-7)
      (SOUTH TO MAZE-7)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-15
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (WEST TO MAZE-14)
      (SOUTH TO MAZE-7)
      (SE TO CYCLOPS-ROOM)
      (FLAGS RLANDBIT MAZEBIT)>

\

"SUBTITLE CYCLOPS AND HIDEAWAY"

<ROOM CYCLOPS-ROOM
      (IN ROOMS)
      (DESC "Cyclops Room")
      (NW TO MAZE-15)
      (EAST TO STRANGE-PASSAGE
       IF MAGIC-FLAG ELSE "The east wall is solid rock.")
      (UP TO TREASURE-ROOM IF CYCLOPS-FLAG
        ELSE "The cyclops doesn't look like he'll let you past.")
      (ACTION CYCLOPS-ROOM-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM STRANGE-PASSAGE
      (IN ROOMS)
      (LDESC
"This is a long passage. To the west is one entrance. On the
east there is an old wooden door, with a large opening in it (about
cyclops sized).")
      (DESC "Strange Passage")
      (WEST TO CYCLOPS-ROOM)
      (IN TO CYCLOPS-ROOM)
      (EAST TO LIVING-ROOM)
      (FLAGS RLANDBIT)>

<ROOM TREASURE-ROOM
      (IN ROOMS)
      (LDESC
"This is a large room, whose east wall is solid granite. A number
of discarded bags, which crumble at your touch, are scattered about
on the floor. There is an exit down a staircase.")
      (DESC "Treasure Room")
      (DOWN TO CYCLOPS-ROOM)
      (ACTION TREASURE-ROOM-FCN)
      (FLAGS RLANDBIT ;"CANT-HAVE-ONBIT")
      (VALUE 25)
      (GLOBAL STAIRS)>

\

"SUBTITLE RESERVOIR AREA"

<ROOM RESERVOIR-SOUTH
      (IN ROOMS)
      (DESC "Reservoir South")
      (SE TO DEEP-CANYON)
      (SW TO CHASM-ROOM)
      (EAST TO DAM-ROOM)
      (WEST TO STREAM-VIEW)
      (NORTH TO RESERVOIR
       IF LOW-TIDE ELSE "You would drown.")
      (ACTION RESERVOIR-SOUTH-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-WATER)
      (PSEUDO "LAKE" LAKE-PSEUDO "CHASM" CHASM-PSEUDO)>

<ROOM RESERVOIR
      (IN ROOMS)
      (DESC "Reservoir")
      (NORTH TO RESERVOIR-NORTH)
      (SOUTH TO RESERVOIR-SOUTH)
      (UP TO IN-STREAM)
      (WEST TO IN-STREAM)
      (DOWN "The dam blocks your way.")
      (ACTION RESERVOIR-FCN)
      (FLAGS NONLANDBIT )
      (PSEUDO "STREAM" STREAM-PSEUDO)
      (GLOBAL GLOBAL-WATER)>

<ROOM RESERVOIR-NORTH
      (IN ROOMS)
      (DESC "Reservoir North")
      (NORTH TO ATLANTIS-ROOM)
      (SOUTH TO RESERVOIR
       IF LOW-TIDE ELSE "You would drown.")
      (ACTION RESERVOIR-NORTH-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-WATER STAIRS)
      (PSEUDO "LAKE" LAKE-PSEUDO)>

<ROOM STREAM-VIEW
      (IN ROOMS)
      (LDESC
"You are standing on a path beside a gently flowing stream. The path
follows the stream, which flows from west to east.")
      (DESC "Stream View")
      (EAST TO RESERVOIR-SOUTH)
      (WEST "The stream emerges from a spot too small for you to enter.")
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-WATER)
      (PSEUDO "STREAM" STREAM-PSEUDO)>

<ROOM IN-STREAM
      (IN ROOMS)
      (LDESC
"You are on the gently flowing stream. The upstream route is too narrow
to navigate, and the downstream route is invisible due to twisting
walls. There is a narrow beach to land on.")
      (DESC "Stream")
      (UP "The channel is too narrow.")
      (WEST "The channel is too narrow.")
      (LAND TO STREAM-VIEW)
      (DOWN TO RESERVOIR)
      (EAST TO RESERVOIR)
      (FLAGS NONLANDBIT )
      (GLOBAL GLOBAL-WATER)
      (PSEUDO "STREAM" STREAM-PSEUDO)>

\

"SUBTITLE MIRROR ROOMS AND VICINITY"

<ROOM MIRROR-ROOM-1
      (IN ROOMS)
      (DESC "Mirror Room")
      (NORTH TO COLD-PASSAGE)
      (WEST TO TWISTING-PASSAGE)
      (EAST TO SMALL-CAVE)
      (ACTION MIRROR-ROOM)
      (FLAGS RLANDBIT)>

<ROOM MIRROR-ROOM-2
      (IN ROOMS)
      (DESC "Mirror Room")
      (WEST TO WINDING-PASSAGE)
      (NORTH TO NARROW-PASSAGE)
      (EAST TO TINY-CAVE)
      (ACTION MIRROR-ROOM)
      (FLAGS RLANDBIT ONBIT)>

<ROOM SMALL-CAVE
      (IN ROOMS)
      (LDESC
"This is a tiny cave with entrances west and north, and a staircase
leading down.")
      (DESC "Cave")
      (NORTH TO MIRROR-ROOM-1)
      (DOWN TO ATLANTIS-ROOM)
      (SOUTH TO ATLANTIS-ROOM)
      (WEST TO TWISTING-PASSAGE)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM TINY-CAVE
      (IN ROOMS)
      (LDESC
"This is a tiny cave with entrances west and north, and a dark,
forbidding staircase leading down.")
      (DESC "Cave")
      (NORTH TO MIRROR-ROOM-2)
      (WEST TO WINDING-PASSAGE)
      (DOWN TO ENTRANCE-TO-HADES)
      (ACTION CAVE2-ROOM)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM COLD-PASSAGE
      (IN ROOMS)
      (LDESC
"This is a cold and damp corridor where a long east-west passageway
turns into a southward path.")
      (DESC "Cold Passage")
      (SOUTH TO MIRROR-ROOM-1)
      (WEST TO SLIDE-ROOM)
      (FLAGS RLANDBIT)>

<ROOM NARROW-PASSAGE
      (IN ROOMS)
      (LDESC
"This is a long and narrow corridor where a long north-south passageway
briefly narrows even further.")
      (DESC "Narrow Passage")
      (NORTH TO ROUND-ROOM)
      (SOUTH TO MIRROR-ROOM-2)
      (FLAGS RLANDBIT)>

<ROOM WINDING-PASSAGE
      (IN ROOMS)
      (LDESC
"This is a winding passage. It seems that there are only exits
on the east and north.")
      (DESC "Winding Passage")
      (NORTH TO MIRROR-ROOM-2)
      (EAST TO TINY-CAVE)
      (FLAGS RLANDBIT)>

<ROOM TWISTING-PASSAGE
      (IN ROOMS)
      (LDESC
"This is a winding passage. It seems that there are only exits
on the east and north.")
      (DESC "Twisting Passage")
      (NORTH TO MIRROR-ROOM-1)
      (EAST TO SMALL-CAVE)
      (FLAGS RLANDBIT)>

<ROOM ATLANTIS-ROOM
      (IN ROOMS)
      (LDESC
"This is an ancient room, long under water. There is an exit to
the south and a staircase leading up.")
      (DESC "Atlantis Room")
      (UP TO SMALL-CAVE)
      (SOUTH TO RESERVOIR-NORTH)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

\

"SUBTITLE ROUND ROOM AND VICINITY"

<ROOM EW-PASSAGE
      (IN ROOMS)
      (LDESC
"This is a narrow east-west passageway. There is a narrow stairway
leading down at the north end of the room.")
      (DESC "East-West Passage")
      (EAST TO ROUND-ROOM)
      (WEST TO TROLL-ROOM)
      (DOWN TO CHASM-ROOM)
      (NORTH TO CHASM-ROOM)
      (FLAGS RLANDBIT)
      (VALUE 5)
      (GLOBAL STAIRS)>

<ROOM ROUND-ROOM
      (IN ROOMS)
      (LDESC
"This is a circular stone room with passages in all directions. Several
of them have unfortunately been blocked by cave-ins.")
      (DESC "Round Room")
      (EAST TO LOUD-ROOM)
      (WEST TO EW-PASSAGE)
      (NORTH TO NS-PASSAGE)
      (SOUTH TO NARROW-PASSAGE)
      (SE TO ENGRAVINGS-CAVE)
      (FLAGS RLANDBIT)>

<ROOM DEEP-CANYON
      (IN ROOMS)
      (DESC "Deep Canyon")
      (NW TO RESERVOIR-SOUTH) ;COFFIN-CURE
      (EAST TO DAM-ROOM)
      (SW TO NS-PASSAGE)
      (DOWN TO LOUD-ROOM)
      (FLAGS RLANDBIT)
      (ACTION DEEP-CANYON-F)
      (GLOBAL STAIRS)>

<ROOM DAMP-CAVE
      (IN ROOMS)
      (LDESC
"This cave has exits to the west and east, and narrows to a crack toward
the south. The earth is particularly damp here.")
      (DESC "Damp Cave")
      (WEST TO LOUD-ROOM)
      (EAST TO WHITE-CLIFFS-NORTH)
      (SOUTH "It is too narrow for most insects.")
      (FLAGS RLANDBIT)
      (GLOBAL CRACK)>

<ROOM LOUD-ROOM
      (IN ROOMS)
      (DESC "Loud Room")
      (EAST TO DAMP-CAVE)
      (WEST TO ROUND-ROOM)
      (UP TO DEEP-CANYON)
      (ACTION LOUD-ROOM-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM NS-PASSAGE
      (IN ROOMS)
      (LDESC
"This is a high north-south passage, which forks to the northeast.")
      (DESC "North-South Passage")
      (NORTH TO CHASM-ROOM)
      (NE TO DEEP-CANYON)
      (SOUTH TO ROUND-ROOM)
      (FLAGS RLANDBIT)>

<ROOM CHASM-ROOM
      (IN ROOMS)
      (LDESC
"A chasm runs southwest to northeast and the path follows it. You are
on the south side of the chasm, where a crack opens into a passage.")
      (DESC "Chasm")
      (NE TO RESERVOIR-SOUTH)
      (SW TO EW-PASSAGE)
      (UP TO EW-PASSAGE)
      (SOUTH TO NS-PASSAGE)
      (DOWN "Are you out of your mind?")
      (FLAGS RLANDBIT)
      (GLOBAL CRACK STAIRS)
      (PSEUDO "CHASM" CHASM-PSEUDO)>

\

"SUBTITLE HADES ET AL"

<ROOM ENTRANCE-TO-HADES
      (IN ROOMS)
      (DESC "Entrance to Hades")
      (UP TO TINY-CAVE)
      (IN TO LAND-OF-LIVING-DEAD IF LLD-FLAG
       ELSE "Some invisible force prevents you from passing through the gate.")
      (SOUTH TO LAND-OF-LIVING-DEAD IF LLD-FLAG
       ELSE "Some invisible force prevents you from passing through the gate.")
      (ACTION LLD-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BODIES)
      (PSEUDO "GATE" GATE-PSEUDO "GATES" GATE-PSEUDO)>

<ROOM LAND-OF-LIVING-DEAD
      (IN ROOMS)
      (LDESC
"You have entered the Land of the Living Dead. Thousands of lost souls
can be heard weeping and moaning. In the corner are stacked the remains
of dozens of previous adventurers less fortunate than yourself.
A passage exits to the north.")
      (DESC "Land of the Dead")
      (OUT TO ENTRANCE-TO-HADES)
      (NORTH TO ENTRANCE-TO-HADES)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BODIES)>

\

"SUBTITLE DOME, TEMPLE, EGYPT"

<ROOM ENGRAVINGS-CAVE	;"was CAVE4"
      (IN ROOMS)
      (LDESC
"You have entered a low cave with passages leading northwest and east.")
      (DESC "Engravings Cave")
      (NW TO ROUND-ROOM)
      (EAST TO DOME-ROOM)
      (FLAGS RLANDBIT)>

<ROOM EGYPT-ROOM	;"was EGYPT"
      (IN ROOMS)
      (LDESC
"This is a room which looks like an Egyptian tomb. There is an
ascending staircase to the west.")
      (DESC "Egyptian Room")
      (WEST TO NORTH-TEMPLE)
      (UP TO NORTH-TEMPLE)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM DOME-ROOM	;"was DOME"
      (IN ROOMS)
      (DESC "Dome Room")
      (WEST TO ENGRAVINGS-CAVE)
      (DOWN TO TORCH-ROOM
       IF DOME-FLAG ELSE "You cannot go down without fracturing many bones.")
      (ACTION DOME-ROOM-FCN)
      (FLAGS RLANDBIT)
      (PSEUDO "DOME" DOME-PSEUDO)>

<ROOM TORCH-ROOM
      (IN ROOMS)
      (DESC "Torch Room")
      (UP "You cannot reach the rope.")
      (SOUTH TO NORTH-TEMPLE)
      (DOWN TO NORTH-TEMPLE)
      (ACTION TORCH-ROOM-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "DOME" DOME-PSEUDO)>

<ROOM NORTH-TEMPLE	;"was TEMP1"
      (IN ROOMS)
      (LDESC
"This is the north end of a large temple. On the east wall is an
ancient inscription, probably a prayer in a long-forgotten language.
Below the prayer is a staircase leading down. The west wall is solid
granite. The exit to the north end of the room is through huge
marble pillars.")
      (DESC "Temple")
      (DOWN TO EGYPT-ROOM)
      (EAST TO EGYPT-ROOM)
      (NORTH TO TORCH-ROOM)
      (OUT TO TORCH-ROOM)
      (UP TO TORCH-ROOM)
      (SOUTH TO SOUTH-TEMPLE)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL STAIRS)>

<ROOM SOUTH-TEMPLE	;"was TEMP2"
      (IN ROOMS)
      (LDESC

"This is the south end of a large temple. In front of you is what
appears to be an altar. In one corner is a small hole in the floor
which leads into darkness. You probably could not get back up it.")
      (DESC "Altar")
      (NORTH TO NORTH-TEMPLE)
      (DOWN TO TINY-CAVE
       IF COFFIN-CURE
       ELSE "You haven't a prayer of getting the coffin down there.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (ACTION SOUTH-TEMPLE-FCN)>

\

"SUBTITLE FLOOD CONTROL DAM #3"

<ROOM DAM-ROOM	;"was DAM"
      (IN ROOMS)
      (DESC "Dam")
      (SOUTH TO DEEP-CANYON)
      (DOWN TO DAM-BASE)
      (EAST TO DAM-BASE)
      (NORTH TO DAM-LOBBY)
      (WEST TO RESERVOIR-SOUTH)
      (ACTION DAM-ROOM-FCN)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-WATER)>

<ROOM DAM-LOBBY	;"was LOBBY"
      (IN ROOMS)
      (LDESC
"This room appears to have been the waiting room for groups touring
the dam. There are open doorways here to the north and east marked
\"Private\", and there is a path leading south over the top of the dam.")
      (DESC "Dam Lobby")
      (SOUTH TO DAM-ROOM)
      (NORTH TO MAINTENANCE-ROOM)
      (EAST TO MAINTENANCE-ROOM)
      (FLAGS RLANDBIT ONBIT)>

<ROOM MAINTENANCE-ROOM	;"was MAINT"
      (IN ROOMS)
      (LDESC
"This is what appears to have been the maintenance room for Flood
Control Dam #3. Apparently, this room has been ransacked recently, for
most of the valuable equipment is gone. On the wall in front of you is a
group of buttons colored blue, yellow, brown, and red. There are doorways to
the west and south.")
      (DESC "Maintenance Room")
      (SOUTH TO DAM-LOBBY)
      (WEST TO DAM-LOBBY)
      (FLAGS RLANDBIT)>

\

"SUBTITLE RIVER AREA"

<ROOM DAM-BASE	;"was DOCK"
      (IN ROOMS)
      (LDESC
"You are at the base of Flood Control Dam #3, which looms above you
and to the north. The river Frigid is flowing by here. Along the
river are the White Cliffs which seem to form giant walls stretching
from north to south along the shores of the river as it winds its
way downstream.")
      (DESC "Dam Base")
      (NORTH TO DAM-ROOM)
      (UP TO DAM-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM RIVER-1	;"was RIVR1"
      (IN ROOMS)
      (LDESC
"You are on the Frigid River in the vicinity of the Dam. The river
flows quietly here. There is a landing on the west shore.")
      (DESC "Frigid River")
      (UP "You cannot go upstream due to strong currents.")
      (WEST TO DAM-BASE)
      (LAND TO DAM-BASE)
      (DOWN TO RIVER-2)
      (EAST "The White Cliffs prevent your landing here.")
      (FLAGS NONLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM RIVER-2	;"was RIVR2"
      (IN ROOMS)
      (LDESC
"The river turns a corner here making it impossible to see the
Dam. The White Cliffs loom on the east bank and large rocks prevent
landing on the west.")
      (DESC "Frigid River")
      (UP "You cannot go upstream due to strong currents.")
      (DOWN TO RIVER-3)
      (LAND "There is no safe landing spot here.")
      (EAST "The White Cliffs prevent your landing here.")
      (WEST "Just in time you steer away from the rocks.")
      (FLAGS NONLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM RIVER-3	;"was RIVR3"
      (IN ROOMS)
      (LDESC
"The river descends here into a valley. There is a narrow beach on the
west shore below the cliffs. In the distance a faint rumbling can be
heard.")
      (DESC "Frigid River")
      (UP "You cannot go upstream due to strong currents.")
      (DOWN TO RIVER-4)
      (LAND TO WHITE-CLIFFS-NORTH)
      (WEST TO WHITE-CLIFFS-NORTH)
      (FLAGS NONLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM WHITE-CLIFFS-NORTH	;"was WCLF1"
      (IN ROOMS)
      (LDESC
"You are on a narrow strip of beach which runs along the base of the
White Cliffs. There is a narrow path heading south along the Cliffs
and a tight passage leading west into the cliffs themselves.")
      (DESC "White Cliffs Beach")
      (SOUTH TO WHITE-CLIFFS-SOUTH IF DEFLATE ELSE "The path is too narrow.")
      (WEST TO DAMP-CAVE IF DEFLATE ELSE "The path is too narrow.")
      (ACTION WHITE-CLIFFS-FUNCTION)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER WHITE-CLIFF RIVER)>

<ROOM WHITE-CLIFFS-SOUTH	;"was WCLF2"
      (IN ROOMS)
      (LDESC
"You are on a rocky, narrow strip of beach beside the Cliffs. A
narrow path leads north along the shore.")
      (DESC "White Cliffs Beach")
      (NORTH TO WHITE-CLIFFS-NORTH
       IF DEFLATE ELSE "The path is too narrow.")
      (ACTION WHITE-CLIFFS-FUNCTION)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER WHITE-CLIFF RIVER)>

<ROOM RIVER-4	;"was RIVR4"
      (IN ROOMS)
      (LDESC
"The river is running faster here and the sound ahead appears to be
that of rushing water. On the east shore is a sandy beach. A small
area of beach can also be seen below the cliffs on the west shore.")
      (DESC "Frigid River")
      (UP "You cannot go upstream due to strong currents.")
      (DOWN TO RIVER-5)
      (LAND "You can land either to the east or the west.")
      (WEST TO WHITE-CLIFFS-SOUTH)
      (EAST TO SANDY-BEACH)
      (ACTION RIVR4-ROOM)
      (FLAGS NONLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM RIVER-5	;"was RIVR5"
      (IN ROOMS)
      (LDESC
"The sound of rushing water is nearly unbearable here. On the east
shore is a large landing area.")
      (DESC "Frigid River")
      (UP "You cannot go upstream due to strong currents.")
      (EAST TO SHORE)
      (LAND TO SHORE)
      (FLAGS NONLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM SHORE	;"was FANTE"
      (IN ROOMS)
      (LDESC
"You are on the east shore of the river. The water here seems somewhat
treacherous. A path travels from north to south here, the south end
quickly turning around a sharp corner.")
      (DESC "Shore")
      (NORTH TO SANDY-BEACH)
      (SOUTH TO ARAGAIN-FALLS)
      (FLAGS RLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM SANDY-BEACH	;"was BEACH"
      (IN ROOMS)
      (LDESC

"You are on a large sandy beach on the east shore of the river, which is
flowing quickly by. A path runs beside the river to the south here, and
a passage is partially buried in sand to the northeast.")
      (DESC "Sandy Beach")
      (NE TO SANDY-CAVE)
      (SOUTH TO SHORE)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER RIVER)>

<ROOM SANDY-CAVE	;"was TCAVE"
      (IN ROOMS)
      (LDESC
"This is a sand-filled cave whose exit is to the southwest.")
      (DESC "Sandy Cave")
      (SW TO SANDY-BEACH)
      (FLAGS RLANDBIT)>

<ROOM ARAGAIN-FALLS	;"was FALLS"
      (IN ROOMS)
      (DESC "Aragain Falls")
      (WEST TO ON-RAINBOW IF RAINBOW-FLAG)
      (DOWN "It's a long way...")
      (NORTH TO SHORE)
      (UP TO ON-RAINBOW IF RAINBOW-FLAG)
      (ACTION FALLS-ROOM)
      (FLAGS RLANDBIT SACREDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RIVER RAINBOW)>

<ROOM ON-RAINBOW	;"was RAINB"
      (IN ROOMS)
      (LDESC
"You are on top of a rainbow (I bet you never thought you would walk
on a rainbow), with a magnificent view of the Falls. The rainbow
travels east-west here.")
      (DESC "On the Rainbow")
      (WEST TO END-OF-RAINBOW)
      (EAST TO ARAGAIN-FALLS)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL RAINBOW)>

<ROOM END-OF-RAINBOW	;"was POG"
      (IN ROOMS)
      (LDESC
"You are on a small, rocky beach on the continuation of the Frigid
River past the Falls. The beach is narrow due to the presence of the
White Cliffs. The river canyon opens here and sunlight shines in
from above. A rainbow crosses over the falls to the east and a narrow
path continues to the southwest.")
      (DESC "End of Rainbow")
      (UP TO ON-RAINBOW IF RAINBOW-FLAG)
      (NE TO ON-RAINBOW IF RAINBOW-FLAG)
      (EAST TO ON-RAINBOW IF RAINBOW-FLAG)
      (SW TO CANYON-BOTTOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL GLOBAL-WATER RAINBOW RIVER)>

<ROOM CANYON-BOTTOM	;"was CLBOT"
      (IN ROOMS)
      (LDESC
"You are beneath the walls of the river canyon which may be climbable
here. The lesser part of the runoff of Aragain Falls flows by below.
To the north is a narrow path.")
      (DESC "Canyon Bottom")
      (UP TO CLIFF-MIDDLE)
      (NORTH TO END-OF-RAINBOW)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL GLOBAL-WATER CLIMBABLE-CLIFF RIVER)>

<ROOM CLIFF-MIDDLE	;"was CLMID"
      (IN ROOMS)
      (LDESC
"You are on a ledge about halfway up the wall of the river canyon.
You can see from here that the main flow from Aragain Falls twists
along a passage which it is impossible for you to enter. Below you is the
canyon bottom. Above you is more cliff, which appears
climbable.")
      (DESC "Rocky Ledge")
      (UP TO CANYON-VIEW)
      (DOWN TO CANYON-BOTTOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL CLIMBABLE-CLIFF RIVER)>

<ROOM CANYON-VIEW	;"was CLTOP"
      (IN ROOMS)
      (LDESC
"You are at the top of the Great Canyon on its west wall. From here
there is a marvelous view of the canyon and parts of the Frigid River
upstream. Across the canyon, the walls of the White Cliffs join the
mighty ramparts of the Flathead Mountains to the east. Following the
Canyon upstream to the north, Aragain Falls may be seen, complete with
rainbow. The mighty Frigid River flows out from a great dark cavern. To
the west and south can be seen an immense forest, stretching for miles
around. A path leads northwest. It is possible to climb down into
the canyon from here.")
      (DESC "Canyon View")
      (EAST TO CLIFF-MIDDLE)
      (DOWN TO CLIFF-MIDDLE)
      (NW TO CLEARING)
      (WEST TO FOREST-3)
      (SOUTH "Storm-tossed trees block your way.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL CLIMBABLE-CLIFF RIVER RAINBOW)
      (ACTION CANYON-VIEW-F)>

<ROUTINE CANYON-VIEW-F (RARG)
	 <COND (<AND <==? .RARG ,M-BEG>
		     <VERB? LEAP>
		     <NOT ,PRSO>>
		<JIGS-UP "Nice view, lousy place to jump.">
		<RTRUE>)>>
	       

\

"SUBTITLE COAL MINE AREA"

<ROOM MINE-ENTRANCE	;"was ENTRA"
      (IN ROOMS)
      (LDESC

"You are standing at the entrance of what might have been a coal mine.
The shaft enters the west wall, and there is another exit on the south
end of the room.")
      (DESC "Mine Entrance")
      (SOUTH TO SLIDE-ROOM)
      (IN TO SQUEEKY-ROOM)
      (WEST TO SQUEEKY-ROOM)
      (FLAGS RLANDBIT)>

<ROOM SQUEEKY-ROOM	;"was SQUEE"
      (IN ROOMS)
      (LDESC
"You are in a small room. Strange squeaky sounds may be heard coming
from the passage at the north end. You may also escape to the east.")
      (DESC "Squeaky Room")
      (NORTH TO BAT-ROOM)
      (EAST TO MINE-ENTRANCE)
      (FLAGS RLANDBIT)>

<ROOM BAT-ROOM	;"was BATS"
      (IN ROOMS)
      (DESC "Bat Room")
      (SOUTH TO SQUEEKY-ROOM)
      (EAST TO SHAFT-ROOM)
      (ACTION BATS-ROOM)
      (FLAGS RLANDBIT SACREDBIT)>

<ROOM SHAFT-ROOM	;"was TSHAF"
      (IN ROOMS)
      (LDESC
"This is a large room, in the middle of which is a small shaft
descending through the floor into darkness below. To the west and
the north are exits from this room. Constructed over the top of the
shaft is a metal framework to which a heavy iron chain is attached.")
      (DESC "Shaft Room")
      (DOWN "You wouldn't fit and would die if you could.")
      (WEST TO BAT-ROOM)
      (NORTH TO SMELLY-ROOM)
      (FLAGS RLANDBIT)
      (PSEUDO "CHAIN" CHAIN-PSEUDO)>

<ROOM SMELLY-ROOM	;"was SMELL"
      (IN ROOMS)
      (LDESC
"This is a small nondescript room. However, from the direction
of a small descending staircase a foul odor can be detected. To the
south is a narrow tunnel.")
      (DESC "Smelly Room")
      (DOWN TO GAS-ROOM)
      (SOUTH TO SHAFT-ROOM)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "ODOR" GAS-PSEUDO "GAS" GAS-PSEUDO)>

<ROOM GAS-ROOM	;"was BOOM"
      (IN ROOMS)
      (LDESC
"This is a small room which smells strongly of coal gas. There is a
short climb up some stairs and a narrow tunnel leading east.")
      (DESC "Gas Room")
      (UP TO SMELLY-ROOM)
      (EAST TO MINE-1)
      (ACTION BOOM-ROOM)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "GAS" GAS-PSEUDO "ODOR" GAS-PSEUDO)>

<ROOM LADDER-TOP	;"was TLADD"
      (IN ROOMS)
      (LDESC
"This is a very small room. In the corner is a rickety wooden
ladder, leading downward. It might be safe to descend. There is
also a staircase leading upward.")
      (DESC "Ladder Top")
      (DOWN TO LADDER-BOTTOM)
      (UP TO MINE-4)
      (FLAGS RLANDBIT)
      (GLOBAL LADDER STAIRS)>

<ROOM LADDER-BOTTOM	;"was BLADD"
      (IN ROOMS)
      (LDESC
"This is a rather wide room. On one side is the bottom of a
narrow wooden ladder. To the west and the south are passages
leaving the room.")
      (DESC "Ladder Bottom")
      (SOUTH TO DEAD-END-5)
      (WEST TO TIMBER-ROOM)
      (UP TO LADDER-TOP)
      (FLAGS RLANDBIT)
      (GLOBAL LADDER)>

<ROOM DEAD-END-5	;"was DEAD7"
      (IN ROOMS)
      (DESC "Dead End")
      (LDESC "You have come to a dead end in the mine.")
      (NORTH TO LADDER-BOTTOM)
      (FLAGS RLANDBIT)>

<ROOM TIMBER-ROOM	;"was TIMBE"
      (IN ROOMS)
      (LDESC
"This is a long and narrow passage, which is cluttered with broken
timbers. A wide passage comes from the east and turns at the
west end of the room into a very narrow passageway. From the west
comes a strong draft.")
      (DESC "Timber Room")
      (EAST TO LADDER-BOTTOM)
      (WEST TO LOWER-SHAFT
       IF EMPTY-HANDED
       ELSE "You cannot fit through this passage with that load.")
      (ACTION NO-OBJS)
      (FLAGS RLANDBIT SACREDBIT)>

<ROOM LOWER-SHAFT	;"was BSHAF"
      (IN ROOMS)
      (LDESC
"This is a small drafty room in which is the bottom of a long
shaft. To the south is a passageway and to the east a very narrow
passage. In the shaft can be seen a heavy iron chain.")
      (DESC "Drafty Room")
      (SOUTH TO MACHINE-ROOM)
      (OUT TO TIMBER-ROOM
       IF EMPTY-HANDED
       ELSE "You cannot fit through this passage with that load.")
      (EAST TO TIMBER-ROOM
       IF EMPTY-HANDED
       ELSE "You cannot fit through this passage with that load.")
      (ACTION NO-OBJS)
      (FLAGS RLANDBIT SACREDBIT)
      (PSEUDO "CHAIN" CHAIN-PSEUDO)>

<ROOM MACHINE-ROOM	;"was MACHI"
      (IN ROOMS)
      (DESC "Machine Room")
      (NORTH TO LOWER-SHAFT)
      (ACTION MACHINE-ROOM-FCN)
      (FLAGS RLANDBIT)>

\

"SUBTITLE COAL MINE"

<ROOM MINE-1	;"was MINE1"
      (IN ROOMS)
      (LDESC "This is a nondescript part of a coal mine.")
      (DESC "Coal Mine")
      (NORTH TO GAS-ROOM)
      (EAST TO MINE-1)
      (NE TO MINE-2)
      (FLAGS RLANDBIT)>

<ROOM MINE-2	;"was MINE2"
      (IN ROOMS)
      (LDESC "This is a nondescript part of a coal mine.")
      (DESC "Coal Mine")
      (NORTH TO MINE-2)
      (SOUTH TO MINE-1)
      (SE TO MINE-3)
      (FLAGS RLANDBIT)>

<ROOM MINE-3	;"was MINE3"
      (IN ROOMS)
      (LDESC "This is a nondescript part of a coal mine.")
      (DESC "Coal Mine")
      (SOUTH TO MINE-3)
      (SW TO MINE-4)
      (EAST TO MINE-2)
      (FLAGS RLANDBIT)>

<ROOM MINE-4	;"was MINE4"
      (IN ROOMS)
      (LDESC "This is a nondescript part of a coal mine.")
      (DESC "Coal Mine")
      (NORTH TO MINE-3)
      (WEST TO MINE-4)
      (DOWN TO LADDER-TOP)
      (FLAGS RLANDBIT)>

<ROOM SLIDE-ROOM	;"was SLIDE"
      (IN ROOMS)
      (LDESC
"This is a small chamber, which appears to have been part of a
coal mine. On the south wall of the chamber the letters \"Granite
Wall\" are etched in the rock. To the east is a long passage, and
there is a steep metal slide twisting downward. To the north is
a small opening.")
      (DESC "Slide Room")
      (EAST TO COLD-PASSAGE)
      (NORTH TO MINE-ENTRANCE)
      (DOWN TO CELLAR)
      (FLAGS RLANDBIT)
      (GLOBAL SLIDE)>

\

;"RANDOM TABLES FOR WALK-AROUND"

<GLOBAL HOUSE-AROUND
  <LTABLE (PURE) WEST-OF-HOUSE NORTH-OF-HOUSE EAST-OF-HOUSE SOUTH-OF-HOUSE
	  WEST-OF-HOUSE>>

<GLOBAL FOREST-AROUND
  <LTABLE (PURE) FOREST-1 FOREST-2 FOREST-3 PATH CLEARING FOREST-1>>

<GLOBAL IN-HOUSE-AROUND
  <LTABLE (PURE) LIVING-ROOM KITCHEN ATTIC KITCHEN>>

<GLOBAL ABOVE-GROUND
  <LTABLE (PURE) WEST-OF-HOUSE NORTH-OF-HOUSE EAST-OF-HOUSE SOUTH-OF-HOUSE
	  FOREST-1 FOREST-2 FOREST-3 PATH CLEARING GRATING-CLEARING
	  CANYON-VIEW>>

;"The GO routine must live here."

<ROUTINE GO ()
	<ENABLE <QUEUE I-FIGHT -1>>
	<QUEUE I-SWORD -1>
	<ENABLE <QUEUE I-THIEF -1>>
	<QUEUE I-CANDLES 40>
	<QUEUE I-LANTERN 200>
	<PUTP ,INFLATED-BOAT ,P?VTYPE ,NONLANDBIT>
	<PUT ,DEF1-RES 1 <REST ,DEF1 2>>
	<PUT ,DEF1-RES 2 <REST ,DEF1 4>>
	<PUT ,DEF2-RES 2 <REST ,DEF2B 2>>
	<PUT ,DEF2-RES 3 <REST ,DEF2B 4>>
	<PUT ,DEF3-RES 1 <REST ,DEF3A 2>>
	<PUT ,DEF3-RES 3 <REST ,DEF3B 2>>
	<SETG HERE ,WEST-OF-HOUSE>
	<THIS-IS-IT ,MAILBOX>
	<COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
	       <V-VERSION>
	       <CRLF>)>
	<SETG LIT T>
	<SETG WINNER ,ADVENTURER>
	<SETG PLAYER ,WINNER>
	<MOVE ,WINNER ,HERE>
	<V-LOOK>
	<MAIN-LOOP>
	<AGAIN>>
	
;-------------------------------------------------------
"ACTIONS"
;-------------------------------------------------------
"1ACTIONS for
	        Zork I: The Great Underground Empire
	(c) Copyright 1983 Infocom, Inc. All Rights Reserved."

"SUBTITLE THE WHITE HOUSE"

<ROUTINE WEST-HOUSE (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are standing in an open field west of a white house, with a boarded
front door.">
		<COND (,WON-FLAG
		       <TELL
" A secret path leads southwest into the forest.">)>
		<CRLF>)>>

<ROUTINE EAST-HOUSE (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are behind the white house. A path leads into the forest
to the east. In one corner of the house there is a small window
which is ">
		<COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>
		       <TELL "open.">)
		      (T <TELL "slightly ajar.">)>
		<CRLF>)>>

<ROUTINE OPEN-CLOSE (OBJ STROPN STRCLS)
	 <COND (<VERB? OPEN>
		<COND (<FSET? .OBJ ,OPENBIT>
		       <TELL <PICK-ONE ,DUMMY>>)
		      (T
		       <TELL .STROPN>
		       <FSET .OBJ ,OPENBIT>)>
		<CRLF>)
	       (<VERB? CLOSE>
		<COND (<FSET? .OBJ ,OPENBIT>
		       <TELL .STRCLS>
		       <FCLEAR .OBJ ,OPENBIT>
		       T)
		      (T <TELL <PICK-ONE ,DUMMY>>)>
		<CRLF>)>>

<ROUTINE BOARD-F ()
	 <COND (<VERB? TAKE EXAMINE>
		<TELL "The boards are securely fastened." CR>)>>

<ROUTINE TEETH-F ()
	 <COND (<AND <VERB? BRUSH>
		     <EQUAL? ,PRSO ,TEETH>>
		<COND (<AND <EQUAL? ,PRSI ,PUTTY>
			    <IN? ,PRSI ,WINNER>>
		       <JIGS-UP
"Well, you seem to have been brushing your teeth with some sort of
glue. As a result, your mouth gets glued together (with your nose)
and you die of respiratory failure.">)
		      (<NOT ,PRSI>
		       <TELL
"Dental hygiene is highly recommended, but I'm not sure what you want
to brush them with." CR>)
		      (T
		       <TELL "A nice idea, but with a " D ,PRSI "?" CR>)>)>>

<ROUTINE GRANITE-WALL-F ()
	 <COND (<EQUAL? ,HERE ,NORTH-TEMPLE>
		<COND (<VERB? FIND>
		       <TELL "The west wall is solid granite here." CR>)
		      (<VERB? TAKE RAISE LOWER>
		       <TELL "It's solid granite." CR>)>)
	       (<EQUAL? ,HERE ,TREASURE-ROOM>
		<COND (<VERB? FIND>
		       <TELL "The east wall is solid granite here." CR>)
		      (<VERB? TAKE RAISE LOWER>
		       <TELL "It's solid granite." CR>)>)
	       (<EQUAL? ,HERE ,SLIDE-ROOM>
		<COND (<VERB? FIND READ>
		       <TELL "It only SAYS \"Granite Wall\"." CR>)
		      (T <TELL "The wall isn't granite." CR>)>)
	       (T
		<TELL "There is no granite wall here." CR>)>>

<ROUTINE SONGBIRD-F ()
	 <COND (<VERB? FIND TAKE>
		<TELL "The songbird is not here but is probably nearby." CR>)
	       (<VERB? LISTEN>
		<TELL "You can't hear the songbird now." CR>)
	       (<VERB? FOLLOW>
		<TELL "It can't be followed." CR>)
	       (T
		<TELL "You can't see any songbird here." CR>)>>

<ROUTINE WHITE-HOUSE-F ()
    <COND (<EQUAL? ,HERE ,KITCHEN ,LIVING-ROOM ,ATTIC>
	   <COND (<VERB? FIND>
		  <TELL "Why not find your brains?" CR>)
		 (<VERB? WALK-AROUND>
		  <GO-NEXT ,IN-HOUSE-AROUND>
		  T)>)
	  (<NOT <OR <EQUAL? ,HERE ,EAST-OF-HOUSE ,WEST-OF-HOUSE>
		    <EQUAL? ,HERE ,NORTH-OF-HOUSE ,SOUTH-OF-HOUSE>>>
	   <COND (<VERB? FIND>
		  <COND (<EQUAL? ,HERE ,CLEARING>
			 <TELL "It seems to be to the west." CR>)
			(T
			 <TELL "It was here just a minute ago...." CR>)>)
		 (T <TELL "You're not at the house." CR>)>)
	  (<VERB? FIND>
	   <TELL
"It's right here! Are you blind or something?" CR>)
	  (<VERB? WALK-AROUND>
	   <GO-NEXT ,HOUSE-AROUND>
	   T)
	  (<VERB? EXAMINE>
	   <TELL
"The house is a beautiful colonial house which is painted white.
It is clear that the owners must have been extremely wealthy." CR>)
	  (<VERB? THROUGH OPEN>
	   <COND (<EQUAL? ,HERE ,EAST-OF-HOUSE>
		  <COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>
			 <GOTO ,KITCHEN>)
			(T
			 <TELL "The window is closed." CR>
			 <THIS-IS-IT ,KITCHEN-WINDOW>)>)
		 (T
		  <TELL "I can't see how to get in from here." CR>)>)
	  (<VERB? BURN>
	   <TELL "You must be joking." CR>)>>

;"0 -> no next, 1 -> success, 2 -> failed move"

<ROUTINE GO-NEXT (TBL "AUX" VAL)
	 <COND (<SET VAL <LKP ,HERE .TBL>>
		<COND (<NOT <GOTO .VAL>> 2)
		      (T 1)>)>>

<ROUTINE FOREST-F ()
	 <COND (<VERB? WALK-AROUND>
		<COND (<OR <EQUAL? ,HERE
			       ,WEST-OF-HOUSE ,NORTH-OF-HOUSE
			       ,SOUTH-OF-HOUSE>
			   <EQUAL? ,HERE ,EAST-OF-HOUSE>>
		       <TELL "You aren't even in the forest." CR>)>
		<GO-NEXT ,FOREST-AROUND>)
	       (<VERB? DISEMBARK>
		<TELL "You will have to specify a direction." CR>)
	       (<VERB? FIND>
		<TELL "You cannot see the forest for the trees." CR>)
	       (<VERB? LISTEN>
		<TELL "The pines and the hemlocks seem to be murmuring."
		      CR>)>>

<ROUTINE MOUNTAIN-RANGE-F ()
	 <COND (<VERB? CLIMB-UP CLIMB-DOWN CLIMB-FOO>
		<TELL "Don't you believe me? The mountains are impassable!"
		      CR>)>>

<ROUTINE WATER-F ("AUX" AV W PI?)
	 <COND (<VERB? SGIVE> <RFALSE>)
	       (<VERB? THROUGH BOARD>
		<TELL <PICK-ONE ,SWIMYUKS> CR>
		<RTRUE>)
	       (<VERB? FILL>	;"fill bottle with water =>"
		<SET W ,PRSI>	   ;"put water in bottle"
		<SETG PRSA ,V?PUT>
		<SETG PRSI ,PRSO>
		<SETG PRSO .W>
		<SET PI? <>>)
	       (<OR <EQUAL? ,PRSO ,GLOBAL-WATER>
		    <EQUAL? ,PRSO ,WATER>>
		<SET W ,PRSO>
		<SET PI? <>>)
	       (ELSE
		<SET W ,PRSI>
		<COND (.W <SET PI? T>)>)>
	 <COND (<EQUAL? .W ,GLOBAL-WATER>
		<SET W ,WATER>
		<COND (<VERB? TAKE PUT> <REMOVE-CAREFULLY .W>)>)>
	 <COND (.PI? <SETG PRSI .W>)
	       (T <SETG PRSO .W>)>
	 <SET AV <LOC ,WINNER>>
	 <COND (<NOT <FSET? .AV ,VEHBIT>> <SET AV <>>)>
	 <COND (<AND <VERB? TAKE PUT> <NOT .PI?>>
		<COND (<AND .AV
			    <OR <EQUAL? .AV ,PRSI>
				<AND <NOT ,PRSI>
				     <NOT <IN? .W .AV>>>>>
		       <TELL "There is now a puddle in the bottom of the "
			     D .AV "." CR>
		       <REMOVE-CAREFULLY ,PRSO>
		       <MOVE ,PRSO .AV>)
		      (<AND ,PRSI <NOT <EQUAL? ,PRSI ,BOTTLE>>>
		       <TELL "The water leaks out of the " D ,PRSI
			     " and evaporates immediately." CR>
		       <REMOVE-CAREFULLY .W>)
		      (<IN? ,BOTTLE ,WINNER>
		       <COND (<NOT <FSET? ,BOTTLE ,OPENBIT>>
			      <TELL "The bottle is closed." CR>
			      <THIS-IS-IT ,BOTTLE>)
			     (<NOT <FIRST? ,BOTTLE>>
			      <MOVE ,WATER ,BOTTLE>
			      <TELL "The bottle is now full of water." CR>)
			     (T
			      <TELL "The water slips through your fingers." CR>
			      <RTRUE>)>)
		      (<AND <IN? ,PRSO ,BOTTLE>
			    <VERB? TAKE>
			    <NOT ,PRSI>>
		       <TELL
"It's in the bottle. Perhaps you should take that instead." CR>)
		      (T
		       <TELL "The water slips through your fingers." CR>)>)
	       (.PI?
		<COND (<AND <VERB? PUT>
			    <GLOBAL-IN? ,RIVER ,HERE>>
		       <PERFORM ,V?PUT ,PRSO ,RIVER>)
		      (ELSE
		       <TELL "Nice try." CR>)>
		<RTRUE>)
	       (<VERB? DROP GIVE>
		<COND (<AND <VERB? DROP>
			    <IN? ,WATER ,BOTTLE>
			    <NOT <FSET? ,BOTTLE ,OPENBIT>>>
		       <TELL "The bottle is closed." CR>
		       <RTRUE>)>
		<REMOVE-CAREFULLY ,WATER>
		<COND (.AV
		       <TELL "There is now a puddle in the bottom of the "
			     D .AV "." CR>
		       <MOVE ,WATER .AV>)
		      (T
		       <TELL
"The water spills to the floor and evaporates immediately." CR>
		       <REMOVE-CAREFULLY ,WATER>)>)
	       (<VERB? THROW>
		<TELL
"The water splashes on the walls and evaporates immediately." CR>
		<REMOVE-CAREFULLY ,WATER>)>>

<GLOBAL KITCHEN-WINDOW-FLAG <>>

<ROUTINE KITCHEN-WINDOW-F ()
	 <COND (<VERB? OPEN CLOSE>
		<SETG KITCHEN-WINDOW-FLAG T>
		<OPEN-CLOSE ,KITCHEN-WINDOW
"With great effort, you open the window far enough to allow entry."
"The window closes (more easily than it opened).">)
	       (<AND <VERB? EXAMINE>
		     <NOT ,KITCHEN-WINDOW-FLAG>>
		<TELL
"The window is slightly ajar, but not enough to allow entry." CR>)
	       (<VERB? WALK BOARD THROUGH>
		<COND (<EQUAL? ,HERE ,KITCHEN>
		       <DO-WALK ,P?EAST>)
		      (T
		       <DO-WALK ,P?WEST>)>
		<RTRUE>)
	       (<VERB? LOOK-INSIDE>
		<TELL "You can see ">
		<COND (<EQUAL? ,HERE ,KITCHEN>
		       <TELL "a clear area leading towards a forest." CR>)
		      (T
		       <TELL "what appears to be a kitchen." CR>)>)>>

<ROUTINE GHOSTS-F ()
	 <COND (<VERB? TELL>
		<TELL "The spirits jeer loudly and ignore you." CR>
		<SETG P-CONT <>>)
	       (<VERB? EXORCISE>
		<TELL "Only the ceremony itself has any effect." CR>)
	       (<AND <VERB? ATTACK MUNG> <EQUAL? ,PRSO ,GHOSTS>>
		<TELL "How can you attack a spirit with material objects?" CR>)
	       (T
		<TELL "You seem unable to interact with these spirits." CR>)>>

<GLOBAL CAGE-TOP T>

<ROUTINE BASKET-F ()
	 <COND (<VERB? RAISE>
		<COND (,CAGE-TOP
		       <TELL <PICK-ONE ,DUMMY> CR>)
		      (T
		       <MOVE ,RAISED-BASKET ,SHAFT-ROOM>
		       <MOVE ,LOWERED-BASKET ,LOWER-SHAFT>
		       <SETG CAGE-TOP T>
		       <THIS-IS-IT ,RAISED-BASKET>
		       <TELL
"The basket is raised to the top of the shaft." CR>)>)
	       (<VERB? LOWER>
		<COND (<NOT ,CAGE-TOP>
		       <TELL <PICK-ONE ,DUMMY> CR>)
		      (T
		       <MOVE ,RAISED-BASKET ,LOWER-SHAFT>
		       <MOVE ,LOWERED-BASKET ,SHAFT-ROOM>
		       <THIS-IS-IT ,LOWERED-BASKET>
		       <TELL
"The basket is lowered to the bottom of the shaft." CR>
		       <SETG CAGE-TOP <>>
		       <COND (<AND ,LIT <NOT <SETG LIT <LIT? ,HERE>>>>
			      <TELL "It is now pitch black." CR>)>
		       T)>)
	       (<OR <EQUAL? ,PRSO ,LOWERED-BASKET>
		    <EQUAL? ,PRSI ,LOWERED-BASKET>>
		<TELL "The basket is at the other end of the chain." CR>)
	       (<AND <VERB? TAKE>
		     <EQUAL? ,PRSO ,RAISED-BASKET ,LOWERED-BASKET>>
		<TELL "The cage is securely fastened to the iron chain." CR>)>>

<ROUTINE BAT-F ()
	 <COND (<VERB? TELL>
		<FWEEP 6>
		<SETG P-CONT <>>)
	       (<VERB? TAKE ATTACK MUNG>
		<COND (<EQUAL? <LOC ,GARLIC> ,WINNER ,HERE>
		       <TELL "You can't reach him; he's on the ceiling." CR>)
		      (T <FLY-ME>)>)>>

<ROUTINE FLY-ME ()
	 <FWEEP 4>
	 <TELL
"The bat grabs you by the scruff of your neck and lifts you away...." CR CR>
	 <GOTO <PICK-ONE ,BAT-DROPS> <>>
	 <COND (<NOT <EQUAL? ,HERE ,ENTRANCE-TO-HADES>>
		<V-FIRST-LOOK>)>
	 T>

<ROUTINE FWEEP (N)
	 <REPEAT ()
		 <COND (<L? <SET N <- .N 1>> 1> <RETURN>)
		       (T <TELL "    Fweep!" CR>)>>
	 <CRLF>>

<GLOBAL BAT-DROPS
      <LTABLE 0
	      MINE-1
	      MINE-2
	      MINE-3
	      MINE-4
	      LADDER-TOP
	      LADDER-BOTTOM
	      SQUEEKY-ROOM
	      MINE-ENTRANCE>>

<ROUTINE BELL-F ()
	 <COND (<VERB? RING>
		<COND (<AND <EQUAL? ,HERE ,LLD-ROOM>
			    <NOT ,LLD-FLAG>>
		       <RFALSE>)
		      (T
		       <TELL "Ding, dong." CR>)>)>>

<ROUTINE HOT-BELL-F ()
	 <COND (<VERB? TAKE>
		<TELL "The bell is very hot and cannot be taken." CR>)
	       (<OR <VERB? RUB> <AND <VERB? RING> ,PRSI>>
		<COND (<FSET? ,PRSI ,BURNBIT>
		       <TELL "The " D ,PRSI " burns and is consumed." CR>
		       <REMOVE-CAREFULLY ,PRSI>)
		      (<EQUAL? ,PRSI ,HANDS>
		       <TELL "The bell is too hot to touch." CR>)
		      (T
		       <TELL "The heat from the bell is too intense." CR>)>)
	       (<VERB? POUR-ON>
		<REMOVE-CAREFULLY ,PRSO>
		<TELL "The water cools the bell and is evaporated." CR>
		<QUEUE I-XBH 0>
		<I-XBH>)
	       (<VERB? RING>
		<TELL "The bell is too hot to reach." CR>)>>

<ROUTINE BOARDED-WINDOW-FCN ()
	 <COND (<VERB? OPEN>
		<TELL "The windows are boarded and can't be opened." CR>)
	       (<VERB? MUNG>
		<TELL "You can't break the windows open." CR>)>>

<ROUTINE NAILS-PSEUDO ()
	 <COND (<VERB? TAKE>
		<TELL
"The nails, deeply imbedded in the door, cannot be removed." CR>)>>

<ROUTINE CRACK-FCN ()
	 <COND (<VERB? THROUGH>
		<TELL "You can't fit through the crack." CR>)>>

<ROUTINE KITCHEN-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <TELL
"You are in the kitchen of the white house. A table seems to
have been used recently for the preparation of food. A passage
leads to the west and a dark staircase can be seen leading
upward. A dark chimney leads down and to the east is a small
window which is ">
	       <COND (<FSET? ,KITCHEN-WINDOW ,OPENBIT>
		      <TELL "open." CR>)
		     (T
		      <TELL "slightly ajar." CR>)>)
	      (<==? .RARG ,M-BEG>
	       <COND (<AND <VERB? CLIMB-UP> <EQUAL? ,PRSO ,STAIRS>>
		      <DO-WALK ,P?UP>)
		     (<AND <VERB? CLIMB-UP> <EQUAL? ,PRSO ,STAIRS>>
		      <TELL "There are no stairs leading down." CR>)>)>>

<ROUTINE STONE-BARROW-FCN (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     <OR <VERB? ENTER>
			 <AND <VERB? WALK>
			      <EQUAL? ,PRSO ,P?WEST ,P?IN>>
			 <AND <VERB? THROUGH>
			      <EQUAL? ,PRSO ,BARROW>>>>
		<TELL
"Inside the Barrow|
As you enter the barrow, the door closes inexorably behind you. Around
you it is dark, but ahead is an enormous cavern, brightly lit. Through
its center runs a wide stream. Spanning the stream is a small wooden
footbridge, and beyond a path leads into a dark tunnel. Above the
bridge, floating in the air, is a large sign. It reads:  All ye who
stand before this bridge have completed a great and perilous adventure
which has tested your wit and courage. You have mastered">
		<COND (<EQUAL? <BAND <GETB 0 1> 8> 0>
		       <TELL "
the first part of the ZORK trilogy. Those who pass over this bridge must be
prepared to undertake an even greater adventure that will severely test your
skill and bravery!|
|
The ZORK trilogy continues with \"ZORK II: The Wizard of Frobozz\" and
is completed in \"ZORK III: The Dungeon Master.\"" CR>)
		      (T
		       <TELL "
ZORK: The Great Underground Empire.|" CR>)>
		<FINISH>)>>

<ROUTINE BARROW-DOOR-FCN ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL "The door is too heavy." CR>)>>

<ROUTINE BARROW-FCN ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?WEST>)>>

\

<ROUTINE TROPHY-CASE-FCN ()
    <COND (<AND <VERB? TAKE> <EQUAL? ,PRSO ,TROPHY-CASE>>
	   <TELL
"The trophy case is securely fastened to the wall." CR>)>>
	
<GLOBAL RUG-MOVED <>>

<ROUTINE LIVING-ROOM-FCN (RARG "AUX" RUG? TC)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <TELL
"You are in the living room. There is a doorway to the east">
	       <COND (,MAGIC-FLAG
		      <TELL
". To the
west is a cyclops-shaped opening in an old wooden door, above which is
some strange gothic lettering, ">)
		     (T
		      <TELL
", a wooden
door with strange gothic lettering to the west, which appears to be
nailed shut, ">)>
	       <TELL "a trophy case, ">
	       <SET RUG? ,RUG-MOVED>
	       <COND (<AND .RUG? <FSET? ,TRAP-DOOR ,OPENBIT>>
		      <TELL
		       "and a rug lying beside an open trap door.">)
		     (.RUG?
		      <TELL "and a closed trap door at your feet.">)
		     (<FSET? ,TRAP-DOOR ,OPENBIT>
		      <TELL "and an open trap door at your feet.">)
		     (T
		      <TELL
		       "and a large oriental rug in the center of the room.">)>
	       <CRLF>
	       T)
	      (<EQUAL? .RARG ,M-END>
	       <COND (<OR <VERB? TAKE>
			  <AND <VERB? PUT>
			       <EQUAL? ,PRSI ,TROPHY-CASE>>>
		      <COND (<IN? ,PRSO ,TROPHY-CASE>
			     <TOUCH-ALL ,PRSO>)>
		      <SETG SCORE <+ ,BASE-SCORE <OTVAL-FROB>>>
		      <SCORE-UPD 0>
		      <RFALSE>)>)>>

<ROUTINE TOUCH-ALL (OBJ "AUX" F)
	 <SET F <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (T
			<FSET .F ,TOUCHBIT>
			<COND (<FIRST? .F> <TOUCH-ALL .F>)>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE OTVAL-FROB ("OPTIONAL" (O ,TROPHY-CASE) "AUX" F (SCORE 0))
	 <SET F <FIRST? .O>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN .SCORE>)>
		 <SET SCORE <+ .SCORE <GETP .F ,P?TVALUE>>>
		 <COND (<FIRST? .F> <OTVAL-FROB .F>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE TRAP-DOOR-FCN ()
    <COND (<VERB? RAISE>
	   <PERFORM ,V?OPEN ,TRAP-DOOR>
	   <RTRUE>)
	  (<AND <VERB? OPEN CLOSE>
		<EQUAL? ,HERE ,LIVING-ROOM>>
	   <OPEN-CLOSE ,PRSO
"The door reluctantly opens to reveal a rickety staircase descending into
darkness."
"The door swings shut and closes.">)
	  (<AND <VERB? LOOK-UNDER> <EQUAL? ,HERE LIVING-ROOM>>
	   <COND (<FSET? ,TRAP-DOOR ,OPENBIT>
		  <TELL
"You see a rickety staircase descending into darkness." CR>)
		 (T <TELL "It's closed." CR>)>)
	  (<EQUAL? ,HERE ,CELLAR>
	   <COND (<AND <VERB? OPEN UNLOCK>
		       <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
		  <TELL
"The door is locked from above." CR>)
		 (<AND <VERB? CLOSE> <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
		  <FCLEAR ,TRAP-DOOR ,TOUCHBIT>
		  <FCLEAR ,TRAP-DOOR ,OPENBIT>
		  <TELL "The door closes and locks." CR>)
		 (<VERB? OPEN CLOSE>
		  <TELL <PICK-ONE ,DUMMY> CR>)>)>>

<ROUTINE CELLAR-FCN (RARG)
  <COND (<EQUAL? .RARG ,M-LOOK>
	 <TELL
"You are in a dark and damp cellar with a narrow passageway leading
north, and a crawlway to the south. On the west is the bottom of a
steep metal ramp which is unclimbable." CR>)
	(<EQUAL? .RARG ,M-ENTER>
	 <COND (<AND <FSET? ,TRAP-DOOR ,OPENBIT>
		     <NOT <FSET? ,TRAP-DOOR ,TOUCHBIT>>>
		<FCLEAR ,TRAP-DOOR ,OPENBIT>
		<FSET ,TRAP-DOOR ,TOUCHBIT>
		<TELL
"The trap door crashes shut, and you hear someone barring it." CR CR>)>)>>

<ROUTINE CHIMNEY-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The chimney leads ">
		<COND (<==? ,HERE ,KITCHEN>
		       <TELL "down">)
		      (T <TELL "up">)>
		<TELL "ward, and looks climbable." CR>)>>

<ROUTINE UP-CHIMNEY-FUNCTION ("AUX" F)
  <COND (<NOT <SET F <FIRST? ,WINNER>>>
	 <TELL "Going up empty-handed is a bad idea." CR>
	 <RFALSE>)
	(<AND <OR <NOT <SET F <NEXT? .F>>>
		  <NOT <NEXT? .F>>>
	      <IN? ,LAMP ,WINNER>>
	 <COND (<NOT <FSET? ,TRAP-DOOR ,OPENBIT>>
		<FCLEAR ,TRAP-DOOR ,TOUCHBIT>)>
	 <RETURN ,KITCHEN>)
	(T
	 <TELL "You can't get up there with what you're carrying." CR>
	 <RFALSE>)>>

<ROUTINE TRAP-DOOR-EXIT ()
	 <COND (,RUG-MOVED
		<COND (<FSET? ,TRAP-DOOR ,OPENBIT>
		       <RETURN ,CELLAR>)
		      (T
		       <TELL "The trap door is closed." CR>
		       <THIS-IS-IT ,TRAP-DOOR>
		       <RFALSE>)>)
	       (T
		<TELL "You can't go that way." CR>
		<RFALSE>)>>

<ROUTINE RUG-FCN ()
   <COND (<VERB? RAISE>
	  <TELL "The rug is too heavy to lift">
	  <COND (,RUG-MOVED
		 <TELL "." CR>)
		(T
		 <TELL
", but in trying to take it you have
noticed an irregularity beneath it." CR>)>)
	 (<VERB? MOVE PUSH>
	  <COND (,RUG-MOVED
		 <TELL
"Having moved the carpet previously, you find it impossible to move
it again." CR>)
		(T
		 <TELL
"With a great effort, the rug is moved to one side of the room, revealing
the dusty cover of a closed trap door." CR>
		 <FCLEAR ,TRAP-DOOR ,INVISIBLE>
		 <THIS-IS-IT ,TRAP-DOOR>
		 <SETG RUG-MOVED T>)>)
	 (<VERB? TAKE>
	  <TELL
"The rug is extremely heavy and cannot be carried." CR>)
	 (<AND <VERB? LOOK-UNDER>
	       <NOT ,RUG-MOVED>
	       <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
	  <TELL
"Underneath the rug is a closed trap door. As you drop the corner of the
rug, the trap door is once again concealed from view." CR>)
	 (<VERB? CLIMB-ON>
	  <COND (<AND <NOT ,RUG-MOVED>
		      <NOT <FSET? ,TRAP-DOOR ,OPENBIT>>>
		 <TELL
"As you sit, you notice an irregularity underneath it. Rather than be
uncomfortable, you stand up again." CR>)
		(ELSE
		 <TELL "I suppose you think it's a magic carpet?" CR>)>)>>

\

"SUBTITLE TROLL"

<ROUTINE AXE-F ()
	 <COND (,TROLL-FLAG <>)
	       (T <WEAPON-FUNCTION ,AXE ,TROLL>)>>

<ROUTINE STILETTO-FUNCTION ()
	 <WEAPON-FUNCTION ,STILETTO ,THIEF>>

<ROUTINE WEAPON-FUNCTION (W V)
	<COND (<NOT <IN? .V ,HERE>> <RFALSE>)
	      (<VERB? TAKE>
	       <COND (<IN? .W .V>
		      <TELL
"The " D .V " swings it out of your reach." CR>)
		     (T
		      <TELL
"The " D .W " seems white-hot. You can't hold on to it." CR>)>
	       T)>>

<ROUTINE TROLL-FCN ("OPTIONAL" (MODE <>))
	 <COND (<VERB? TELL>
		<SETG P-CONT <>>
		<TELL "The troll isn't much of a conversationalist." CR>)
	       (<EQUAL? .MODE ,F-BUSY?>
		<COND (<IN? ,AXE ,TROLL> <>)
		      (<AND <IN? ,AXE ,HERE> <PROB 75 90>>
		       <FSET ,AXE ,NDESCBIT>
		       <FCLEAR ,AXE ,WEAPONBIT>
		       <MOVE ,AXE ,TROLL>
		       <PUTP ,TROLL ,P?LDESC
"A nasty-looking troll, brandishing a bloody axe, blocks all passages out
of the room.">
		       <AND <IN? ,TROLL ,HERE>
			    <TELL
"The troll, angered and humiliated, recovers his weapon. He appears to have
an axe to grind with you." CR>>
		      T)
		     (<IN? ,TROLL ,HERE>
		      <PUTP ,TROLL ,P?LDESC
"A pathetically babbling troll is here.">
		      <TELL
"The troll, disarmed, cowers in terror, pleading for his life in
the guttural tongue of the trolls." CR>
		      T)>)
	      (<EQUAL? .MODE ,F-DEAD>
	       <COND (<IN? ,AXE ,TROLL>
		      <MOVE ,AXE ,HERE>
		      <FCLEAR ,AXE ,NDESCBIT>
		      <FSET ,AXE ,WEAPONBIT>)>
	       <SETG TROLL-FLAG T>)
	      (<EQUAL? .MODE ,F-UNCONSCIOUS>
	       <FCLEAR ,TROLL ,FIGHTBIT>
	       <COND (<IN? ,AXE ,TROLL>
		      <MOVE ,AXE ,HERE>
		      <FCLEAR ,AXE ,NDESCBIT>
		      <FSET ,AXE ,WEAPONBIT>)>
	       <PUTP ,TROLL ,P?LDESC
"An unconscious troll is sprawled on the floor. All passages
out of the room are open.">
	       <SETG TROLL-FLAG T>)
	      (<EQUAL? .MODE ,F-CONSCIOUS>
	       <COND (<IN? ,TROLL ,HERE>
		      <FSET ,TROLL ,FIGHTBIT>
		      <TELL
"The troll stirs, quickly resuming a fighting stance." CR>)>
	       <COND (<IN? ,AXE ,TROLL>
		      <PUTP ,TROLL ,P?LDESC
"A nasty-looking troll, brandishing a bloody axe, blocks
all passages out of the room.">)
		     (<IN? ,AXE ,TROLL-ROOM>
		      <FSET ,AXE ,NDESCBIT>
		      <FCLEAR ,AXE ,WEAPONBIT>
		      <MOVE ,AXE ,TROLL>
		      <PUTP ,TROLL ,P?LDESC
"A nasty-looking troll, brandishing a bloody axe, blocks
all passages out of the room.">)
		     (T
		      <PUTP ,TROLL ,P?LDESC
"A troll is here.">)>
	       <SETG TROLL-FLAG <>>)
	      (<EQUAL? .MODE ,F-FIRST?>
	       <COND (<PROB 33>
		      <FSET ,TROLL ,FIGHTBIT>
		      <SETG P-CONT <>>
		      T)>)
	      (<NOT .MODE>
	       <COND (<VERB? EXAMINE>
		      <TELL <GETP ,TROLL ,P?LDESC> CR>)
		     (<OR <AND <VERB? THROW GIVE>
			       ,PRSO
			       <EQUAL? ,PRSI ,TROLL>>
			  <VERB? TAKE MOVE MUNG>>
		      <AWAKEN ,TROLL>
		      <COND (<VERB? THROW GIVE>
			     <COND (<AND <EQUAL? ,PRSO ,AXE>
					 <IN? ,AXE ,WINNER>>
				    <TELL
"The troll scratches his head in confusion, then takes the axe." CR>
				    <FSET ,TROLL ,FIGHTBIT>
				    <MOVE ,AXE ,TROLL>
				    <RTRUE>)
				   (<EQUAL? ,PRSO ,TROLL ,AXE>
				    <TELL
"You would have to get the " D ,PRSO " first, and that seems unlikely." CR>
				    <RTRUE>)>
			     <COND (<VERB? THROW>
				    <TELL
"The troll, who is remarkably coordinated, catches the " D ,PRSO>)
				   (T
				    <TELL
"The troll, who is not overly proud, graciously accepts the gift">)>
			     <COND (<AND <PROB 20>
					 <EQUAL? ,PRSO ,KNIFE ,SWORD ,AXE>>
				    <REMOVE-CAREFULLY ,PRSO>
				    <TELL
" and eats it hungrily. Poor troll, he dies from an internal hemorrhage
and his carcass disappears in a sinister black fog." CR>
				    <REMOVE-CAREFULLY ,TROLL>
				    <APPLY <GETP ,TROLL ,P?ACTION> ,F-DEAD>
				    <SETG TROLL-FLAG T>)
				   (<EQUAL? ,PRSO ,KNIFE ,SWORD ,AXE>
				    <MOVE ,PRSO ,HERE>
				    <TELL
" and, being for the moment sated, throws it back. Fortunately, the
troll has poor control, and the " D ,PRSO " falls to the floor. He does
not look pleased." CR>
				    <FSET ,TROLL ,FIGHTBIT>)
				   (T
				    <TELL
" and not having the most discriminating tastes, gleefully eats it." CR>
				    <REMOVE-CAREFULLY ,PRSO>)>)
			    (<VERB? TAKE MOVE>
			     <TELL
"The troll spits in your face, grunting \"Better luck next time\" in a
rather barbarous accent." CR>)
			    (<VERB? MUNG>
			     <TELL
"The troll laughs at your puny gesture." CR>)>)
		     (<VERB? LISTEN>
		      <TELL
"Every so often the troll says something, probably uncomplimentary, in
his guttural tongue." CR>)
		     (<AND ,TROLL-FLAG <VERB? HELLO>>
		      <TELL "Unfortunately, the troll can't hear you." CR>)>)>>

\

"SUBTITLE GRATING/MAZE"

;<GLOBAL LEAVES-GONE <>> ;"no longer used?"
<GLOBAL GRATE-REVEALED <>>
<GLOBAL GRUNLOCK <>>

<ROUTINE LEAVES-APPEAR ()
	<COND (<AND <NOT <FSET? ,GRATE ,OPENBIT>>
	            <NOT ,GRATE-REVEALED>>
	       <COND (<VERB? MOVE TAKE>
		      <TELL
"In disturbing the pile of leaves, a grating is revealed." CR>)
		     (T <TELL
"With the leaves moved, a grating is revealed." CR>)>
	       <FCLEAR ,GRATE ,INVISIBLE>
	       <SETG GRATE-REVEALED T>)>
	<>>

<ROUTINE LEAF-PILE ()
	<COND (<VERB? COUNT>
	       <TELL "There are 69,105 leaves here." CR>)
	      (<VERB? BURN>
	       <LEAVES-APPEAR>
	       <REMOVE-CAREFULLY ,PRSO>
	       <COND (<IN? ,PRSO ,HERE>
		      <TELL
"The leaves burn." CR>)
		     (T
		      <JIGS-UP
"The leaves burn, and so do you.">)>)
	      (<VERB? CUT>
	       <TELL "You rustle the leaves around, making quite a mess." CR>
	       <LEAVES-APPEAR>
	       <RTRUE>)
	      (<VERB? MOVE TAKE>
	       <COND (<VERB? MOVE>
		      <TELL "Done." CR>)>
	       <COND (,GRATE-REVEALED <RFALSE>)>
	       <LEAVES-APPEAR>
	       <COND (<VERB? TAKE> <RFALSE>)
		     (T <RTRUE>)>)
	      (<AND <VERB? LOOK-UNDER>
		    <NOT ,GRATE-REVEALED>>
	       <TELL
"Underneath the pile of leaves is a grating. As you release the leaves,
the grating is once again concealed from view." CR>)>>
 
<ROUTINE CLEARING-FCN (RARG)
  	 <COND (<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT ,GRATE-REVEALED>
		       <FSET ,GRATE ,INVISIBLE>)>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a clearing, with a forest surrounding you on all sides. A
path leads south.">
		<COND (<FSET? ,GRATE ,OPENBIT>
		       <CRLF>
		       <TELL
"There is an open grating, descending into darkness.">)
		      (,GRATE-REVEALED
		       <CRLF>
		       <TELL
"There is a grating securely fastened into the ground.">)>
		<CRLF>)>>

<ROUTINE MAZE-11-FCN (RARG)
  	 <COND (<EQUAL? .RARG ,M-ENTER>
		<FCLEAR ,GRATE ,INVISIBLE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a small room near the maze. There are twisty passages
in the immediate vicinity." CR>
		<COND (<FSET? ,GRATE ,OPENBIT>
		       <TELL
 "Above you is an open grating with sunlight pouring in.">)
		      (,GRUNLOCK
		       <TELL "Above you is a grating.">)
		      (T
		       <TELL
 "Above you is a grating locked with a skull-and-crossbones lock.">)>
		<CRLF>)>>

<ROUTINE GRATE-FUNCTION ()
    	 <COND (<AND <VERB? OPEN> <EQUAL? ,PRSI ,KEYS>>
		<PERFORM ,V?UNLOCK ,GRATE ,KEYS>
		<RTRUE>)
	       (<VERB? LOCK>
		<COND (<EQUAL? ,HERE ,GRATING-ROOM>
		       <SETG GRUNLOCK <>>
		       <TELL "The grate is locked." CR>)
	              (<EQUAL? ,HERE ,GRATING-CLEARING>
		       <TELL "You can't lock it from this side." CR>)>)
	       (<AND <VERB? UNLOCK> <EQUAL? ,PRSO ,GRATE>>
		<COND (<AND <EQUAL? ,HERE ,GRATING-ROOM> <EQUAL? ,PRSI ,KEYS>>
		       <SETG GRUNLOCK T>
		       <TELL "The grate is unlocked." CR>)
		      (<AND <EQUAL? ,HERE ,GRATING-CLEARING>
			    <EQUAL? ,PRSI ,KEYS>>
		       <TELL "You can't reach the lock from here." CR>)
		      (T
		       <TELL
"Can you unlock a grating with a " D ,PRSI "?" CR>)>)
               (<VERB? PICK>
		<TELL "You can't pick the lock." CR>)
               (<VERB? OPEN CLOSE>
		<COND (,GRUNLOCK
		       <OPEN-CLOSE ,GRATE
				   <COND (<EQUAL? ,HERE ,CLEARING>
					  "The grating opens.")
					 (T
"The grating opens to reveal trees above you.")>
				   "The grating is closed.">
		       <COND (<FSET? ,GRATE ,OPENBIT>
			      <COND (<AND <NOT <EQUAL? ,HERE ,CLEARING>>
					  <NOT ,GRATE-REVEALED>>
				     <TELL
"A pile of leaves falls onto your head and to the ground." CR>
				     <SETG GRATE-REVEALED T>
				     <MOVE ,LEAVES ,HERE>)>
			      <FSET ,GRATING-ROOM ,ONBIT>)
			     (T <FCLEAR ,GRATING-ROOM ,ONBIT>)>)
		      (T <TELL "The grating is locked." CR>)>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI ,GRATE>>
		<COND (<G? <GETP ,PRSO ,P?SIZE> 20>
		       <TELL "It won't fit through the grating." CR>)
		      (T
		       <MOVE ,PRSO ,GRATING-ROOM>
		       <TELL
"The " D ,PRSO " goes through the grating into the darkness below." CR>)>)>>

<ROUTINE MAZE-DIODES ()
	 <TELL
"You won't be able to get back up to the tunnel you are going through
when it gets to the next room." CR CR>
	 <COND (<EQUAL? ,HERE ,MAZE-2> ,MAZE-4)
	       (<EQUAL? ,HERE ,MAZE-7> ,DEAD-END-1)
	       (<EQUAL? ,HERE ,MAZE-9> ,MAZE-11)
	       (<EQUAL? ,HERE ,MAZE-12> ,MAZE-5)>>

<ROUTINE RUSTY-KNIFE-FCN ()
	<COND (<VERB? TAKE>
	       <AND <IN? ,SWORD ,WINNER>
		    <TELL
"As you touch the rusty knife, your sword gives a single pulse of blinding
blue light." CR>>
	       <>)
	      (<OR <AND <EQUAL? ,PRSI ,RUSTY-KNIFE>
			<VERB? ATTACK>>
		   <AND <VERB? SWING>
			<EQUAL? ,PRSO ,RUSTY-KNIFE>
			,PRSI>>
	       <REMOVE-CAREFULLY ,RUSTY-KNIFE>
	       <JIGS-UP
"As the knife approaches its victim, your mind is submerged by an
overmastering will. Slowly, your hand turns, until the rusty blade
is an inch from your neck. The knife seems to sing as it savagely
slits your throat.">)>>

<ROUTINE KNIFE-F ()
	 <COND (<VERB? TAKE>
		<FCLEAR ,ATTIC-TABLE ,NDESCBIT>
		<RFALSE>)>>

<ROUTINE SKELETON ()
	 <COND (<VERB? TAKE RUB MOVE PUSH RAISE LOWER ATTACK KICK KISS>
		<TELL
"A ghost appears in the room and is appalled at your desecration of
the remains of a fellow adventurer. He casts a curse on your valuables
and banishes them to the Land of the Living Dead. The ghost leaves,
muttering obscenities." CR>
	 	<ROB ,HERE ,LAND-OF-LIVING-DEAD 100>
	 	<ROB ,ADVENTURER ,LAND-OF-LIVING-DEAD>
	 	T)>>

\

<ROUTINE TORCH-OBJECT ()
    <COND (<VERB? EXAMINE>
	   <TELL "The torch is burning." CR>)
	  (<AND <VERB? POUR-ON>
		<EQUAL? ,PRSI ,TORCH>>
	   <TELL "The water evaporates before it gets close." CR>)
	  (<AND <VERB? LAMP-OFF> <FSET? ,PRSO ,ONBIT>>
	   <TELL
"You nearly burn your hand trying to extinguish the flame." CR>)>>

\

"SUBTITLE MIRROR, MIRROR, ON THE WALL"

<ROUTINE MIRROR-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
	        <TELL
"You are in a large square room with tall ceilings. On the south wall
is an enormous mirror which fills the entire wall. There are exits
on the other three sides of the room." CR>
		<COND (,MIRROR-MUNG
		       <TELL
"Unfortunately, the mirror has been destroyed by your recklessness." CR>)>)>>

<GLOBAL MIRROR-MUNG <>>
;<GLOBAL LUCKY T>

<ROUTINE MIRROR-MIRROR ("AUX" (RM2 ,MIRROR-ROOM-2) L1 L2 N)
	<COND (<AND <NOT ,MIRROR-MUNG> <VERB? RUB>>
	       <COND (<AND ,PRSI <NOT <EQUAL? ,PRSI ,HANDS>>>
		      <TELL
"You feel a faint tingling transmitted through the " D ,PRSI "." CR>
		      <RTRUE>)>
	       <COND (<EQUAL? ,HERE .RM2>
		      <SET RM2 ,MIRROR-ROOM-1>)>
	       <SET L1 <FIRST? ,HERE>>
	       <SET L2 <FIRST? .RM2>>
	       <REPEAT ()
		       <COND (<NOT .L1> <RETURN>)>
		       <SET N <NEXT? .L1>>
		       <MOVE .L1 .RM2>
		       <SET L1 .N>>
	       <REPEAT ()
		       <COND (<NOT .L2> <RETURN>)>
		       <SET N <NEXT? .L2>>
		       <MOVE .L2 ,HERE>
		       <SET L2 .N>>
	       <GOTO .RM2 <>>
	       <TELL
"There is a rumble from deep within the earth and the room shakes." CR>)
	      (<VERB? LOOK-INSIDE EXAMINE>
	       <COND (,MIRROR-MUNG
		      <TELL "The mirror is broken into many pieces.">)
		     (T
		      <TELL "There is an ugly person staring back at you.">)>
	       <CRLF>)
	      (<VERB? TAKE>
	       <TELL
"The mirror is many times your size. Give up." CR>)
	      (<VERB? MUNG THROW ATTACK>
	       <COND (,MIRROR-MUNG
		      <TELL
"Haven't you done enough damage already?" CR>)
		     (T
		      <SETG MIRROR-MUNG T>
		      <SETG LUCKY <>>
		      <TELL
"You have broken the mirror. I hope you have a seven years' supply of
good luck handy." CR>)>)>>

\

"SUBTITLE THE DOME"

<ROUTINE TORCH-ROOM-FCN (RARG)
 	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a large room with a prominent doorway leading to a down
staircase. Above you is a large dome. Up around the edge of the
dome (20 feet up) is a wooden railing. In the center of the room
sits a white marble pedestal." CR>
		<COND (,DOME-FLAG
		       <TELL
"A piece of rope descends from the railing above, ending some
five feet above your head." CR>)>)>>

<ROUTINE DOME-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are at the periphery of a large dome, which forms the ceiling
of another room below. Protecting you from a precipitous drop is a
wooden railing which circles the dome." CR>
		<COND (,DOME-FLAG
		       <TELL
"Hanging down from the railing is a rope which ends about ten feet
from the floor below." CR>)>)
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (,DEAD
		       <TELL
"As you enter the dome you feel a strong pull as if from a wind
drawing you over the railing and down." CR>
		       <MOVE ,WINNER ,TORCH-ROOM>
		       <SETG HERE ,TORCH-ROOM>
		       <RTRUE>)
		      (<VERB? LEAP>
		       <JIGS-UP
"I'm afraid that the leap you attempted has done you in.">)>)>>

;<GLOBAL EGYPT-FLAG <>>	;"no longer used?"

\

"SUBTITLE LAND OF THE DEAD"

<ROUTINE LLD-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are outside a large gateway, on which is inscribed||
  Abandon every hope
all ye who enter here!||
The gate is open; through it you can see a desolation, with a pile of
mangled bodies in one corner. Thousands of voices, lamenting some
hideous fate, can be heard." CR>
		<COND (<AND <NOT ,LLD-FLAG> <NOT ,DEAD>>
		       <TELL
"The way through the gate is barred by evil spirits, who jeer at your
attempts to pass." CR>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? EXORCISE>
		       <COND (<NOT ,LLD-FLAG>
			      <COND (<AND <IN? ,BELL ,WINNER>
					  <IN? ,BOOK ,WINNER>
					  <IN? ,CANDLES ,WINNER>>
				     <TELL
"You must perform the ceremony." CR>)
				    (T
				     <TELL
"You aren't equipped for an exorcism." CR>)>)>)
		      (<AND <NOT ,LLD-FLAG>
			    <VERB? RING>
			    <EQUAL? ,PRSO ,BELL>>
		       <SETG XB T>
		       <REMOVE-CAREFULLY ,BELL>
		       <THIS-IS-IT ,HOT-BELL>
		       <MOVE ,HOT-BELL ,HERE>
		       <TELL
"The bell suddenly becomes red hot and falls to the ground. The
wraiths, as if paralyzed, stop their jeering and slowly turn to face
you. On their ashen faces, the expression of a long-forgotten terror
takes shape." CR>
		       <COND (<IN? ,CANDLES ,WINNER>
			      <TELL
"In your confusion, the candles drop to the ground (and they are out)." CR>
			      <MOVE ,CANDLES ,HERE>
			      <FCLEAR ,CANDLES ,ONBIT>
			      <DISABLE <INT I-CANDLES>>)>
		       <ENABLE <QUEUE I-XB 6>>
		       <ENABLE <QUEUE I-XBH 20>>)
		      (<AND ,XC
			    <VERB? READ>
			    <EQUAL? ,PRSO ,BOOK>
			    <NOT ,LLD-FLAG>>
		       <TELL
"Each word of the prayer reverberates through the hall in a deafening
confusion. As the last word fades, a voice, loud and commanding,
speaks: \"Begone, fiends!\" A heart-stopping scream fills the cavern,
and the spirits, sensing a greater power, flee through the walls." CR>
		       <REMOVE-CAREFULLY ,GHOSTS>
		       <SETG LLD-FLAG T>
		       <DISABLE <INT I-XC>>)>)
	       (<EQUAL? .RARG ,M-END>
		<COND (<AND ,XB
			    <IN? ,CANDLES ,WINNER>
			    <FSET? ,CANDLES ,ONBIT>
			    <NOT ,XC>>
		       <SETG XC T>
		       <TELL
"The flames flicker wildly and appear to dance. The earth beneath
your feet trembles, and your legs nearly buckle beneath you.
The spirits cower at your unearthly power." CR>
		       <DISABLE <INT I-XB>>
		       <ENABLE <QUEUE I-XC 3>>)>)>>

<GLOBAL XB <>>

<GLOBAL XC <>>

<ROUTINE I-XB ()
	 <OR ,XC
	     <AND <EQUAL? ,HERE ,ENTRANCE-TO-HADES>
		  <TELL
"The tension of this ceremony is broken, and the wraiths, amused but
shaken at your clumsy attempt, resume their hideous jeering." CR>>>
	 <SETG XB <>>>

<ROUTINE I-XC ()
	 <SETG XC <>>
	 <I-XB>>

<ROUTINE I-XBH ()
	 <REMOVE-CAREFULLY ,HOT-BELL>
	 <MOVE ,BELL ,ENTRANCE-TO-HADES>
	 <COND (<EQUAL? ,HERE ,ENTRANCE-TO-HADES>
		<TELL "The bell appears to have cooled down." CR>)>>

\

"SUBTITLE FLOOD CONTROL DAM #3"

<GLOBAL GATE-FLAG <>>
<GLOBAL GATES-OPEN <>>

<ROUTINE DAM-ROOM-FCN (RARG)
   	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are standing on the top of the Flood Control Dam #3, which was
quite a tourist attraction in times far distant. There are paths to
the north, south, and west, and a scramble down." CR>
		<COND (<AND ,LOW-TIDE ,GATES-OPEN>
		       <TELL
"The water level behind the dam is low: The sluice gates have been
opened. Water rushes through the dam and downstream." CR>)
		      (,GATES-OPEN
		       <TELL
"The sluice gates are open, and water rushes through the dam. The
water level behind the dam is still high." CR>)
		      (,LOW-TIDE
		       <TELL
"The sluice gates are closed. The water level in the reservoir is
quite low, but the level is rising quickly." CR>)
		      (T
		       <TELL
"The sluice gates on the dam are closed. Behind the dam, there can be
seen a wide reservoir. Water is pouring over the top of the now
abandoned dam." CR>)>
		<TELL
"There is a control panel here, on which a large metal bolt is mounted.
Directly above the bolt is a small green plastic bubble">
		<COND (,GATE-FLAG
		       <TELL " which is
glowing serenely">)>
		<TELL "." CR>)>>

<ROUTINE BOLT-F ()
	<COND (<VERB? TURN>
	       <COND (<EQUAL? ,PRSI ,WRENCH>
		      <COND (,GATE-FLAG
			     <FCLEAR ,RESERVOIR-SOUTH ,TOUCHBIT>
			     <COND (,GATES-OPEN
				    <SETG GATES-OPEN <>>
				    <FCLEAR ,LOUD-ROOM ,TOUCHBIT>
				    <TELL
"The sluice gates close and water starts to collect behind the dam." CR>
				    <ENABLE <QUEUE I-RFILL 8>>
				    <QUEUE I-REMPTY 0>
				    T)
				   (T
				    <SETG GATES-OPEN T>
				    <TELL
"The sluice gates open and water pours through the dam." CR>
				    <ENABLE <QUEUE I-REMPTY 8>>
				    <QUEUE I-RFILL 0>
				    T)>)
			    (T <TELL
"The bolt won't turn with your best effort." CR>)>)
		     (ELSE
		      <TELL
"The bolt won't turn using the " D ,PRSI "." CR>)>)
	      (<VERB? TAKE>
	       <INTEGRAL-PART>)
	      (<VERB? OIL>
	       <TELL
"Hmm. It appears the tube contained glue, not oil. Turning the bolt
won't get any easier...." CR>)>>

<ROUTINE BUBBLE-F ()
	 <COND (<VERB? TAKE>
		<INTEGRAL-PART>)>>

<ROUTINE INTEGRAL-PART ()
	 <TELL "It is an integral part of the control panel." CR>>

<ROUTINE I-RFILL ()
	 <FSET ,RESERVOIR ,NONLANDBIT>
	 <FCLEAR ,RESERVOIR ,RLANDBIT>
	 <FCLEAR ,DEEP-CANYON ,TOUCHBIT>
	 <FCLEAR ,LOUD-ROOM ,TOUCHBIT>
	 <AND <IN? ,TRUNK ,RESERVOIR>
	      <FSET ,TRUNK ,INVISIBLE>>
	 <SETG LOW-TIDE <>>
	 <COND (<EQUAL? ,HERE ,RESERVOIR>
		<COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		       <TELL
"The boat lifts gently out of the mud and is now floating on
the reservoir." CR>)
		      (T
		       <JIGS-UP
"You are lifted up by the rising river! You try to swim, but the
currents are too strong. You come closer, closer to the awesome
structure of Flood Control Dam #3. The dam beckons to you.
The roar of the water nearly deafens you, but you remain conscious
as you tumble over the dam toward your certain doom among the rocks
at its base.">)>)
	       (<EQUAL? ,HERE ,DEEP-CANYON>
		<TELL
"A sound, like that of flowing water, starts to come from below." CR>)
	       (<EQUAL? ,HERE ,LOUD-ROOM>
		<TELL
"All of a sudden, an alarmingly loud roaring sound fills the room.
Filled with fear, you scramble away." CR>
		<GOTO <PICK-ONE ,LOUD-RUNS>>)
	       (<EQUAL? ,HERE ,RESERVOIR-NORTH ,RESERVOIR-SOUTH>
		<TELL
"You notice that the water level has risen to the point that it
is impossible to cross." CR>)>
	 T>

<GLOBAL LOUD-RUNS <LTABLE 0 DAMP-CAVE ROUND-ROOM DEEP-CANYON>>

<ROUTINE I-REMPTY ()
	 <FSET ,RESERVOIR ,RLANDBIT>
	 <FCLEAR ,RESERVOIR ,NONLANDBIT>
	 <FCLEAR ,DEEP-CANYON ,TOUCHBIT>
	 <FCLEAR ,LOUD-ROOM ,TOUCHBIT>
	 <FCLEAR ,TRUNK ,INVISIBLE>
	 <SETG LOW-TIDE T>
	 <COND (<AND <EQUAL? ,HERE ,RESERVOIR>
		     <FSET? <LOC ,WINNER> ,VEHBIT>>
		<TELL
"The water level has dropped to the point at which the boat can no
longer stay afloat. It sinks into the mud." CR>)
	       (<EQUAL? ,HERE ,DEEP-CANYON>
		<TELL
"The roar of rushing water is quieter now." CR>)
	       (<EQUAL? ,HERE ,RESERVOIR-NORTH ,RESERVOIR-SOUTH>
		<TELL
"The water level is now quite low here and you could easily cross over
to the other side." CR>)>
	 T>

<GLOBAL DROWNINGS
      <TABLE (PURE) "up to your ankles."
	"up to your shin."
	"up to your knees."
	"up to your hips."
	"up to your waist."
	"up to your chest."
	"up to your neck."
	"over your head."
	"high in your lungs.">>

<GLOBAL WATER-LEVEL 0>
<GDECL (WATER-LEVEL) FIX>

<ROUTINE BUTTON-F ()
	 <COND (<VERB? READ>
		<TELL "They're greek to you." CR>)
	       (<VERB? PUSH>
		<COND (<EQUAL? ,PRSO ,BLUE-BUTTON>
		       <COND (<0? ,WATER-LEVEL>
			      <FCLEAR ,LEAK ,INVISIBLE>
			      <TELL
"There is a rumbling sound and a stream of water appears to burst
from the east wall of the room (apparently, a leak has occurred in a
pipe)." CR>
			      <SETG WATER-LEVEL 1>
			      <ENABLE <QUEUE I-MAINT-ROOM -1>>
			      T)
			     (T
			      <TELL
			        "The blue button appears to be jammed." CR>)>)
		      (<EQUAL? ,PRSO ,RED-BUTTON>
		       <TELL "The lights within the room ">
		       <COND (<FSET? ,HERE ,ONBIT>
			      <FCLEAR ,HERE ,ONBIT>
			      <TELL "shut off." CR>)
			     (T
			      <FSET ,HERE ,ONBIT>
			      <TELL "come on." CR>)>)
		      (<EQUAL? ,PRSO ,BROWN-BUTTON>
		       <FCLEAR ,DAM-ROOM ,TOUCHBIT>
		       <SETG GATE-FLAG <>>
		       <TELL "Click." CR>)
		      (<EQUAL? ,PRSO ,YELLOW-BUTTON>
		       <FCLEAR ,DAM-ROOM ,TOUCHBIT>
		       <SETG GATE-FLAG T>
		       <TELL "Click." CR>)>)>>

<ROUTINE TOOL-CHEST-FCN ()
	 <COND (<VERB? EXAMINE>
		<TELL "The chests are all empty." CR>)
	       (<VERB? TAKE OPEN PUT>
		<REMOVE-CAREFULLY ,TOOL-CHEST>
<TELL
"The chests are so rusty and corroded that they crumble when you
touch them." CR>)
	       (<VERB? OPEN>
		<TELL "The chests are already open." CR>)>>

<ROUTINE I-MAINT-ROOM ("AUX" HERE?)
	 <SET HERE? <EQUAL? ,HERE ,MAINTENANCE-ROOM>>
	 <COND (.HERE? <TELL "The water level here is now "> <TELL <GET
		,DROWNINGS </ ,WATER-LEVEL 2>>> <CRLF>)>
	 <SETG WATER-LEVEL <+ 1 ,WATER-LEVEL>>
	 <COND (<NOT <L? ,WATER-LEVEL 14>>
		<MUNG-ROOM ,MAINTENANCE-ROOM
"The room is full of water and cannot be entered.">
		<QUEUE I-MAINT-ROOM 0>
		<COND (.HERE?
		     <JIGS-UP
"I'm afraid you have done drowned yourself.">)>)
	       (<AND <IN? ,WINNER ,INFLATED-BOAT>
		     <EQUAL? ,HERE ,MAINTENANCE-ROOM ,DAM-ROOM ,DAM-LOBBY>>
		<JIGS-UP
"The rising water carries the boat over the dam, down the river, and over
the falls. Tsk, tsk.">)>
	 <RTRUE>>

<ROUTINE LEAK-FUNCTION ()
	<COND (<G? ,WATER-LEVEL 0>
	       <COND (<AND <VERB? PUT PUT-ON>
			   <EQUAL? ,PRSO ,PUTTY>>
		      <FIX-MAINT-LEAK>)
		     (<VERB? PLUG>
		      <COND (<EQUAL? ,PRSI ,PUTTY>
			     <FIX-MAINT-LEAK>)
			    (T <WITH-TELL ,PRSI>)>)>)>>

<ROUTINE FIX-MAINT-LEAK ()
	 <SETG WATER-LEVEL -1>
	 <QUEUE I-MAINT-ROOM 0>
	 <TELL
"By some miracle of Zorkian technology, you have managed to stop the
leak in the dam." CR>>

<ROUTINE PUTTY-FCN ()
	 <COND (<OR <AND <VERB? OIL>
			 <EQUAL? ,PRSI ,PUTTY>>
		    <AND <VERB? PUT>
			 <EQUAL? ,PRSO ,PUTTY>>>
		<TELL "The all-purpose gunk isn't a lubricant." CR>)>>

<ROUTINE TUBE-FUNCTION ()
	 <COND (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,TUBE>>
		<TELL "The tube refuses to accept anything." CR>)
	       (<VERB? SQUEEZE>
		<COND (<AND <FSET? ,PRSO ,OPENBIT>
			    <IN? ,PUTTY ,PRSO>>
		       <MOVE ,PUTTY ,WINNER>
		       <TELL "The viscous material oozes into your hand." CR>)
		      (<FSET? ,PRSO ,OPENBIT>
		       <TELL "The tube is apparently empty." CR>)
		      (T
		       <TELL "The tube is closed." CR>)>)>>

<ROUTINE DAM-FUNCTION ()
	 <COND (<VERB? OPEN CLOSE>
		<TELL "Sounds reasonable, but this isn't how." CR>)
	       (<VERB? PLUG>
		<COND (<EQUAL? ,PRSI ,HANDS>
		       <TELL
"Are you the little Dutch boy, then? Sorry, this is a big dam." CR>)
		      (T
		       <TELL
"With a " D ,PRSI "? Do you know how big this dam is? You could only
stop a tiny leak with that." CR>)>)>>

<ROUTINE WITH-TELL (OBJ)
	 <TELL "With a " D .OBJ "?" CR>>

<ROUTINE RESERVOIR-SOUTH-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <COND (<AND ,LOW-TIDE ,GATES-OPEN>
		      <TELL
"You are in a long room, to the north of which was formerly a lake.
However, with the water level lowered, there is merely a wide stream
running through the center of the room.">)
		     (,GATES-OPEN
		      <TELL
"You are in a long room. To the north is a large lake, too deep
to cross. You notice, however, that the water level appears to be
dropping at a rapid rate. Before long, it might be possible to cross
to the other side from here.">)
		     (,LOW-TIDE
		      <TELL
"You are in a long room, to the north of which is a wide area which
was formerly a reservoir, but now is merely a stream. You notice,
however, that the level of the stream is rising quickly and that
before long it will be impossible to cross here.">)
		     (T
		      <TELL
"You are in a long room on the south shore of a large lake, far
too deep and wide for crossing.">)>
	       <CRLF>
	       <TELL
"There is a path along the stream to the east or west, a steep pathway
climbing southwest along the edge of a chasm, and a path leading into a
canyon to the southeast." CR>)>>

<ROUTINE RESERVOIR-FCN (RARG)
   	<COND (<AND <EQUAL? .RARG ,M-END>
		    <NOT <FSET? <LOC ,WINNER> ,VEHBIT>>
		    <NOT ,GATES-OPEN>
		    ,LOW-TIDE>
	       <TELL
"You notice that the water level here is rising rapidly. The currents
are also becoming stronger. Staying here seems quite perilous!" CR>)
	      (<EQUAL? .RARG ,M-LOOK>
	       <COND (,LOW-TIDE
		      <TELL
"You are on what used to be a large lake, but which is now a large
mud pile. There are \"shores\" to the north and south.">)
		     (T
		      <TELL
"You are on the lake. Beaches can be seen north and south.
Upstream a small stream enters the lake through a narrow cleft
in the rocks. The dam can be seen downstream.">)>
	       <CRLF>)>>

<ROUTINE RESERVOIR-NORTH-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <COND (<AND ,LOW-TIDE ,GATES-OPEN>
		      <TELL
"You are in a large cavernous room, the south of which was formerly
a lake. However, with the water level lowered, there is merely
a wide stream running through there.">)
		     (,GATES-OPEN
		      <TELL
"You are in a large cavernous area. To the south is a wide lake,
whose water level appears to be falling rapidly.">)
		     (,LOW-TIDE
		      <TELL
"You are in a cavernous area, to the south of which is a very wide
stream. The level of the stream is rising rapidly, and it appears
that before long it will be impossible to cross to the other side.">)
		     (T
		      <TELL
"You are in a large cavernous room, north of a large lake.">)>
	       <CRLF>
	       <TELL
"There is a slimy stairway leaving the room to the north." CR>)>>

\

"SUBTITLE WATER, WATER EVERYWHERE..."

<ROUTINE BOTTLE-FUNCTION ("AUX" (E? <>))
  <COND (<AND <VERB? THROW> <==? ,PRSO ,BOTTLE>>
	 <REMOVE-CAREFULLY ,PRSO>
	 <SET E? T>
	 <TELL "The bottle hits the far wall and shatters." CR>)
	(<VERB? MUNG>
	 <SET E? T>
	 <REMOVE-CAREFULLY ,PRSO>
	 <TELL "A brilliant maneuver destroys the bottle." CR>)
	(<VERB? SHAKE>
	 <COND (<AND <FSET? ,PRSO ,OPENBIT> <IN? ,WATER ,PRSO>>
		<SET E? T>)>)>
  <COND (<AND .E? <IN? ,WATER ,PRSO>>
	 <TELL "The water spills to the floor and evaporates." CR>
	 <REMOVE-CAREFULLY ,WATER>
	 T)
	(.E? <RTRUE>)>>

\

"SUBTITLE CYCLOPS"

<GLOBAL CYCLOWRATH 0>

<ROUTINE CYCLOPS-FCN ("AUX" COUNT)
	<SET COUNT ,CYCLOWRATH>
	<COND (<EQUAL? ,WINNER ,CYCLOPS>
	       <COND (,CYCLOPS-FLAG
		      <TELL "No use talking to him. He's fast asleep." CR>)
		     (<VERB? ODYSSEUS>
		      <SETG WINNER ,ADVENTURER>
		      <PERFORM ,V?ODYSSEUS>
		      <RTRUE>)
		     (ELSE
		      <TELL
"The cyclops prefers eating to making conversation." CR>)>)
	      (,CYCLOPS-FLAG
	       <COND (<VERB? EXAMINE>
		      <TELL
"The cyclops is sleeping like a baby, albeit a very ugly one." CR>)
		     (<VERB? ALARM KICK ATTACK BURN MUNG>
		      <TELL
"The cyclops yawns and stares at the thing that woke him up." CR>
		      <SETG CYCLOPS-FLAG <>>
		      <FSET ,CYCLOPS ,FIGHTBIT>
		      <COND (<L? .COUNT 0>
			     <SETG CYCLOWRATH <- .COUNT>>)
			    (T
			     <SETG CYCLOWRATH .COUNT>)>)>)
	      (<VERB? EXAMINE>
	       <TELL
"A hungry cyclops is standing at the foot of the stairs." CR>)
	      (<AND <VERB? GIVE> <EQUAL? ,PRSI ,CYCLOPS>>
	       <COND (<EQUAL? ,PRSO ,LUNCH>
		      <COND (<NOT <L? .COUNT 0>>
			     <REMOVE-CAREFULLY ,LUNCH>
			     <TELL
"The cyclops says \"Mmm Mmm. I love hot peppers! But oh, could I use
a drink. Perhaps I could drink the blood of that thing.\"  From the
gleam in his eye, it could be surmised that you are \"that thing\"." CR>
			     <SETG CYCLOWRATH <MIN -1 <- .COUNT>>>)>
		      <ENABLE <QUEUE I-CYCLOPS -1>>)
		     (<OR <EQUAL? ,PRSO ,WATER>
			  <AND <EQUAL? ,PRSO ,BOTTLE>
			       <IN? ,WATER ,BOTTLE>>>
		      <COND (<L? .COUNT 0>
			     <REMOVE-CAREFULLY ,WATER>
			     <MOVE ,BOTTLE ,HERE>
			     <FSET ,BOTTLE ,OPENBIT>
			     <FCLEAR ,CYCLOPS ,FIGHTBIT>
			     <TELL
"The cyclops takes the bottle, checks that it's open, and drinks the water.
A moment later, he lets out a yawn that nearly blows you over, and then
falls fast asleep (what did you put in that drink, anyway?)." CR>
			     <SETG CYCLOPS-FLAG T>)
			    (T
			     <TELL
"The cyclops apparently is not thirsty and refuses your generous offer." CR>)>)
		     (<EQUAL? ,PRSO ,GARLIC>
		      <TELL
"The cyclops may be hungry, but there is a limit." CR>)
		     (T
		      <TELL
"The cyclops is not so stupid as to eat THAT!" CR>)>)
	      (<VERB? THROW ATTACK MUNG>
	       <ENABLE <QUEUE I-CYCLOPS -1>>
	       <COND (<VERB? MUNG>
		      <TELL
"\"Do you think I'm as stupid as my father was?\", he says, dodging." CR>)
		     (T
		      <TELL
"The cyclops shrugs but otherwise ignores your pitiful attempt." CR>
		      <COND (<VERB? THROW>
			     <MOVE ,PRSO ,HERE>)>
		      <RTRUE>)>)
	      (<VERB? TAKE>
	       <TELL
"The cyclops doesn't take kindly to being grabbed." CR>)
	      (<VERB? TIE>
	       <TELL
"You cannot tie the cyclops, though he is fit to be tied." CR>)
	      (<VERB? LISTEN>
	       <TELL
"You can hear his stomach rumbling." CR>)>>

<ROUTINE I-CYCLOPS ()
	 <COND (<OR ,CYCLOPS-FLAG ,DEAD> <RTRUE>)
	       (<NOT <EQUAL? ,HERE ,CYCLOPS-ROOM>>
		<DISABLE <INT I-CYCLOPS>>)
	       (T
		<COND (<G? <ABS ,CYCLOWRATH> 5>
		       <DISABLE <INT I-CYCLOPS>>
		       <JIGS-UP
"The cyclops, tired of all of your games and trickery, grabs you firmly.
As he licks his chops, he says \"Mmm. Just like Mom used to make 'em.\"
It's nice to be appreciated.">)
		      (T
		       <COND (<L? ,CYCLOWRATH 0>
			      <SETG CYCLOWRATH <- ,CYCLOWRATH 1>>)
			     (T
			      <SETG CYCLOWRATH <+ ,CYCLOWRATH 1>>)>
		       <COND (<NOT ,CYCLOPS-FLAG>
			      <TELL <NTH ,CYCLOMAD <- <ABS ,CYCLOWRATH> 1>>
				    CR>)>)>)>>

<ROUTINE CYCLOPS-ROOM-FCN (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
	       <TELL
"This room has an exit on the northwest, and a staircase leading up." CR>
	       <COND (<AND ,CYCLOPS-FLAG <NOT ,MAGIC-FLAG>>
		      <TELL
"The cyclops is sleeping blissfully at the foot of the stairs." CR>)
		     (,MAGIC-FLAG
		      <TELL
"The east wall, previously solid, now has a cyclops-sized opening in it." CR>)
		     (<0? ,CYCLOWRATH>
		      <TELL
"A cyclops, who looks prepared to eat horses (much less mere
adventurers), blocks the staircase. From his state of health, and
the bloodstains on the walls, you gather that he is not very
friendly, though he likes people." CR>)
		     (<G? ,CYCLOWRATH 0>
		      <TELL
"The cyclops is standing in the corner, eyeing you closely. I don't
think he likes you very much. He looks extremely hungry, even for a
cyclops." CR>)
		     (<L? ,CYCLOWRATH 0>
		      <TELL
"The cyclops, having eaten the hot peppers, appears to be gasping.
His enflamed tongue protrudes from his man-sized mouth." CR>)>)
	      (<EQUAL? .RARG ,M-ENTER>
	       <OR <0? ,CYCLOWRATH> <ENABLE <INT I-CYCLOPS>>>)>>

<GLOBAL CYCLOMAD
	<TABLE (PURE)
	  "The cyclops seems somewhat agitated."
	  "The cyclops appears to be getting more agitated."
	  "The cyclops is moving about the room, looking for something."
	  "The cyclops was looking for salt and pepper. No doubt they are
condiments for his upcoming snack."
	  "The cyclops is moving toward you in an unfriendly manner."
	  "You have two choices: 1. Leave  2. Become dinner.">>

\

"SUBTITLE LOUD LOUD LOUD"

<GLOBAL LOUD-FLAG <>>

<ROUTINE LOUD-ROOM-FCN (RARG "AUX" WRD)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a large room with a ceiling which cannot be detected from
the ground. There is a narrow passage from east to west and a stone
stairway leading upward.">
		<COND (<OR ,LOUD-FLAG
			   <AND <NOT ,GATES-OPEN> ,LOW-TIDE>>
		       <TELL " The room is eerie in its quietness.">)
		      (T
		       <TELL " The room is deafeningly loud with an
undetermined rushing sound. The sound seems to reverberate from all
of the walls, making it difficult even to think.">)>
		<CRLF>)
	       (<AND <EQUAL? .RARG ,M-END> ,GATES-OPEN <NOT ,LOW-TIDE>>
		<TELL
"It is unbearably loud here, with an ear-splitting roar seeming to
come from all around you. There is a pounding in your head which won't
stop. With a tremendous effort, you scramble out of the room." CR CR>
		<GOTO <PICK-ONE ,LOUD-RUNS>>
		<RFALSE>)		
	       (<EQUAL? .RARG ,M-ENTER>
		<COND (<OR ,LOUD-FLAG
			   <AND <NOT ,GATES-OPEN> ,LOW-TIDE>>
		       <RFALSE>)
		      (<AND ,GATES-OPEN <NOT ,LOW-TIDE>>
		       <RFALSE>)
		      (T
		       <V-FIRST-LOOK>
		       <COND (,P-CONT
			      <TELL
"The rest of your commands have been lost in the noise." CR>
			      <SETG P-CONT <>>)>
		       <REPEAT ()
			       <COND (<NOT ,SUPER-BRIEF> <CRLF>)>
			       <TELL ">">
			       <READ ,P-INBUF ,P-LEXV>
			       <COND (<0? <GETB ,P-LEXV ,P-LEXWORDS>>
			              <TELL "I beg your pardon?" CR>
				      <AGAIN>)>
			       <SET WRD <GET ,P-LEXV 1>>
			       <COND (<EQUAL? .WRD ,W?GO ,W?WALK ,W?RUN>
				      <SET WRD <GET ,P-LEXV 3>>)
				     (<EQUAL? .WRD ,W?SAY>
				      <SET WRD <GET ,P-LEXV 5>>)>
			       <COND (<EQUAL? .WRD ,W?SAVE>
				      <V-SAVE>)
				     (<EQUAL? .WRD ,W?RESTORE>
				      <V-RESTORE>)
				     (<EQUAL? .WRD ,W?Q ,W?QUIT>
				      <V-QUIT>)
				     (<EQUAL? .WRD ,W?W ,W?WEST>
				      <RETURN <GOTO ,ROUND-ROOM>>)
				     (<EQUAL? .WRD ,W?E ,W?EAST>
				      <RETURN <GOTO ,DAMP-CAVE>>)
				     (<EQUAL? .WRD ,W?U ,W?UP>
				      <RETURN <GOTO ,DEEP-CANYON>>)
				     (<EQUAL? .WRD ,W?BUG>
				      <TELL "That's only your opinion." CR>)
				     (<EQUAL? .WRD ,W?ECHO>
				      <SETG LOUD-FLAG T>
				      <FCLEAR ,BAR ,SACREDBIT>
				      <TELL
"The acoustics of the room change subtly." CR>
				      <COND (<NOT ,SUPER-BRIEF> <CRLF>)>
				      <RETURN>)
				     ;(,DEAD <CRLF>)
				     (T
				      <V-ECHO>)>>)>)>>

<ROUTINE DEEP-CANYON-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are on the south edge of a deep canyon. Passages lead off to the
east, northwest and southwest. A stairway leads down.">
		<COND (<AND ,GATES-OPEN <NOT ,LOW-TIDE>>
		       <TELL
" You can hear a loud roaring sound, like that of rushing water, from
below.">)
		      (<AND <NOT ,GATES-OPEN> ,LOW-TIDE>
		       <CRLF>
		       <RTRUE>)
		      (T
		       <TELL
" You can hear the sound of flowing water from below.">)>
		<CRLF>)>>


<GLOBAL EGG-SOLVE <>>

\

"SUBTITLE A SEEDY LOOKING GENTLEMAN..."

<GLOBAL THIEF-HERE <>>

;"I-THIEF moved to DEMONS"

\

"SUBTITLE THINGS THIEF MIGHT DO"

"INTERACTION WITH ADVENTURER -- RETURNS T IF THIEF FINISHED."

<ROUTINE THIEF-VS-ADVENTURER (HERE? "AUX" ROBBED? (WINNER-ROBBED? <>))
  <COND (<AND <NOT ,DEAD> <EQUAL? ,HERE ,TREASURE-ROOM>>)
        (<NOT ,THIEF-HERE>
         <COND (<AND <NOT ,DEAD> <NOT .HERE?> <PROB 30>>
	        <COND (<IN? ,STILETTO ,THIEF>
		       <FCLEAR ,THIEF ,INVISIBLE>
		       <TELL
"Someone carrying a large bag is casually leaning against one of the
walls here. He does not speak, but it is clear from his aspect that
the bag will be taken only over his dead body." CR>
		       <SETG THIEF-HERE T>
		       <RTRUE>)
		      ;(<IN? ,STILETTO ,WINNER>
		       <MOVE ,STILETTO ,THIEF>
		       <FSET ,STILETTO ,NDESCBIT>
		       <FCLEAR ,THIEF ,INVISIBLE>
		       <TELL
"You feel a light finger-touch, and turning, notice a grinning figure
holding a large bag in one hand and a stiletto in the other.">
		       <SETG THIEF-HERE T>
		       <RTRUE>)>)
	       (<AND .HERE?
		     <FSET? ,THIEF ,FIGHTBIT>
		     <NOT <WINNING? ,THIEF>>>
		<TELL
"Your opponent, determining discretion to be the better part of
valor, decides to terminate this little contretemps. With a rueful
nod of his head, he steps backward into the gloom and disappears." CR>
		<FSET ,THIEF ,INVISIBLE>
		<FCLEAR ,THIEF ,FIGHTBIT>
		<RECOVER-STILETTO>
		<RTRUE>)
	       (<AND .HERE? <FSET? ,THIEF ,FIGHTBIT> <PROB 90>>
		<RFALSE>)
	       (<AND .HERE? <PROB 30>>
	        <TELL
"The holder of the large bag just left, looking disgusted.
Fortunately, he took nothing." CR>
		<FSET ,THIEF ,INVISIBLE>
		<RECOVER-STILETTO>
	        <RTRUE>)
	       (<PROB 70> <RFALSE>)
	       (<NOT ,DEAD>
		<COND (<ROB ,HERE ,THIEF 100>
		       <SET ROBBED? ,HERE>)
		      (<ROB ,WINNER ,THIEF>
		       <SET ROBBED? ,PLAYER>)>
		<SETG THIEF-HERE T>
	        <COND (<AND .ROBBED? <NOT .HERE?>>
		       <TELL
"A seedy-looking individual with a large bag just wandered through
the room. On the way through, he quietly abstracted some valuables from ">
		       <COND (<EQUAL? .ROBBED? ,HERE>
			      <TELL "the room">)
			     (ELSE
			      <TELL "your possession">)>
		       <TELL ", mumbling something about
\"Doing unto others before...\"" CR>
		       <STOLE-LIGHT?>)
		      (.HERE?
		       <RECOVER-STILETTO>
		       <COND (.ROBBED?
			      <TELL
"The thief just left, still carrying his large bag. You may
not have noticed that he ">
			      <COND (<EQUAL? .ROBBED? ,PLAYER>
				     <TELL
"robbed you blind first.">)
				    (T
				     <TELL
"appropriated the valuables in the room.">)>
			      <CRLF>
			      <STOLE-LIGHT?>)
			     (T
			      <TELL
"The thief, finding nothing of value, left disgusted." CR>)>
		       <FSET ,THIEF ,INVISIBLE>
		       <SET HERE? <>>
		       <RTRUE>)
		      (T
		       <TELL
"A \"lean and hungry\" gentleman just wandered through, carrying a
large bag. Finding nothing of value, he left disgruntled." CR>
		       <RTRUE>)>)>)
	(T
	 <COND (.HERE?			;"Here, already announced."
		<COND (<PROB 30>
		       <COND (<ROB ,HERE ,THIEF 100>
			      <SET ROBBED? ,HERE>)
			     (<ROB ,WINNER ,THIEF>
			      <SET ROBBED? ,PLAYER>)>
		       <COND (.ROBBED?
			      <TELL
"The thief just left, still carrying his large bag. You may
not have noticed that he ">
			      <COND (<EQUAL? .ROBBED? ,PLAYER>
				     <TELL
"robbed you blind first.">)
				    (T
				     <TELL
"appropriated the valuables in the room.">)>
			      <CRLF>
			      <STOLE-LIGHT?>)
			     (T
			      <TELL
"The thief, finding nothing of value, left disgusted." CR>)>
		       <FSET ,THIEF ,INVISIBLE>
		       <SET HERE? <>>
		       <RECOVER-STILETTO>)>)>)>
       <RFALSE>>

<ROUTINE STOLE-LIGHT? ("AUX" OLD-LIT)
	 <SET OLD-LIT ,LIT>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND <NOT ,LIT> .OLD-LIT>
		<TELL "The thief seems to have left you in the dark." CR>)>
	 <RTRUE>>

"SNARF STILETTO IF DROPPED IT"

;"RECOVER-STILETTO moved to DEMONS"

"PUT HIS BOOTY IN TREASURE ROOM"

<ROUTINE HACK-TREASURES ("AUX" X)
	 <RECOVER-STILETTO>
	 <FSET ,THIEF ,INVISIBLE>
	 <SET X <FIRST? ,TREASURE-ROOM>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN>)
		       (T <FCLEAR .X ,INVISIBLE>)>
		 <SET X <NEXT? .X>>>>

<ROUTINE DEPOSIT-BOOTY (RM "AUX" X N (FLG <>))
	 <SET X <FIRST? ,THIEF>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .FLG>)>
		 <SET N <NEXT? .X>>
		 <COND (<EQUAL? .X ,STILETTO ,LARGE-BAG>)
		       (<G? <GETP .X ,P?TVALUE> 0>
			<MOVE .X .RM>
			<SET FLG T>
			<COND (<EQUAL? .X ,EGG>
			       <SETG EGG-SOLVE T>
			       <FSET ,EGG ,OPENBIT>)>)>
		 <SET X .N>>>

"TAKE ALL OF THE VALUABLES SOMEWHERE AND PUT THEM SOMEWHERE ELSE"

"MOVED TO DEMONS"

"ROB MAZE"

<ROUTINE ROB-MAZE (RM "AUX" X N)
	 <SET X <FIRST? .RM>>
	 <REPEAT ()
		 <COND (<NOT .X> <RFALSE>)>
		 <SET N <NEXT? .X>>
		 <COND (<AND <FSET? .X ,TAKEBIT>
			     <NOT <FSET? .X ,INVISIBLE>>
			     <PROB 40>>
			<TELL
"You hear, off in the distance, someone saying \"My, I wonder what
this fine " D .X " is doing here.\"" CR>
			<COND (<PROB 60 80>
			       <MOVE .X ,THIEF>
			       <FSET .X ,TOUCHBIT>
			       <FSET .X ,INVISIBLE>)>
			<RETURN>)>
		 <SET X .N>>>

"STEAL SOME JUNK - moved to DEMONS"

"DROP SOME JUNK - moved to DEMONS"



\

"ROBBER-FUNCTION -- more prosaic thiefly occupations"

<GLOBAL THIEF-ENGROSSED <>>

<ROUTINE ROBBER-FUNCTION ("OPTIONAL" (MODE <>) "AUX" (FLG <>) X N)
	 <COND (<VERB? TELL>
		<TELL "The thief is a strong, silent type." CR>
		<SETG P-CONT <>>)
	       (<NOT .MODE>
		<COND (<AND <VERB? HELLO>
			    <EQUAL? <GETP ,THIEF ,P?LDESC> ,ROBBER-U-DESC>>
		       <TELL
"The thief, being temporarily incapacitated, is unable to acknowledge
your greeting with his usual graciousness." CR>)
		      (<AND <EQUAL? ,PRSO ,KNIFE>
			    <VERB? THROW>
			    <NOT <FSET? ,THIEF ,FIGHTBIT>>>
		       <MOVE ,PRSO ,HERE>
		       <COND (<PROB 10 0>
			      <TELL
"You evidently frightened the robber, though you didn't hit him. He
flees">
			      <REMOVE ,LARGE-BAG>
			      <SET X <>>
			      <COND (<IN? ,STILETTO ,THIEF>
				     <REMOVE ,STILETTO>
				     <SET X T>)>
			      <COND (<FIRST? ,THIEF>
				     <MOVE-ALL ,THIEF ,HERE>
				     <TELL
", but the contents of his bag fall on the floor.">)
				    (T
				     <TELL ".">)>
			      <MOVE ,LARGE-BAG ,THIEF>
			      <COND (.X <MOVE ,STILETTO ,THIEF>)>
			      <CRLF>
			      <FSET ,THIEF ,INVISIBLE>)
			     (T
			      <TELL
"You missed. The thief makes no attempt to take the knife, though it
would be a fine addition to the collection in his bag. He does seem
angered by your attempt." CR>
			      <FSET ,THIEF ,FIGHTBIT>)>)
		      (<AND <VERB? THROW GIVE>
			    ,PRSO
			    <NOT <EQUAL? ,PRSO ,THIEF>>
			    <EQUAL? ,PRSI ,THIEF>>
		       <COND (<L? <GETP ,THIEF ,P?STRENGTH> 0>
			      <PUTP ,THIEF
				    ,P?STRENGTH
				    <- <GETP ,THIEF ,P?STRENGTH>>>
			      <ENABLE <INT I-THIEF>>
			      <RECOVER-STILETTO>
			      <PUTP ,THIEF ,P?LDESC ,ROBBER-C-DESC>
			      <TELL
"Your proposed victim suddenly recovers consciousness." CR>)>
		       <MOVE ,PRSO ,THIEF>
		       <COND ;(<EQUAL? ,PRSO ,STILETTO>
			      <TELL
"The thief takes his stiletto and salutes you with a small nod of
his head." CR>)
			     (<G? <GETP ,PRSO ,P?TVALUE> 0>
			      <SETG THIEF-ENGROSSED T>
			      <TELL
"The thief is taken aback by your unexpected generosity, but accepts
the " D ,PRSO " and stops to admire its beauty." CR>)
			     (T
			      <TELL
"The thief places the " D ,PRSO " in his bag and thanks
you politely." CR>)>)
		      (<VERB? TAKE>
		       <TELL
"Once you got him, what would you do with him?" CR>)
		      (<VERB? EXAMINE LOOK-INSIDE>
		       <TELL
"The thief is a slippery character with beady eyes that flit back
and forth. He carries, along with an unmistakable arrogance, a large bag
over his shoulder and a vicious stiletto, whose blade is aimed
menacingly in your direction. I'd watch out if I were you." CR>)
		      (<VERB? LISTEN>
		       <TELL
"The thief says nothing, as you have not been formally introduced." CR>)>)
	       (<EQUAL? .MODE ,F-BUSY?>
		<COND (<IN? ,STILETTO ,THIEF> <>)
		      (<IN? ,STILETTO <LOC ,THIEF>>
		       <MOVE ,STILETTO ,THIEF>
		       <FSET ,STILETTO ,NDESCBIT>
		       <COND (<IN? ,THIEF ,HERE>
			      <TELL
"The robber, somewhat surprised at this turn of events, nimbly
retrieves his stiletto." CR>)>
		       T)>)
	       (<EQUAL? .MODE ,F-DEAD>
		<MOVE ,STILETTO ,HERE>
		<FCLEAR ,STILETTO ,NDESCBIT>
		<SET X <DEPOSIT-BOOTY ,HERE>>
		<COND (<EQUAL? ,HERE ,TREASURE-ROOM>
		       <SET X <FIRST? ,HERE>>
		       <REPEAT ()
			       <COND
				(<NOT .X>
				 <TELL "The chalice is now safe to take." CR>
				 <RETURN>)
				(<NOT <EQUAL? .X ,CHALICE ,THIEF ,ADVENTURER>>
				 <FCLEAR .X ,INVISIBLE>
				 <COND (<NOT .FLG>
					<SET FLG T>
					<TELL
"As the thief dies, the power of his magic decreases, and his
treasures reappear:" CR>)>
				 <TELL "  A " D .X>
				 <COND (<AND <FIRST? .X>
					     <SEE-INSIDE? .X>>
					<TELL ", with ">
					<PRINT-CONTENTS .X>)>
				 <CRLF>)>
			       <SET X <NEXT? .X>>>)
		      (.X
		       <TELL "His booty remains." CR>)>
		<DISABLE <INT I-THIEF>>)
	       (<EQUAL? .MODE ,F-FIRST?>
		<COND (<AND ,THIEF-HERE
			    <NOT <FSET? ,THIEF ,INVISIBLE>>
			    <PROB 20>>
		       <FSET ,THIEF ,FIGHTBIT>
		       <SETG P-CONT <>>
		       T)>)
	       (<EQUAL? .MODE ,F-UNCONSCIOUS>
		<DISABLE <INT I-THIEF>>
		<FCLEAR ,THIEF ,FIGHTBIT>
		<MOVE ,STILETTO ,HERE>
		<FCLEAR ,STILETTO ,NDESCBIT>
		<PUTP ,THIEF ,P?LDESC ,ROBBER-U-DESC>)
	       (<EQUAL? .MODE ,F-CONSCIOUS>
		<COND (<EQUAL? <LOC ,THIEF> ,HERE>
		       <FSET ,THIEF ,FIGHTBIT>
		       <TELL
"The robber revives, briefly feigning continued unconsciousness, and,
when he sees his moment, scrambles away from you." CR>)>
		<ENABLE <INT I-THIEF>>
		<PUTP ,THIEF ,P?LDESC ,ROBBER-C-DESC>
		<RECOVER-STILETTO>)>>

<GLOBAL ROBBER-C-DESC
"There is a suspicious-looking individual, holding a bag, leaning
against one wall. He is armed with a vicious-looking stiletto.">

<GLOBAL ROBBER-U-DESC
"There is a suspicious-looking individual lying unconscious on the
ground.">

<ROUTINE LARGE-BAG-F ()
	 <COND (<VERB? TAKE>
		<COND (<EQUAL? <GETP ,THIEF ,P?LDESC> ,ROBBER-U-DESC>
		       <TELL
"Sadly for you, the robber collapsed on top of the bag. Trying to take
it would wake him." CR>)
		      (T
		       <TELL
"The bag will be taken over his dead body." CR>)>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,LARGE-BAG>>
		<TELL "It would be a good trick." CR>)
	       (<VERB? OPEN CLOSE>
		<TELL
"Getting close enough would be a good trick." CR>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"The bag is underneath the thief, so one can't say what, if anything, is
inside." CR>)>>

<ROUTINE MOVE-ALL (FROM TO "AUX" X N)
	 <COND (<SET X <FIRST? .FROM>>
		<REPEAT ()
			<COND (<NOT .X> <RETURN>)>
			<SET N <NEXT? .X>>
			<FCLEAR .X ,INVISIBLE>
			<MOVE .X .TO>
			<SET X .N>>)>>

<ROUTINE CHALICE-FCN ()
	 <COND (<VERB? TAKE>
		<COND (<AND <IN? ,PRSO ,TREASURE-ROOM>
			    <IN? ,THIEF ,TREASURE-ROOM>
			    <FSET? ,THIEF ,FIGHTBIT>
			    <NOT <FSET? ,THIEF ,INVISIBLE>>
			    <NOT <EQUAL? <GETP ,THIEF ,P?LDESC>
					 ,ROBBER-U-DESC>>>
		       <TELL
"You'd be stabbed in the back first." CR>)>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI ,CHALICE>>
		<TELL
"You can't. It's not a very good chalice, is it?" CR>)
	       (T <DUMB-CONTAINER>)>>

<ROUTINE TREASURE-ROOM-FCN (RARG "AUX" TL)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <1? <GET <INT I-THIEF> ,C-ENABLED?>>
		     <NOT ,DEAD>>
		<COND (<NOT <IN? ,THIEF ,HERE>>
		       <TELL
"You hear a scream of anguish as you violate the robber's hideaway.
Using passages unknown to you, he rushes to its defense." CR>
		       <MOVE ,THIEF ,HERE>)>
		<FSET ,THIEF ,FIGHTBIT>
		<FCLEAR ,THIEF ,INVISIBLE>
		<THIEF-IN-TREASURE>)>>

<ROUTINE THIEF-IN-TREASURE ("AUX" F N)
	 <SET F <FIRST? ,HERE>>
	 <COND (<AND .F <NEXT? .F>>
		<TELL
"The thief gestures mysteriously, and the treasures in the room
suddenly vanish." CR CR>)>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (<NOT <EQUAL? .F ,CHALICE ,THIEF>>
			<FSET .F ,INVISIBLE>)>
		 <SET F <NEXT? .F>>>>

<ROUTINE FRONT-DOOR-FCN ()
	 <COND (<VERB? OPEN>
		<TELL "The door cannot be opened." CR>)
	       (<VERB? BURN>
		<TELL
		 "You cannot burn this door." CR>)
	       (<VERB? MUNG>
		<TELL "You can't seem to damage the door." CR>)
	       (<VERB? LOOK-BEHIND>
		<TELL "It won't open." CR>)>>

\

"SUBTITLE RANDOM FUNCTIONS"

<ROUTINE BODY-FUNCTION ()
	 <COND (<VERB? TAKE>
		<TELL "A force keeps you from taking the bodies." CR>)
	       (<VERB? MUNG BURN>
		<JIGS-UP
"The voice of the guardian of the dungeon booms out from the darkness,
\"Your disrespect costs you your life!\" and places your head on a sharp
pole.">)>>

<ROUTINE BLACK-BOOK ()
	 <COND (<VERB? OPEN>
		<TELL "The book is already open to page 569." CR>)
	       (<VERB? CLOSE>
		<TELL "As hard as you try, the book cannot be closed." CR>)
	       (<OR <VERB? TURN>
		    <AND <VERB? READ-PAGE>
			 <EQUAL? ,PRSI ,INTNUM>
			 <NOT <EQUAL? ,P-NUMBER 569>>>>
		<TELL
"Beside page 569, there is only one other page with any legible printing on
it. Most of it is unreadable, but the subject seems to be the banishment of
evil. Apparently, certain noises, lights, and prayers are efficacious in this
regard." CR>)
	       (<VERB? BURN>
		<REMOVE-CAREFULLY ,PRSO>
		<JIGS-UP
"A booming voice says \"Wrong, cretin!\" and you notice that you have
turned into a pile of dust. How, I can't imagine.">)>>

<ROUTINE PAINTING-FCN ()
	 <COND (<VERB? MUNG>
		<PUTP ,PRSO ,P?TVALUE 0>
		<PUTP ,PRSO ,P?LDESC
"There is a worthless piece of canvas here.">
		<TELL
"Congratulations! Unlike the other vandals, who merely stole the
artist's masterpieces, you have destroyed one." CR>)>>

\

"SUBTITLE LET THERE BE LIGHT SOURCES"

<GLOBAL LAMP-TABLE
	<TABLE (PURE)
	       10000                                           ;"Modification: Original value was 100"
	       "The lamp appears a bit dimmer."
	       70
	       "The lamp is definitely dimmer now."
	       15   
	       "The lamp is nearly out."
	       0>>

<ROUTINE LANTERN ()
	 <COND (<VERB? THROW>
		<TELL
"The lamp has smashed into the floor, and the light has gone out." CR>
		<DISABLE <INT I-LANTERN>>
		<REMOVE-CAREFULLY ,LAMP>
		<MOVE ,BROKEN-LAMP ,HERE>)
	       (<VERB? LAMP-ON>
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "A burned-out lamp won't light." CR>)
		      (T
		       <ENABLE <INT I-LANTERN>>
		       <>)>)
	       (<VERB? LAMP-OFF>
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "The lamp has already burned out." CR>)
		      (T
		       <DISABLE <INT I-LANTERN>>
		       <>)>)
	       (<VERB? EXAMINE>
		<TELL "The lamp ">
		<COND (<FSET? ,LAMP ,RMUNGBIT>
		       <TELL "has burned out.">)
		      (<FSET? ,LAMP ,ONBIT>
		       <TELL "is on.">)
		      (T
		       <TELL "is turned off.">)>
		<CRLF>)>>

<ROUTINE MAILBOX-F ()
	 <COND (<AND <VERB? TAKE> <EQUAL? ,PRSO ,MAILBOX>>
		<TELL "It is securely anchored." CR>)>>

<GLOBAL MATCH-COUNT 6>

<ROUTINE MATCH-FUNCTION ("AUX" CNT)
	 <COND (<AND <VERB? LAMP-ON BURN> <EQUAL? ,PRSO ,MATCH>>
		<COND (<G? ,MATCH-COUNT 0>
		       <SETG MATCH-COUNT <- ,MATCH-COUNT 1>>)>
		<COND (<NOT <G? ,MATCH-COUNT 0>>
		       <TELL
			"I'm afraid that you have run out of matches." CR>)
		      (<EQUAL? ,HERE ,LOWER-SHAFT ,TIMBER-ROOM>
		       <TELL
"This room is drafty, and the match goes out instantly." CR>)
		      (T
		       <FSET ,MATCH ,FLAMEBIT>
		       <FSET ,MATCH ,ONBIT>
		       <ENABLE <QUEUE I-MATCH 2>>
		       <TELL "One of the matches starts to burn." CR>
		       <COND (<NOT ,LIT>
			      <SETG LIT T>
			      <V-LOOK>)>
		       <RTRUE>)>)
	       (<AND <VERB? LAMP-OFF> <FSET? ,MATCH ,FLAMEBIT>>
		<TELL "The match is out." CR>
		<FCLEAR ,MATCH ,FLAMEBIT>
		<FCLEAR ,MATCH ,ONBIT>
		<SETG LIT <LIT? ,HERE>>
		<COND (<NOT ,LIT> <TELL "It's pitch black in here!" CR>)>
		<QUEUE I-MATCH 0>
		<RTRUE>)
	       (<VERB? COUNT OPEN>
		<TELL "You have ">
	        <SET CNT <- ,MATCH-COUNT 1>>
		<COND (<NOT <G? .CNT 0>> <TELL "no">)
		      (T <TELL N .CNT>)>
		<TELL " match">
		<COND (<NOT <1? .CNT>> <TELL "es.">) (T <TELL ".">)>
		<CRLF>)
	       (<VERB? EXAMINE>
		<COND (<FSET? ,MATCH ,ONBIT>
		       <TELL "The match is burning.">)
		      (T
		       <TELL
"The matchbook isn't very interesting, except for what's written on it.">)>
		<CRLF>)>>

<ROUTINE I-MATCH ()
	 <TELL "The match has gone out." CR>
	 <FCLEAR ,MATCH ,FLAMEBIT>
	 <FCLEAR ,MATCH ,ONBIT>
	 <SETG LIT <LIT? ,HERE>>
	 <RTRUE>>

<ROUTINE I-LANTERN ("AUX" TICK (TBL <VALUE LAMP-TABLE>))
	 <ENABLE <QUEUE I-LANTERN <SET TICK <GET .TBL 0>>>>
	 <LIGHT-INT ,LAMP .TBL .TICK>
	 <COND (<NOT <0? .TICK>>
		<SETG LAMP-TABLE <REST .TBL 4>>)>>

<ROUTINE I-CANDLES ("AUX" TICK (TBL <VALUE CANDLE-TABLE>))
	 <FSET ,CANDLES ,TOUCHBIT>
	 <ENABLE <QUEUE I-CANDLES <SET TICK <GET .TBL 0>>>>
	 <LIGHT-INT ,CANDLES .TBL .TICK>
	 <COND (<NOT <0? .TICK>>
		<SETG CANDLE-TABLE <REST .TBL 4>>)>>

<ROUTINE LIGHT-INT (OBJ TBL TICK)
	 <COND (<0? .TICK>
		<FCLEAR .OBJ ,ONBIT>
		<FSET .OBJ ,RMUNGBIT>)>
	 <COND (<OR <HELD? .OBJ> <IN? .OBJ ,HERE>>
		<COND (<0? .TICK>
		       <TELL
"You'd better have more light than from the " D .OBJ "." CR>)
		      (T
		       <TELL <GET .TBL 1> CR>)>)>>

<ROUTINE MIN (N1 N2)
	 <COND (<L? .N1 .N2> .N1)
	       (T .N2)>>

<ROUTINE CANDLES-FCN ()
	 <COND (<NOT <FSET? ,CANDLES ,TOUCHBIT>>
		<ENABLE <INT I-CANDLES>>)>
	 <COND (<EQUAL? ,CANDLES ,PRSI> <RFALSE>)
	       (T
		<COND (<VERB? LAMP-ON BURN>
		       <COND (<FSET? ,CANDLES ,RMUNGBIT>
			      <TELL
"Alas, there's not much left of the candles. Certainly not enough to
burn." CR>)
			     (<NOT ,PRSI>
			      <COND (<FSET? ,MATCH ,FLAMEBIT>
				     <TELL "(with the match)" CR>
				     <PERFORM ,V?LAMP-ON ,CANDLES ,MATCH>
				     <RTRUE>)
				    (T
				     <TELL
"You should say what to light them with." CR>
				     <RFATAL>)>)
			     (<AND <EQUAL? ,PRSI ,MATCH>
				   <FSET? ,MATCH ,ONBIT>>
			      <TELL "The candles are ">
			      <COND (<FSET? ,CANDLES ,ONBIT>
				     <TELL "already lit." CR>)
				    (T
				     <FSET ,CANDLES ,ONBIT>
				     <TELL "lit." CR>
				     <ENABLE <INT I-CANDLES>>)>)
			     (<EQUAL? ,PRSI ,TORCH>
			      <COND (<FSET? ,CANDLES ,ONBIT>
				     <TELL
"You realize, just in time, that the candles are already lighted." CR>)
				    (T
				     <TELL
"The heat from the torch is so intense that the candles are vaporized." CR>
				     <REMOVE-CAREFULLY ,CANDLES>)>)
			     (T
			      <TELL
"You have to light them with something that's burning, you know." CR>)>)
		      (<VERB? COUNT>
		       <TELL
"Let's see, how many objects in a pair? Don't tell me, I'll get it." CR>)
		      (<VERB? LAMP-OFF>
		       <DISABLE <INT I-CANDLES>>
		       <COND (<FSET? ,CANDLES ,ONBIT>
			      <TELL "The flame is extinguished.">
			      <FCLEAR ,CANDLES ,ONBIT>
			      <FSET ,CANDLES ,TOUCHBIT>
			      <SETG LIT <LIT? ,HERE>>
			      <COND (<NOT ,LIT>
				     <TELL " It's really dark in here....">)>
			      <CRLF>
			      <RTRUE>)
			     (T <TELL "The candles are not lighted." CR>)>)
		      (<AND <VERB? PUT> <FSET? ,PRSI ,BURNBIT>>
		       <TELL "That wouldn't be smart." CR>)
		      (<VERB? EXAMINE>
		       <TELL "The candles are ">
		       <COND (<FSET? ,CANDLES ,ONBIT>
			      <TELL "burning.">)
			     (T <TELL "out.">)>
		       <CRLF>)>)>>

<GLOBAL CANDLE-TABLE
	<TABLE (PURE)
	       20
	       "The candles grow shorter."
	       10
	       "The candles are becoming quite short."
	       5
	       "The candles won't last long now."
	       0>>

<ROUTINE CAVE2-ROOM (RARG)
  <COND (<EQUAL? .RARG ,M-END>
	 <COND (<AND <IN? ,CANDLES ,WINNER>
		     <PROB 50 80>
		     <FSET? ,CANDLES ,ONBIT>>
		<DISABLE <INT I-CANDLES>>
		<FCLEAR ,CANDLES ,ONBIT>
		<TELL
"A gust of wind blows out your candles!" CR>
		<COND (<NOT <SETG LIT <LIT? ,HERE>>>
		       <TELL "It is now completely dark." CR>)>)>)>>

\

"SUBTITLE ASSORTED WEAPONS"

<ROUTINE SWORD-FCN ("AUX" G)
	 <COND (<AND <VERB? TAKE> <EQUAL? ,WINNER ,ADVENTURER>>
		<ENABLE <QUEUE I-SWORD -1>>
		<>)
	       (<VERB? EXAMINE>
		<COND (<EQUAL? <SET G <GETP ,SWORD ,P?TVALUE>> 1>
		       <TELL
"Your sword is glowing with a faint blue glow." CR>)
		      (<EQUAL? .G 2>
		       <TELL
"Your sword is glowing very brightly." CR>)>)>>

"SUBTITLE COAL MINE"

<ROUTINE BOOM-ROOM (RARG "AUX" (DUMMY? <>) FLAME)
         <COND (<EQUAL? .RARG ,M-END>
		<COND (<AND <EQUAL? .RARG ,M-END>
			    <VERB? LAMP-ON BURN>
			    <EQUAL? ,PRSO ,CANDLES ,TORCH ,MATCH>>
		       <SET DUMMY? T>)>
		<COND (<OR <AND <HELD? ,CANDLES>
				<FSET? ,CANDLES ,ONBIT>>
			   <AND <HELD? ,TORCH>
				<FSET? ,TORCH ,ONBIT>>
			   <AND <HELD? ,MATCH>
				<FSET? ,MATCH ,ONBIT>>>
		       <COND (.DUMMY?
			      <TELL
"How sad for an aspiring adventurer to light a " D ,PRSO " in a room which
reeks of gas. Fortunately, there is justice in the world." CR>)
			     (T
			      <TELL
"Oh dear. It appears that the smell coming from this room was coal gas.
I would have thought twice about carrying flaming objects in here." CR>)>
		       <JIGS-UP "|
      ** BOOOOOOOOOOOM **">)>)>> 

<ROUTINE BAT-D ("OPTIONAL" FOO)
	 <COND (<EQUAL? <LOC ,GARLIC> ,WINNER ,HERE>
		<TELL
"In the corner of the room on the ceiling is a large vampire bat who
is obviously deranged and holding his nose." CR>)
	       (T
		<TELL
"A large vampire bat, hanging from the ceiling, swoops down at you!" CR>)>>

<ROUTINE BATS-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are in a small room which has doors only to the east and south." CR>)
	       (<AND <EQUAL? .RARG ,M-ENTER> <NOT ,DEAD>>
		<COND (<NOT <EQUAL? <LOC ,GARLIC> ,WINNER ,HERE>>
		       <V-LOOK>
		       <CRLF>
		       <FLY-ME>)>)>>

<ROUTINE MACHINE-ROOM-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a large, cold room whose sole exit is to the north. In one
corner there is a machine which is reminiscent of a clothes
dryer. On its face is a switch which is labelled \"START\".
The switch does not appear to be manipulable by any human hand (unless the
fingers are about 1/16 by 1/4 inch). On the front of the machine is a large
lid, which is ">
		<COND (<FSET? ,MACHINE ,OPENBIT>
		       <TELL "open.">)
		      (T <TELL "closed.">)>
		<CRLF>)>>

<ROUTINE MACHINE-F ()
	 <COND (<AND <VERB? TAKE> <EQUAL? ,PRSO ,MACHINE>>
		<TELL "It is far too large to carry." CR>)
	       (<VERB? OPEN>
	        <COND (<FSET? ,MACHINE ,OPENBIT>
		       <TELL <PICK-ONE ,DUMMY> CR>)
		      (<FIRST? ,MACHINE>
		       <TELL "The lid opens, revealing ">
		       <PRINT-CONTENTS ,MACHINE>
		       <TELL "." CR>
		       <FSET ,MACHINE ,OPENBIT>)
		      (T
		       <TELL "The lid opens." CR>
		       <FSET ,MACHINE ,OPENBIT>)>)
	       (<VERB? CLOSE>
	        <COND (<FSET? ,MACHINE ,OPENBIT>
		       <TELL "The lid closes." CR>
		       <FCLEAR ,MACHINE ,OPENBIT>
		       T)
		      (T
		       <TELL <PICK-ONE ,DUMMY> CR>)>)
	       (<VERB? LAMP-ON>
		<COND (<NOT ,PRSI>
		       <TELL
"It's not clear how to turn it on with your bare hands." CR>)
		      (T
		       <PERFORM ,V?TURN ,MACHINE-SWITCH ,PRSI>
		       <RTRUE>)>)>>

<ROUTINE MSWITCH-FUNCTION ("AUX" O)
	 <COND (<VERB? TURN>
		<COND (<EQUAL? ,PRSI ,SCREWDRIVER>
		       <COND (<FSET? ,MACHINE ,OPENBIT>
			      <TELL
"The machine doesn't seem to want to do anything." CR>)
			     (T <TELL
"The machine comes to life (figuratively) with a dazzling display of
colored lights and bizarre noises. After a few moments, the
excitement abates." CR>
			      <COND (<IN? ,COAL ,MACHINE>
				     <REMOVE-CAREFULLY ,COAL>
				     <MOVE ,DIAMOND ,MACHINE>)
				    (T
				     <REPEAT ()
					     <COND (<SET O <FIRST? ,MACHINE>>
						    <REMOVE-CAREFULLY .O>)
						   (T <RETURN>)>>
				     <MOVE ,GUNK ,MACHINE>)>)>)
		      (T
		       <TELL "It seems that a " D ,PRSI " won't do." CR>)>)>>

<ROUTINE GUNK-FUNCTION ()
	 <REMOVE-CAREFULLY ,GUNK>
	 <TELL
"The slag was rather insubstantial, and crumbles into dust at your touch." CR>>

<ROUTINE NO-OBJS (RARG "AUX" F)
	 <COND (<EQUAL? .RARG ,M-BEG>
		<SET F <FIRST? ,WINNER>>
		<SETG EMPTY-HANDED T>
		<REPEAT ()
			<COND (<NOT .F> <RETURN>)
			      (<G? <WEIGHT .F> 4>
			       <SETG EMPTY-HANDED <>>
			       <RETURN>)>
			<SET F <NEXT? .F>>>
		<COND (<AND <EQUAL? ,HERE ,LOWER-SHAFT> ,LIT>
		       <SCORE-UPD ,LIGHT-SHAFT>
		       <SETG LIGHT-SHAFT 0>)>
		<RFALSE>)>>

<ROUTINE SOUTH-TEMPLE-FCN (RARG)
	 <COND (<EQUAL? .RARG ,M-BEG>
		<SETG COFFIN-CURE <NOT <IN? ,COFFIN ,WINNER>>>
		<RFALSE>)>>

<GLOBAL LIGHT-SHAFT 13>
<GDECL (LIGHT-SHAFT) FIX>

\

"SUBTITLE OLD MAN RIVER, THAT OLD MAN RIVER..."

<ROUTINE WHITE-CLIFFS-FUNCTION (RARG)
	 <COND (<EQUAL? .RARG ,M-END>
		<COND (<IN? ,INFLATED-BOAT ,WINNER>
		       <SETG DEFLATE <>>)
	       	      (T
		       <SETG DEFLATE T>)>)>>

<ROUTINE SCEPTRE-FUNCTION ()
	 <COND (<VERB? WAVE RAISE>
		<COND (<OR <EQUAL? ,HERE ,ARAGAIN-FALLS>
			   <EQUAL? ,HERE ,END-OF-RAINBOW>>
		       <COND (<NOT ,RAINBOW-FLAG>
			      <FCLEAR ,POT-OF-GOLD ,INVISIBLE>
			      <TELL
"Suddenly, the rainbow appears to become solid and, I venture,
walkable (I think the giveaway was the stairs and bannister)." CR>
			      <COND (<AND <EQUAL? ,HERE ,END-OF-RAINBOW>
					  <IN? ,POT-OF-GOLD ,END-OF-RAINBOW>>
				     <TELL
"A shimmering pot of gold appears at the end of the rainbow." CR>)>
			      <SETG RAINBOW-FLAG T>)
			     (T
			      <ROB ,ON-RAINBOW ,WALL>
			      <TELL
"The rainbow seems to have become somewhat run-of-the-mill." CR>
			      <SETG RAINBOW-FLAG <>>
			      <RTRUE>)>)
		      (<EQUAL? ,HERE ,ON-RAINBOW>
		       <SETG RAINBOW-FLAG <>>
		       <JIGS-UP
"The structural integrity of the rainbow is severely compromised,
leaving you hanging in midair, supported only by water vapor. Bye.">)
		      (T
		       <TELL
"A dazzling display of color briefly emanates from the sceptre." CR>)>)>>

<ROUTINE FALLS-ROOM (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
	   <TELL
"You are at the top of Aragain Falls, an enormous waterfall with a
drop of about 450 feet. The only path here is on the north end." CR>
	   <COND (,RAINBOW-FLAG
		  <TELL
"A solid rainbow spans the falls.">)
		 (T
		  <TELL
"A beautiful rainbow can be seen over the falls and to the west.">)>
	   <CRLF>)>>

<ROUTINE RAINBOW-FCN ()
	 <COND (<VERB? CROSS THROUGH>
		<COND (<EQUAL? ,HERE ,CANYON-VIEW>
		       <TELL "From here?!?" CR>
		       <RTRUE>)>
		<COND (,RAINBOW-FLAG
		       <COND (<EQUAL? ,HERE ,ARAGAIN-FALLS>
			      <GOTO ,END-OF-RAINBOW>)
			     (<EQUAL? ,HERE ,END-OF-RAINBOW>
			      <GOTO ,ARAGAIN-FALLS>)
			     (T
			      <TELL "You'll have to say which way..." CR>)>)
		      (T
		       <TELL "Can you walk on water vapor?"
			     CR>)>)
	       (<VERB? LOOK-UNDER>
		<TELL "The Frigid River flows under the rainbow." CR>)>>

<ROUTINE DBOAT-FUNCTION ("AUX")
	 <COND (<AND <VERB? PUT PUT-ON>
		     <EQUAL? ,PRSO ,PUTTY>>
		<FIX-BOAT>)
	       (<VERB? INFLATE FILL>
		<TELL
"No chance. Some moron punctured it." CR>)
	       (<VERB? PLUG>
		<COND (<EQUAL? ,PRSI ,PUTTY>
		       <FIX-BOAT>)
		      (T <WITH-TELL ,PRSI>)>)>>

<ROUTINE FIX-BOAT ()
	 <TELL "Well done. The boat is repaired." CR>
	 <MOVE ,INFLATABLE-BOAT <LOC ,PUNCTURED-BOAT>>
	 <REMOVE-CAREFULLY ,PUNCTURED-BOAT>>

<ROUTINE RIVER-FUNCTION ()
	 <COND (<VERB? PUT>
		<COND (<EQUAL? ,PRSI ,RIVER>
		       <COND (<EQUAL? ,PRSO ,ME>
			      <JIGS-UP
"You splash around for a while, fighting the current, then you drown.">)
			     (<EQUAL? ,PRSO ,INFLATED-BOAT>
			      <TELL
"You should get in the boat then launch it." CR>)
			     (<FSET? ,PRSO ,BURNBIT>
			      <REMOVE-CAREFULLY ,PRSO>
			      <TELL
"The " D ,PRSO " floats for a moment, then sinks." CR>)
			     (T
			      <REMOVE-CAREFULLY ,PRSO>
			      <TELL
"The " D ,PRSO " splashes into the water and is gone forever." CR>)>)>)
	       (<VERB? LEAP THROUGH>
		<TELL
"A look before leaping reveals that the river is wide and dangerous,
with swift currents and large, half-hidden rocks. You decide to forgo your
swim." CR>)>>

<GLOBAL RIVER-SPEEDS
	<LTABLE (PURE) RIVER-1 4 RIVER-2 4 RIVER-3 3 RIVER-4 2 RIVER-5 1>>

<GLOBAL RIVER-NEXT
	<LTABLE (PURE) RIVER-1 RIVER-2 RIVER-3 RIVER-4 RIVER-5>>

<GLOBAL RIVER-LAUNCH
	<LTABLE (PURE) DAM-BASE RIVER-1
		WHITE-CLIFFS-NORTH RIVER-3
		WHITE-CLIFFS-SOUTH RIVER-4
		SHORE RIVER-5
		SANDY-BEACH RIVER-4
		RESERVOIR-SOUTH RESERVOIR
		RESERVOIR-NORTH RESERVOIR
		STREAM-VIEW IN-STREAM>>

<ROUTINE I-RIVER ("AUX" RM)
	 <COND (<AND <NOT <EQUAL? ,HERE ,RIVER-1 ,RIVER-2 ,RIVER-3>>
		     <NOT <EQUAL? ,HERE ,RIVER-4 ,RIVER-5>>>
		<DISABLE <INT I-RIVER>>)
	       (<SET RM <LKP ,HERE ,RIVER-NEXT>>
		<TELL "The flow of the river carries you downstream." CR CR>
		<GOTO .RM>
		<ENABLE <QUEUE I-RIVER <LKP ,HERE ,RIVER-SPEEDS>>>)
	       (T
		<JIGS-UP
"Unfortunately, the magic boat doesn't provide protection from
the rocks and boulders one meets at the bottom of waterfalls.
Including this one.">)>>

<ROUTINE RBOAT-FUNCTION ("OPTIONAL" (RARG <>) "AUX" TMP)
    <COND (<EQUAL? .RARG ,M-ENTER ,M-END ,M-LOOK> <>)	
	  (<EQUAL? .RARG ,M-BEG>
	   <COND (<VERB? WALK>
		  <COND (<EQUAL? ,PRSO ,P?LAND ,P?EAST ,P?WEST>
			 <RFALSE>)
			(<AND <EQUAL? ,HERE ,RESERVOIR>
			      <EQUAL? ,PRSO ,P?NORTH ,P?SOUTH>>
			 <RFALSE>)
			(<AND <EQUAL? ,HERE ,IN-STREAM>
			      <EQUAL? ,PRSO ,P?SOUTH>>
			 <RFALSE>)
			(T
			 <TELL
"Read the label for the boat's instructions." CR>
			 <RTRUE>)>)
		 (<VERB? LAUNCH>
		  <COND (<OR <EQUAL? ,HERE ,RIVER-1 ,RIVER-2 ,RIVER-3>
			     <EQUAL? ,HERE ,RIVER-4 ,RESERVOIR ,IN-STREAM>>
			 <TELL
"You are on the ">
			 <COND (<EQUAL? ,HERE ,RESERVOIR>
				<TELL "reservoir">)
			       (<EQUAL? ,HERE ,IN-STREAM>
				<TELL "stream">)
			       (T <TELL "river">)>
			 <TELL ", or have you forgotten?" CR>)
			(<EQUAL? <SET TMP <GO-NEXT ,RIVER-LAUNCH>> 1>
			 <ENABLE <QUEUE I-RIVER <LKP ,HERE ,RIVER-SPEEDS>>>
			 <RTRUE>)
			(<NOT <EQUAL? .TMP 2>>
			 <TELL "You can't launch it here." CR>
			 <RTRUE>)
			(T <RTRUE>)>)
		 (<OR <AND <VERB? DROP>
			   <FSET? ,PRSO ,WEAPONBIT>>
		      <AND <VERB? PUT>
			   <FSET? ,PRSO ,WEAPONBIT>
			   <EQUAL? ,PRSI ,INFLATED-BOAT>>
		      <AND <VERB? ATTACK MUNG>
			   <FSET? ,PRSI ,WEAPONBIT>>>
		  <REMOVE-CAREFULLY ,INFLATED-BOAT>
		  <MOVE ,PUNCTURED-BOAT ,HERE>
		  <ROB ,INFLATED-BOAT ,HERE>
		  <MOVE ,WINNER ,HERE>
		  <TELL
"It seems that the ">
		  <COND (<VERB? DROP PUT> <TELL D ,PRSO>)
			(T <TELL D ,PRSI>)>
		  <TELL " didn't agree with the boat, as evidenced
by the loud hissing noise issuing therefrom. With a pathetic sputter, the
boat deflates, leaving you without." CR>
		  <COND (<FSET? ,HERE ,NONLANDBIT>
			 <CRLF>
			 <COND (<==? ,HERE ,RESERVOIR ,IN-STREAM>
				<JIGS-UP
"Another pathetic sputter, this time from you, heralds your drowning.">)
			       (T
				<JIGS-UP
"In other words, fighting the fierce currents of the Frigid River. You
manage to hold your own for a bit, but then you are carried over a
waterfall and into some nasty rocks. Ouch!">)>)>
		  <RTRUE>)
		 (<VERB? LAUNCH>
	  	   <TELL "You're not in the boat!" CR>)>)
	  (<VERB? BOARD>
	   <COND (<OR <IN? ,SCEPTRE ,WINNER>
		      <IN? ,KNIFE ,WINNER>
		      <IN? ,SWORD ,WINNER>
		      <IN? ,RUSTY-KNIFE ,WINNER>
		      <IN? ,AXE ,WINNER>
		      <IN? ,STILETTO ,WINNER>>
		  <TELL
"Oops! Something sharp seems to have slipped and punctured the boat.
The boat deflates to the sounds of hissing, sputtering, and cursing." CR>
		  <REMOVE-CAREFULLY ,INFLATED-BOAT>
		  <MOVE ,PUNCTURED-BOAT ,HERE>
		  <THIS-IS-IT ,PUNCTURED-BOAT>
		  T)>)
	  (<VERB? INFLATE FILL>
	   <TELL "Inflating it further would probably burst it." CR>)
	  (<VERB? DEFLATE>
	   <COND (<EQUAL? <LOC ,WINNER> ,INFLATED-BOAT>
		  <TELL
"You can't deflate the boat while you're in it." CR>)
		 (<NOT <IN? ,INFLATED-BOAT ,HERE>>
		  <TELL
"The boat must be on the ground to be deflated." CR>)
		 (T <TELL
"The boat deflates." CR>
		  <SETG DEFLATE T>
		  <REMOVE-CAREFULLY ,INFLATED-BOAT>
		  <MOVE ,INFLATABLE-BOAT ,HERE>
		  <THIS-IS-IT ,INFLATABLE-BOAT>)>)>>

<ROUTINE BREATHE ()
	 <PERFORM ,V?INFLATE ,PRSO ,LUNGS>>

<ROUTINE IBOAT-FUNCTION ()
	 <COND (<VERB? INFLATE FILL>
		<COND (<NOT <IN? ,INFLATABLE-BOAT ,HERE>>
		       <TELL
"The boat must be on the ground to be inflated." CR>)
		      (<EQUAL? ,PRSI ,PUMP>
		       <TELL
"The boat inflates and appears seaworthy." CR>
		       <COND (<NOT <FSET? ,BOAT-LABEL ,TOUCHBIT>>
			      <TELL
"A tan label is lying inside the boat." CR>)>
		       <SETG DEFLATE <>>
		       <REMOVE-CAREFULLY ,INFLATABLE-BOAT>
		       <MOVE ,INFLATED-BOAT ,HERE>
		       <THIS-IS-IT ,INFLATED-BOAT>)
		      (<EQUAL? ,PRSI ,LUNGS>
		       <TELL
"You don't have enough lung power to inflate it." CR>)
		      (T
		       <TELL
"With a " D ,PRSI "? Surely you jest!" CR>)>)>>

<GLOBAL BUOY-FLAG T>

<ROUTINE RIVR4-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-END>
		<COND (<AND <IN? ,BUOY ,WINNER> ,BUOY-FLAG>
	      	       <TELL
"You notice something funny about the feel of the buoy." CR>
		       <SETG BUOY-FLAG <>>)>)>>

<GLOBAL BEACH-DIG -1>

<GDECL (BEACH-DIG) FIX>

<ROUTINE SAND-FUNCTION ()
	 <COND (<AND <VERB? DIG> <==? ,PRSI ,SHOVEL>>
		<SETG BEACH-DIG <+ 1 ,BEACH-DIG>>
		<COND (<G? ,BEACH-DIG 3>
		       <SETG BEACH-DIG -1>
		       <AND <IN? ,SCARAB ,HERE> <FSET ,SCARAB ,INVISIBLE>>
		       <JIGS-UP "The hole collapses, smothering you.">)
		      (<EQUAL? ,BEACH-DIG 3>
		       <COND (<FSET? ,SCARAB ,INVISIBLE>
			      <TELL
"You can see a scarab here in the sand." CR>
			      <THIS-IS-IT ,SCARAB>
			      <FCLEAR ,SCARAB ,INVISIBLE>)>)
		      (T
		       <TELL <GET ,BDIGS ,BEACH-DIG> CR>)>)>>

<GLOBAL BDIGS
	<TABLE (PURE) "You seem to be digging a hole here."
	       "The hole is getting deeper, but that's about it."
	       "You are surrounded by a wall of sand on all sides.">>

\

"SUBTITLE TOITY POIPLE BOIDS A CHOIPIN' AN' A BOIPIN' ... "

<ROUTINE TREE-ROOM (RARG "AUX" F)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are about 10 feet above the ground nestled among some large
branches. The nearest branch above you is above your reach." CR>
		<COND (<AND <SET F <FIRST? ,PATH>>
			    <NEXT? .F>>
		       <TELL "On the ground below you can see:  ">
		       <PRINT-CONTENTS ,PATH>
		       <TELL "." CR>)>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? CLIMB-DOWN> <EQUAL? ,PRSO ,TREE ,ROOMS>>
		       <DO-WALK ,P?DOWN>)
		      (<AND <VERB? CLIMB-UP CLIMB-FOO>
			    <EQUAL? ,PRSO ,TREE>>
		       <DO-WALK ,P?UP>)
		      (<VERB? DROP>
		       <COND (<NOT <IDROP>> <RTRUE>)
			     (<AND <EQUAL? ,PRSO ,NEST> <IN? ,EGG ,NEST>>
			      <TELL
"The nest falls to the ground, and the egg spills out of it, seriously
damaged." CR>
			      <REMOVE-CAREFULLY ,EGG>
			      <MOVE ,BROKEN-EGG ,PATH>)
			     (<EQUAL? ,PRSO ,EGG>
			      <TELL
"The egg falls to the ground and springs open, seriously damaged.">
			      <MOVE ,EGG ,PATH>
			      <BAD-EGG>
			      <CRLF>)
			     (<NOT <EQUAL? ,PRSO ,WINNER ,TREE>>
			      <MOVE ,PRSO ,PATH>
			      <TELL
"The " D ,PRSO " falls to the ground." CR>)
			     (<VERB? LEAP>
			      <JIGS-UP
			        "That was just a bit too far down.">)>)>)
	       (<EQUAL? .RARG ,M-ENTER> <ENABLE <QUEUE I-FOREST-ROOM -1>>)>>

<ROUTINE EGG-OBJECT ()
	 <COND (<AND <VERB? OPEN MUNG> <EQUAL? ,PRSO ,EGG>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "The egg is already open." CR>)
		      (<NOT ,PRSI>
		       <TELL "You have neither the tools nor the expertise."
			     CR>)
		      (<EQUAL? ,PRSI ,HANDS>
		       <TELL "I doubt you could do that without damaging it."
			     CR>)
		      (<OR <FSET? ,PRSI ,WEAPONBIT>
			   <FSET? ,PRSI ,TOOLBIT>
			   <VERB? MUNG>>
		       <TELL
"The egg is now open, but the clumsiness of your attempt has seriously
compromised its esthetic appeal.">
		       <BAD-EGG>
		       <CRLF>)
		      (<FSET? ,PRSO ,FIGHTBIT>
		       <TELL "Not to say that using the "
			     D ,PRSI
			     " isn't original too..." CR>)
		      (T
		       <TELL "The concept of using a "
			     D ,PRSI
			     " is certainly original." CR>
		       <FSET ,PRSO ,FIGHTBIT>)>)
	       (<VERB? CLIMB-ON HATCH>
		<TELL
"There is a noticeable crunch from beneath you, and inspection reveals
that the egg is lying open, badly damaged.">
		<BAD-EGG>
		<CRLF>)
	       (<VERB? OPEN MUNG THROW>
		<COND (<VERB? THROW> <MOVE ,PRSO ,HERE>)>
		<TELL
"Your rather indelicate handling of the egg has caused it some damage,
although you have succeeded in opening it.">
		<BAD-EGG>
		<CRLF>)>>

<ROUTINE BAD-EGG ("AUX" L)
	 <COND (<IN? ,CANARY ,EGG>
		<TELL " " <GETP ,BROKEN-CANARY ,P?FDESC>>)
	       (T <REMOVE-CAREFULLY ,BROKEN-CANARY>)>
	 <MOVE ,BROKEN-EGG <LOC ,EGG>>
	 <REMOVE-CAREFULLY ,EGG>
	 <RTRUE>>

<GLOBAL SING-SONG <>>

<ROUTINE CANARY-OBJECT ()
	 <COND (<VERB? WIND>
		<COND (<EQUAL? ,PRSO ,CANARY>
		       <COND (<AND <NOT ,SING-SONG> <FOREST-ROOM?>>
			      <TELL
"The canary chirps, slightly off-key, an aria from a forgotten opera.
From out of the greenery flies a lovely songbird. It perches on a
limb just over your head and opens its beak to sing. As it does so
a beautiful brass bauble drops from its mouth, bounces off the top of
your head, and lands glimmering in the grass. As the canary winds
down, the songbird flies away." CR>
			     <SETG SING-SONG T>
			     <MOVE ,BAUBLE
				   <COND (<EQUAL? ,HERE ,UP-A-TREE> ,PATH)
					 (T ,HERE)>>)
			    (T
			     <TELL
"The canary chirps blithely, if somewhat tinnily, for a short time." CR>)>)
		     (T
		      <TELL
"There is an unpleasant grinding noise from inside the canary." CR>)>)>>

<ROUTINE FOREST-ROOM? ()
	 <OR <EQUAL? ,HERE ,FOREST-1 ,FOREST-2 ,FOREST-3>
	     <EQUAL? ,HERE ,PATH ,UP-A-TREE>>>

<ROUTINE I-FOREST-ROOM ()
	 <COND (<NOT <FOREST-ROOM?>>
		<DISABLE <INT I-FOREST-ROOM>>
		<RFALSE>)
	       (<PROB 15>
		<TELL
"You hear in the distance the chirping of a song bird." CR>)>>

<ROUTINE FOREST-ROOM (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER> <ENABLE <QUEUE I-FOREST-ROOM -1>>)
	       (<EQUAL? .RARG ,M-BEG>
		<COND (<AND <VERB? CLIMB-FOO CLIMB-UP>
			    <EQUAL? ,PRSO ,TREE>>
		       <DO-WALK ,P?UP>)>)>>

<ROUTINE WCLIF-OBJECT ()
	 <COND (<VERB? CLIMB-UP CLIMB-DOWN CLIMB-FOO>
		<TELL "The cliff is too steep for climbing." CR>)>>

<ROUTINE CLIFF-OBJECT ()
	 <COND (<OR <VERB? LEAP>
		    <AND <VERB? PUT> <EQUAL? ,PRSO ,ME>>>
		<TELL
		 "That would be very unwise. Perhaps even fatal." CR>)
	       (<EQUAL? ,PRSI ,CLIMBABLE-CLIFF>
		<COND (<VERB? PUT THROW-OFF>
		       <TELL
"The " D ,PRSO " tumbles into the river and is seen no more." CR>
		       <REMOVE-CAREFULLY ,PRSO>)>)>>

\

"SUBTITLE CHUTES AND LADDERS"

<ROUTINE ROPE-FUNCTION ("AUX" RLOC)
	 <COND (<NOT <EQUAL? ,HERE ,DOME-ROOM>>
		<SETG DOME-FLAG <>>
		<COND (<VERB? TIE>
		       <TELL "You can't tie the rope to that." CR>)>)
	       (<VERB? TIE>
		<COND (<EQUAL? ,PRSI ,RAILING>
		       <COND (,DOME-FLAG
			      <TELL
			       "The rope is already tied to it." CR>)
			     (T
			      <TELL
"The rope drops over the side and comes within ten feet of the floor." CR>
			      <SETG DOME-FLAG T>
			      <FSET ,ROPE ,NDESCBIT>
			      <SET RLOC <LOC ,ROPE>>
			      <COND (<OR <NOT .RLOC>
					 <NOT <IN? .RLOC ,ROOMS>>>
				     <MOVE ,ROPE ,HERE>)>
			      T)>)>)
	       (<AND <VERB? CLIMB-DOWN> <EQUAL? ,PRSO ,ROPE ,ROOMS> ,DOME-FLAG>
		<DO-WALK ,P?DOWN>)
	       (<AND <VERB? TIE-UP>
		     <EQUAL? ,ROPE ,PRSI>>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <COND (<L? <GETP ,PRSO ,P?STRENGTH> 0>
			      <TELL
"Your attempt to tie up the " D ,PRSO " awakens him.">
			      <AWAKEN ,PRSO>)
			     (T
			      <TELL
"The " D ,PRSO " struggles and you cannot tie him up." CR>)>)
		      (T
		       <TELL "Why would you tie up a " D ,PRSO "?" CR>)>)
	       (<VERB? UNTIE>
		<COND (,DOME-FLAG
		       <SETG DOME-FLAG <>>
		       <FCLEAR ,ROPE ,NDESCBIT>
		       <TELL "The rope is now untied." CR>)
		      (T
		       <TELL "It is not tied to anything." CR>)>)
	       (<AND <VERB? DROP>
		     <EQUAL? ,HERE ,DOME-ROOM>
		     <NOT ,DOME-FLAG>>
		<MOVE ,ROPE ,TORCH-ROOM>
		<TELL "The rope drops gently to the floor below." CR>)
	       (<VERB? TAKE>
		<COND (,DOME-FLAG
		       <TELL "The rope is tied to the railing." CR>)>)>>

<ROUTINE UNTIE-FROM ()
    <COND (<AND <EQUAL? ,PRSO ,ROPE>
		<AND ,DOME-FLAG <EQUAL? ,PRSI ,RAILING>>>
	   <PERFORM ,V?UNTIE ,PRSO>)
	  (T <TELL "It's not attached to that!" CR>)>>

<ROUTINE SLIDE-FUNCTION ()
	 <COND (<OR <VERB? THROUGH CLIMB-UP CLIMB-DOWN CLIMB-FOO>
		    <AND <VERB? PUT> <EQUAL? ,PRSO ,ME>>>
		<COND (<EQUAL? ,HERE ,CELLAR>
		       <DO-WALK ,P?WEST>
		       <RTRUE>)
		      (T
		       <TELL "You tumble down the slide...." CR>
		       <GOTO ,CELLAR>)>)
	       (<VERB? PUT>
		<SLIDER ,PRSO>)>>

<ROUTINE SLIDER (OBJ)
	 <COND (<FSET? .OBJ ,TAKEBIT>
		<TELL "The " D .OBJ " falls into the slide and is gone." CR>
		<COND (<EQUAL? .OBJ ,WATER> <REMOVE-CAREFULLY .OBJ>)
		      (T
		       <MOVE .OBJ ,CELLAR>)>)
	       (T <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE SANDWICH-BAG-FCN ()
	 <COND (<AND <VERB? SMELL>
		     <IN? ,LUNCH ,PRSO>>
		<TELL "It smells of hot peppers." CR>)>>

"MORE RANDOMNESS"

<ROUTINE DEAD-FUNCTION ("OPTIONAL" (FOO <>) "AUX" M)
	 <COND (<VERB? WALK>
		<COND (<AND <EQUAL? ,HERE ,TIMBER-ROOM>
			    <EQUAL? ,PRSO ,P?WEST>>
		       <TELL "You cannot enter in your condition." CR>)>)
	       (<VERB? BRIEF VERBOSE SUPER-BRIEF
		       VERSION ;AGAIN SAVE RESTORE QUIT RESTART>
		<>)
	       (<VERB? ATTACK MUNG ALARM SWING>
		<TELL "All such attacks are vain in your condition." CR>)
	       (<VERB? OPEN CLOSE EAT DRINK
		       INFLATE DEFLATE TURN BURN
		       TIE UNTIE RUB>
		<TELL
"Even such an action is beyond your capabilities." CR>)
	       (<VERB? WAIT>
		<TELL "Might as well. You've got an eternity." CR>)
	       (<VERB? LAMP-ON>
		<TELL "You need no light to guide you." CR>)
	       (<VERB? SCORE>
		<TELL "You're dead! How can you think of your score?" CR>)
	       (<VERB? TAKE RUB>
		<TELL "Your hand passes through its object." CR>)
	       (<VERB? DROP THROW INVENTORY>
		<TELL "You have no possessions." CR>)
	       (<VERB? DIAGNOSE>
		<TELL "You are dead." CR>)
	       (<VERB? LOOK>
		<TELL "The room looks strange and unearthly">
		<COND (<NOT <FIRST? ,HERE>>
		       <TELL ".">)
		      (T
		       <TELL " and objects appear indistinct.">)>
		<CRLF>
		<COND (<NOT <FSET? ,HERE ,ONBIT>>
		       <TELL
"Although there is no light, the room seems dimly illuminated." CR>)>
		<CRLF>
		<>)
	       (<VERB? PRAY>
		<COND (<EQUAL? ,HERE ,SOUTH-TEMPLE>
		       <FCLEAR ,LAMP ,INVISIBLE>
		       <PUTP ,WINNER ,P?ACTION 0>
		       ;<SETG GWIM-DISABLE <>>
		       <SETG ALWAYS-LIT <>>
		       <SETG DEAD <>>
		       <COND (<IN? ,TROLL ,TROLL-ROOM>
			      <SETG TROLL-FLAG <>>)>
		       <TELL
"From the distance the sound of a lone trumpet is heard. The room
becomes very bright and you feel disembodied. In a moment, the
brightness fades and you find yourself rising as if from a long
sleep, deep in the woods. In the distance you can faintly hear a
songbird and the sounds of the forest." CR CR>
		       <GOTO ,FOREST-1>)
		      (T
		       <TELL "Your prayers are not heard." CR>)>)
	       (T
		<TELL "You can't even do that." CR>
		<SETG P-CONT <>>
		<RFATAL>)>>

;"Pseudo-object routines"

<ROUTINE LAKE-PSEUDO ()
	 <COND (,LOW-TIDE
		<TELL "There's not much lake left...." CR>)
	       (<VERB? CROSS>
		<TELL "It's too wide to cross." CR>)
	       (<VERB? THROUGH>
		<TELL "You can't swim in this lake." CR>)>>

<ROUTINE STREAM-PSEUDO ()
	 <COND (<VERB? SWIM THROUGH>
		<TELL "You can't swim in the stream." CR>)
	       (<VERB? CROSS>
		<TELL "The other side is a sheer rock cliff." CR>)>>

<ROUTINE CHASM-PSEUDO ()
	 <COND (<OR <VERB? LEAP>
		    <AND <VERB? PUT> <EQUAL? ,PRSO ,ME>>>
		<TELL
"You look before leaping, and realize that you would never survive." CR>)
	       (<VERB? CROSS>
		<TELL "It's too far to jump, and there's no bridge." CR>)
	       (<AND <VERB? PUT THROW-OFF> <EQUAL? ,PRSI ,PSEUDO-OBJECT>>
		<TELL
"The " D ,PRSO " drops out of sight into the chasm." CR>
		<REMOVE-CAREFULLY ,PRSO>)>>

<ROUTINE DOME-PSEUDO ()
	 <COND (<VERB? KISS>
		<TELL "No." CR>)>>

<ROUTINE GATE-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?IN>
		<RTRUE>)
	       (T
		<TELL
"The gate is protected by an invisible force. It makes your
teeth ache to touch it." CR>)>>

<ROUTINE DOOR-PSEUDO () ;"in Studio"
	 <COND (<VERB? OPEN CLOSE>
		<TELL "The door won't budge." CR>)
	       (<VERB? THROUGH>
		<DO-WALK ,P?SOUTH>)>>

<ROUTINE PAINT-PSEUDO ()
	 <COND (<VERB? MUNG>
		<TELL "Some paint chips away, revealing more paint." CR>)>>

<ROUTINE GAS-PSEUDO ()
	 <COND (<VERB? BREATHE>	;"REALLY BLOW"
		<TELL "There is too much gas to blow away." CR>)
	       (<VERB? SMELL>
		<TELL "It smells like coal gas in here." CR>)>>

"SUBTITLE MELEE"

"melee actions (object functions for villains called with these"

<CONSTANT F-BUSY? 1>		;"busy recovering weapon?"
<CONSTANT F-DEAD 2>		;"mistah kurtz, he dead."
<CONSTANT F-UNCONSCIOUS 3>	;"into dreamland"
<CONSTANT F-CONSCIOUS 4>	;"rise and shine"
<CONSTANT F-FIRST? 5>		;"strike first?"

\

"blow results"

<CONSTANT MISSED 1>		;"attacker misses"
<CONSTANT UNCONSCIOUS 2>	;"defender unconscious"
<CONSTANT KILLED 3>		;"defender dead"
<CONSTANT LIGHT-WOUND 4>	;"defender lightly wounded"
<CONSTANT SERIOUS-WOUND 5>	;"defender seriously wounded"
<CONSTANT STAGGER 6>		;"defender staggered (miss turn)"
<CONSTANT LOSE-WEAPON 7>	;"defender loses weapon"
<CONSTANT HESITATE 8>		;"hesitates (miss on free swing)"
<CONSTANT SITTING-DUCK 9>	;"sitting duck (crunch!)"

"tables of melee results"

<GLOBAL DEF1
	<TABLE (PURE)
	 MISSED MISSED MISSED MISSED
	 STAGGER STAGGER
	 UNCONSCIOUS UNCONSCIOUS
	 KILLED KILLED KILLED KILLED KILLED>>

<GLOBAL DEF2A
	<TABLE (PURE)
	 MISSED MISSED MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND
	 UNCONSCIOUS>>

<GLOBAL DEF2B
	<TABLE (PURE)
	 MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND
	 UNCONSCIOUS
	 KILLED KILLED KILLED>>

<GLOBAL DEF3A
	<TABLE (PURE)
	 MISSED MISSED MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND
	 SERIOUS-WOUND SERIOUS-WOUND>>

<GLOBAL DEF3B
	<TABLE (PURE)
	 MISSED MISSED MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND
	 SERIOUS-WOUND SERIOUS-WOUND SERIOUS-WOUND>>

<GLOBAL DEF3C
	<TABLE (PURE)
	 MISSED
	 STAGGER STAGGER
	 LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND LIGHT-WOUND
	 SERIOUS-WOUND SERIOUS-WOUND SERIOUS-WOUND>>

<GLOBAL DEF1-RES
	<TABLE DEF1
	       0 ;<REST ,DEF1 2>
	       0 ;<REST ,DEF1 4>>>

<GLOBAL DEF2-RES
	<TABLE DEF2A
	       DEF2B
	       0; <REST ,DEF2B 2>
	       0; <REST ,DEF2B 4>>>

<GLOBAL DEF3-RES
	<TABLE DEF3A
	       0 ;<REST ,DEF3A 2>
	       DEF3B
	       0 ;<REST ,DEF3B 2>
	       DEF3C>>

\

"useful constants"

<CONSTANT STRENGTH-MAX 7>
<CONSTANT STRENGTH-MIN 2>
<CONSTANT CURE-WAIT 30>

\

"I-FIGHT moved to DEMONS"

<ROUTINE DO-FIGHT (LEN "AUX" CNT RES O OO (OUT <>))
	<REPEAT ()
	      <SET CNT 0>
	      <REPEAT ()
		      <SET CNT <+ .CNT 1>>
		      <COND (<EQUAL? .CNT .LEN>
			     <SET RES T>
			     <RETURN T>)>
		      <SET OO <GET ,VILLAINS .CNT>>
		      <SET O <GET .OO ,V-VILLAIN>>
		      <COND (<NOT <FSET? .O ,FIGHTBIT>>)
			    (<APPLY <GETP .O ,P?ACTION>
				    ,F-BUSY?>)
			    (<NOT <SET RES
				       <VILLAIN-BLOW
					.OO
					.OUT>>>
			     <SET RES <>>
			     <RETURN>)
			    (<EQUAL? .RES ,UNCONSCIOUS>
			     <SET OUT <+ 1 <RANDOM 3>>>)>>
	      <COND (.RES
		     <COND (<NOT .OUT> <RETURN>)
			   (T
			    <SET OUT <- .OUT 1>>
			    <COND (<0? .OUT> <RETURN>)>)>)
		    (T <RETURN>)>>>

\

"takes a remark, defender, and good-guy's weapon"

<ROUTINE REMARK (REMARK D W "AUX" (LEN <GET .REMARK 0>) (CNT 0) STR)
	 <REPEAT ()
	         <COND (<G? <SET CNT <+ .CNT 1>> .LEN> <RETURN>)>
		 <SET STR <GET .REMARK .CNT>>
		 <COND (<EQUAL? .STR ,F-WEP> <PRINTD .W>)
		       (<EQUAL? .STR ,F-DEF> <PRINTD .D>)
		       (T <PRINT .STR>)>>
	 <CRLF>>

"Strength of the player is a basic value (S) adjusted by his P?STRENGTH
property, which is normally 0"

<ROUTINE FIGHT-STRENGTH ("OPTIONAL" (ADJUST? T) "AUX" S)
	 <SET S
	      <+ ,STRENGTH-MIN
		 </ ,SCORE
		    </ ,SCORE-MAX
		       <- ,STRENGTH-MAX ,STRENGTH-MIN>>>>>
	 <COND (.ADJUST? <+ .S <GETP ,WINNER ,P?STRENGTH>>)(T .S)>>

<ROUTINE VILLAIN-STRENGTH (OO
			   "AUX" (VILLAIN <GET .OO ,V-VILLAIN>)
			   OD TMP)
	 <SET OD <GETP .VILLAIN ,P?STRENGTH>>
	 <COND (<NOT <L? .OD 0>>
		<COND (<AND <EQUAL? .VILLAIN ,THIEF> ,THIEF-ENGROSSED>
		       <COND (<G? .OD 2> <SET OD 2>)>
		       <SETG THIEF-ENGROSSED <>>)>
		<COND (<AND ,PRSI
			    <FSET? ,PRSI ,WEAPONBIT>
			    <EQUAL? <GET .OO ,V-BEST> ,PRSI>>
		       <SET TMP <- .OD <GET .OO ,V-BEST-ADV>>>
		       <COND (<L? .TMP 1> <SET TMP 1>)>
		       <SET OD .TMP>)>)>
	 .OD>

"find a weapon (if any) in possession of argument"

<ROUTINE FIND-WEAPON (O "AUX" W)
	 <SET W <FIRST? .O>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<OR <EQUAL? .W ,STILETTO ,AXE ,SWORD>
			    <EQUAL? .W ,KNIFE ,RUSTY-KNIFE>>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>> <RFALSE>)>>>

\

<ROUTINE VILLAIN-BLOW (OO OUT?
		       "AUX" (VILLAIN <GET .OO ,V-VILLAIN>)
		       (REMARKS <GET .OO ,V-MSGS>)
		       DWEAPON ATT DEF OA OD TBL RES NWEAPON)
	 <FCLEAR ,WINNER ,STAGGERED>
	 <COND (<FSET? .VILLAIN ,STAGGERED>
		<TELL "The " D .VILLAIN
		      " slowly regains his feet." CR>
		<FCLEAR .VILLAIN ,STAGGERED>
		<RTRUE>)>
	 <SET OA <SET ATT <VILLAIN-STRENGTH .OO>>>
	 <COND (<NOT <G? <SET DEF <FIGHT-STRENGTH>> 0>> <RTRUE>)>
	 <SET OD <FIGHT-STRENGTH <>>>
	 <SET DWEAPON <FIND-WEAPON ,WINNER>>
	 <COND (<L? .DEF 0> <SET RES ,KILLED>)
	       (T
		<COND (<1? .DEF>
		       <COND (<G? .ATT 2> <SET ATT 3>)>
		       <SET TBL <GET ,DEF1-RES <- .ATT 1>>>)
		      (<EQUAL? .DEF 2>
		       <COND (<G? .ATT 3> <SET ATT 4>)>
		       <SET TBL <GET ,DEF2-RES <- .ATT 1>>>)
		      (<G? .DEF 2>
		       <SET ATT <- .ATT .DEF>>
		       <COND (<L? .ATT -1> <SET ATT -2>)
			     (<G? .ATT 1> <SET ATT 2>)>
		       <SET TBL <GET ,DEF3-RES <+ .ATT 2>>>)>
		<SET RES <GET .TBL <- <RANDOM 9> 1>>>
		<COND (.OUT?
		       <COND (<EQUAL? .RES ,STAGGER> <SET RES ,HESITATE>)
			     (T <SET RES ,SITTING-DUCK>)>)>
		<COND (<AND <EQUAL? .RES ,STAGGER>
			    .DWEAPON
			    <PROB 25 <COND (.HERO? 10)(T 50)>>>
		       <SET RES ,LOSE-WEAPON>)>
		<REMARK
		  <RANDOM-ELEMENT <GET .REMARKS <- .RES 1>>>
		  ,WINNER
		  .DWEAPON>)>
	 <COND (<OR <EQUAL? .RES ,MISSED> <EQUAL? .RES ,HESITATE>>)
	       (<EQUAL? .RES ,UNCONSCIOUS>)
	       (<OR <EQUAL? .RES ,KILLED>
		    <EQUAL? .RES ,SITTING-DUCK>>
		<SET DEF 0>)
	       (<EQUAL? .RES ,LIGHT-WOUND>
		<SET DEF <- .DEF 1>>
		<COND (<L? .DEF 0> <SET DEF 0>)>
		<COND (<G? ,LOAD-ALLOWED 50>
		       <SETG LOAD-ALLOWED <- ,LOAD-ALLOWED 10>>)>)
	       (<EQUAL? .RES ,SERIOUS-WOUND>
		<SET DEF <- .DEF 2>>
		<COND (<L? .DEF 0> <SET DEF 0>)>
		<COND (<G? ,LOAD-ALLOWED 50>
		       <SETG LOAD-ALLOWED <- ,LOAD-ALLOWED 20>>)>)
	       (<EQUAL? .RES ,STAGGER> <FSET ,WINNER ,STAGGERED>)
	       (T
		;<AND <EQUAL? .RES ,LOSE-WEAPON> .DWEAPON>
		<MOVE .DWEAPON ,HERE>
		<COND (<SET NWEAPON <FIND-WEAPON ,WINNER>>
		       <TELL
"Fortunately, you still have a " D .NWEAPON "." CR>)>)>
	 <WINNER-RESULT .DEF .RES .OD>>

<ROUTINE HERO-BLOW ("AUX" OO VILLAIN (OUT? <>) DWEAPON ATT DEF (CNT 0)
		    OA OD TBL RES NWEAPON (LEN <GET ,VILLAINS 0>))
	 <REPEAT ()
		 <SET CNT <+ .CNT 1>>
		 <COND (<EQUAL? .CNT .LEN> <RETURN>)>
		 <SET OO <GET ,VILLAINS .CNT>>
		 <COND (<EQUAL? <GET .OO ,V-VILLAIN> ,PRSO>
			<RETURN>)>>
	 <FSET ,PRSO ,FIGHTBIT>
	 <COND (<FSET? ,WINNER ,STAGGERED>
		<TELL
"You are still recovering from that last blow, so your attack is
ineffective." CR>
		<FCLEAR ,WINNER ,STAGGERED>
		<RTRUE>)>
	 <SET ATT <FIGHT-STRENGTH>>
	 <COND (<L? .ATT 1> <SET ATT 1>)>
	 <SET OA .ATT>
	 <SET VILLAIN <GET .OO ,V-VILLAIN>>
	 <COND (<0? <SET OD <SET DEF <VILLAIN-STRENGTH .OO>>>>
		<COND (<EQUAL? ,PRSO ,WINNER>
		       <RETURN <JIGS-UP
"Well, you really did it that time. Is suicide painless?">>)>
		<TELL "Attacking the " D .VILLAIN " is pointless." CR>
		<RTRUE>)>
	 <SET DWEAPON <FIND-WEAPON .VILLAIN>>
	 <COND (<OR <NOT .DWEAPON> <L? .DEF 0>>
		<TELL "The ">
		<COND (<L? .DEF 0> <TELL "unconscious">)
		      (T <TELL "unarmed">)>
		<TELL " " D .VILLAIN
		      " cannot defend himself: He dies." CR>
		<SET RES ,KILLED>)
	       (T
		<COND (<1? .DEF>
		       <COND (<G? .ATT 2> <SET ATT 3>)>
		       <SET TBL <GET ,DEF1-RES <- .ATT 1>>>)
		      (<EQUAL? .DEF 2>
		       <COND (<G? .ATT 3> <SET ATT 4>)>
		       <SET TBL <GET ,DEF2-RES <- .ATT 1>>>)
		      (<G? .DEF 2>
		       <SET ATT <- .ATT .DEF>>
		       <COND (<L? .ATT -1> <SET ATT -2>)
			     (<G? .ATT 1> <SET ATT 2>)>
		       <SET TBL <GET ,DEF3-RES <+ .ATT 2>>>)>
		<SET RES <GET .TBL <- <RANDOM 9> 1>>>
		<COND (.OUT?
		       <COND (<EQUAL? .RES ,STAGGER> <SET RES ,HESITATE>)
			     (T <SET RES ,SITTING-DUCK>)>)>
		<COND (<AND <EQUAL? .RES ,STAGGER> .DWEAPON <PROB 25>>
		       <SET RES ,LOSE-WEAPON>)>
		<REMARK
		  <RANDOM-ELEMENT <GET ,HERO-MELEE <- .RES 1>>>
		  ,PRSO
		  ,PRSI>)>
	 <COND (<OR <EQUAL? .RES ,MISSED> <EQUAL? .RES ,HESITATE>>)
	       (<EQUAL? .RES ,UNCONSCIOUS> <SET DEF <- .DEF>>)
	       (<OR <EQUAL? .RES ,KILLED> <EQUAL? .RES ,SITTING-DUCK>>
		<SET DEF 0>)
	       (<EQUAL? .RES ,LIGHT-WOUND>
		<SET DEF <- .DEF 1>>
		<COND (<L? .DEF 0> <SET DEF 0>)>)
	       (<EQUAL? .RES ,SERIOUS-WOUND>
		<SET DEF <- .DEF 2>>
		<COND (<L? .DEF 0> <SET DEF 0>)>)
	       (<EQUAL? .RES ,STAGGER> <FSET ,PRSO ,STAGGERED>)
	       (T
		;<AND <EQUAL? .RES ,LOSE-WEAPON> .DWEAPON>
		<FCLEAR .DWEAPON ,NDESCBIT>
		<FSET .DWEAPON ,WEAPONBIT>
		<MOVE .DWEAPON ,HERE>
		<THIS-IS-IT .DWEAPON>)>
	 <VILLAIN-RESULT ,PRSO .DEF .RES>>

\

<ROUTINE WINNER-RESULT (DEF RES OD)
	 <PUTP ,WINNER
	       ,P?STRENGTH
	       <COND (<0? .DEF> -10000)(T <- .DEF .OD>)>>
	 <COND (<L? <- .DEF .OD> 0>
		<ENABLE <QUEUE I-CURE ,CURE-WAIT>>)>
	 <COND (<NOT <G? <FIGHT-STRENGTH> 0>>
		<PUTP ,WINNER ,P?STRENGTH <+ 1 <- <FIGHT-STRENGTH <>>>>>
		<JIGS-UP
"It appears that that last blow was too much for you. I'm afraid you
are dead.">
		<>)
	       (T .RES)>>

<ROUTINE VILLAIN-RESULT (VILLAIN DEF RES)
	 <PUTP .VILLAIN ,P?STRENGTH .DEF>
	 <COND (<0? .DEF>
		<FCLEAR .VILLAIN ,FIGHTBIT>
		<TELL
"Almost as soon as the " D .VILLAIN " breathes his last breath, a cloud
of sinister black fog envelops him, and when the fog lifts, the
carcass has disappeared." CR>
		<REMOVE-CAREFULLY .VILLAIN>
		<APPLY <GETP .VILLAIN ,P?ACTION> ,F-DEAD>
		.RES)
	       (<EQUAL? .RES ,UNCONSCIOUS>
		<APPLY <GETP .VILLAIN ,P?ACTION> ,F-UNCONSCIOUS>
		.RES)
	       (T .RES)>>

\

<ROUTINE WINNING? (V "AUX" VS PS)
	 <SET VS <GETP .V ,P?STRENGTH>>
	 <SET PS <- .VS <FIGHT-STRENGTH>>>
	 <COND (<G? .PS 3> <PROB 90>)
	       (<G? .PS 0> <PROB 75>)
	       (<0? .PS> <PROB 50>)
	       (<G? .VS 1> <PROB 25>)
	       (T <PROB 10>)>>

<ROUTINE I-CURE ("AUX" (S <GETP ,WINNER ,P?STRENGTH>))
	 <COND (<G? .S 0> <SET S 0> <PUTP ,WINNER ,P?STRENGTH .S>)
	       (<L? .S 0> <SET S <+ .S 1>> <PUTP ,WINNER ,P?STRENGTH .S>)>
	 <COND (<L? .S 0>
		<COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
		       <SETG LOAD-ALLOWED <+ ,LOAD-ALLOWED 10>>)>
		<ENABLE <QUEUE I-CURE ,CURE-WAIT>>)
	       (T
		<SETG LOAD-ALLOWED ,LOAD-MAX>
		<DISABLE <INT I-CURE>>)>>

"FIGHTS"

"messages for winner"

<CONSTANT F-WEP 0>	;"means print weapon name"
<CONSTANT F-DEF 1>	;"means print defender name (villain, e.g.)"

<GLOBAL HERO-MELEE
 <TABLE (PURE)
  <LTABLE (PURE)
   <LTABLE (PURE) "Your " F-WEP " misses the " F-DEF " by an inch.">
   <LTABLE (PURE) "A good slash, but it misses the " F-DEF " by a mile.">
   <LTABLE (PURE) "You charge, but the " F-DEF " jumps nimbly aside.">
   <LTABLE (PURE) "Clang! Crash! The " F-DEF " parries.">
   <LTABLE (PURE) "A quick stroke, but the " F-DEF " is on guard.">
   <LTABLE (PURE) "A good stroke, but it's too slow; the " F-DEF " dodges.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "Your " F-WEP " crashes down, knocking the " F-DEF " into dreamland.">
   <LTABLE (PURE) "The " F-DEF " is battered into unconsciousness.">
   <LTABLE (PURE) "A furious exchange, and the " F-DEF " is knocked out!">
   <LTABLE (PURE) "The haft of your " F-WEP " knocks out the " F-DEF ".">
   <LTABLE (PURE) "The " F-DEF " is knocked out!">>
  <LTABLE (PURE)
   <LTABLE (PURE) "It's curtains for the " F-DEF " as your " F-WEP " removes his head.">
   <LTABLE (PURE) "The fatal blow strikes the " F-DEF " square in the heart: He dies.">
   <LTABLE (PURE) "The " F-DEF " takes a fatal blow and slumps to the floor dead.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The " F-DEF " is struck on the arm; blood begins to trickle down.">
   <LTABLE (PURE) "Your " F-WEP " pinks the " F-DEF " on the wrist, but it's not serious.">
   <LTABLE (PURE) "Your stroke lands, but it was only the flat of the blade.">
   <LTABLE (PURE) "The blow lands, making a shallow gash in the " F-DEF "'s arm!">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The " F-DEF " receives a deep gash in his side.">
   <LTABLE (PURE) "A savage blow on the thigh! The " F-DEF " is stunned but can still fight!">
   <LTABLE (PURE) "Slash! Your blow lands! That one hit an artery, it could be serious!">
   <LTABLE (PURE) "Slash! Your stroke connects! This could be serious!">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The " F-DEF " is staggered, and drops to his knees.">
   <LTABLE (PURE) "The " F-DEF " is momentarily disoriented and can't fight back.">
   <LTABLE (PURE) "The force of your blow knocks the " F-DEF " back, stunned.">
   <LTABLE (PURE) "The " F-DEF " is confused and can't fight back.">
   <LTABLE (PURE) "The quickness of your thrust knocks the " F-DEF " back, stunned.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The " F-DEF "'s weapon is knocked to the floor, leaving him unarmed.">
   <LTABLE (PURE) "The " F-DEF " is disarmed by a subtle feint past his guard.">>>>

\

"messages for cyclops (note that he has no weapon"

<GLOBAL CYCLOPS-MELEE
 <TABLE (PURE)
  <LTABLE (PURE)
   <LTABLE (PURE) "The Cyclops misses, but the backwash almost knocks you over.">
   <LTABLE (PURE) "The Cyclops rushes you, but runs into the wall.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The Cyclops sends you crashing to the floor, unconscious.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The Cyclops breaks your neck with a massive smash.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "A quick punch, but it was only a glancing blow.">
   <LTABLE (PURE) "A glancing blow from the Cyclops' fist.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The monster smashes his huge fist into your chest, breaking several
ribs.">
   <LTABLE (PURE) "The Cyclops almost knocks the wind out of you with a quick punch.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The Cyclops lands a punch that knocks the wind out of you.">
   <LTABLE (PURE) "Heedless of your weapons, the Cyclops tosses you against the rock
wall of the room.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The Cyclops grabs your " F-WEP ", tastes it, and throws it to the
ground in disgust.">
   <LTABLE (PURE) "The monster grabs you on the wrist, squeezes, and you drop your
" F-WEP " in pain.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The Cyclops seems unable to decide whether to broil or stew his
dinner.">>
  <LTABLE (PURE)
   <LTABLE (PURE) "The Cyclops, no sportsman, dispatches his unconscious victim.">>>>

\

"messages for troll"

<GLOBAL TROLL-MELEE
<TABLE (PURE)
 <LTABLE (PURE)
  <LTABLE (PURE) "The troll swings his axe, but it misses.">
  <LTABLE (PURE) "The troll's axe barely misses your ear.">
  <LTABLE (PURE) "The axe sweeps past as you jump aside.">
  <LTABLE (PURE) "The axe crashes against the rock, throwing sparks!">>
 <LTABLE (PURE)
  <LTABLE (PURE) "The flat of the troll's axe hits you delicately on the head, knocking
you out.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "The troll neatly removes your head.">
  <LTABLE (PURE) "The troll's axe stroke cleaves you from the nave to the chops.">
  <LTABLE (PURE) "The troll's axe removes your head.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "The axe gets you right in the side. Ouch!">
  <LTABLE (PURE) "The flat of the troll's axe skins across your forearm.">
  <LTABLE (PURE) "The troll's swing almost knocks you over as you barely parry
in time.">
  <LTABLE (PURE) "The troll swings his axe, and it nicks your arm as you dodge.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "The troll charges, and his axe slashes you on your " F-WEP " arm.">
  <LTABLE (PURE) "An axe stroke makes a deep wound in your leg.">
  <LTABLE (PURE) "The troll's axe swings down, gashing your shoulder.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "The troll hits you with a glancing blow, and you are momentarily
stunned.">
  <LTABLE (PURE) "The troll swings; the blade turns on your armor but crashes
broadside into your head.">
  <LTABLE (PURE) "You stagger back under a hail of axe strokes.">
  <LTABLE (PURE) "The troll's mighty blow drops you to your knees.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "The axe hits your " F-WEP " and knocks it spinning.">
  <LTABLE (PURE) "The troll swings, you parry, but the force of his blow knocks your " F-WEP " away.">
  <LTABLE (PURE) "The axe knocks your " F-WEP " out of your hand. It falls to the floor.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "The troll hesitates, fingering his axe.">
  <LTABLE (PURE) "The troll scratches his head ruminatively:  Might you be magically
protected, he wonders?">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Conquering his fears, the troll puts you to death.">>>>

\

"messages for thief"

<GLOBAL THIEF-MELEE
<TABLE (PURE)
 <LTABLE (PURE)
  <LTABLE (PURE) "The thief stabs nonchalantly with his stiletto and misses.">
  <LTABLE (PURE) "You dodge as the thief comes in low.">
  <LTABLE (PURE) "You parry a lightning thrust, and the thief salutes you with
a grim nod.">
  <LTABLE (PURE) "The thief tries to sneak past your guard, but you twist away.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Shifting in the midst of a thrust, the thief knocks you unconscious
with the haft of his stiletto.">
  <LTABLE (PURE) "The thief knocks you out.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "Finishing you off, the thief inserts his blade into your heart.">
  <LTABLE (PURE) "The thief comes in from the side, feints, and inserts the blade
into your ribs.">
  <LTABLE (PURE) "The thief bows formally, raises his stiletto, and with a wry grin,
ends the battle and your life.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "A quick thrust pinks your left arm, and blood starts to
trickle down.">
  <LTABLE (PURE) "The thief draws blood, raking his stiletto across your arm.">
  <LTABLE (PURE) "The stiletto flashes faster than you can follow, and blood wells
from your leg.">
  <LTABLE (PURE) "The thief slowly approaches, strikes like a snake, and leaves
you wounded.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "The thief strikes like a snake! The resulting wound is serious.">
  <LTABLE (PURE) "The thief stabs a deep cut in your upper arm.">
  <LTABLE (PURE) "The stiletto touches your forehead, and the blood obscures your
vision.">
  <LTABLE (PURE) "The thief strikes at your wrist, and suddenly your grip is slippery
with blood.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "The butt of his stiletto cracks you on the skull, and you stagger
back.">
  <LTABLE (PURE) "The thief rams the haft of his blade into your stomach, leaving
you out of breath.">
  <LTABLE (PURE) "The thief attacks, and you fall back desperately.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "A long, theatrical slash. You catch it on your " F-WEP ", but the
thief twists his knife, and the " F-WEP " goes flying.">
  <LTABLE (PURE) "The thief neatly flips your " F-WEP " out of your hands, and it drops
to the floor.">
  <LTABLE (PURE) "You parry a low thrust, and your " F-WEP " slips out of your hand.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "The thief, a man of superior breeding, pauses for a moment to consider the propriety of finishing you off.">
  <LTABLE (PURE) "The thief amuses himself by searching your pockets.">
  <LTABLE (PURE) "The thief entertains himself by rifling your pack.">>
 <LTABLE (PURE)
  <LTABLE (PURE) "The thief, forgetting his essentially genteel upbringing, cuts your
throat.">
  <LTABLE (PURE) "The thief, a pragmatist, dispatches you as a threat to his
livelihood.">>>>


"each table entry is:"

<CONSTANT V-VILLAIN 0>	;"villain"
<CONSTANT V-BEST 1>	;"best weapon"
<CONSTANT V-BEST-ADV 2>	;"advantage it confers"
<CONSTANT V-PROB 3>	;"prob of waking if unconscious"
<CONSTANT V-MSGS 4>	;"messages for that villain"

"This table must be after TROLL-MELEE, THIEF-MELEE, CYCLOPS-MELEE defined!"

<GLOBAL VILLAINS
	<LTABLE <TABLE TROLL SWORD 1 0 TROLL-MELEE>
		<TABLE THIEF KNIFE 1 0 THIEF-MELEE>
		<TABLE CYCLOPS <> 0 0 CYCLOPS-MELEE>>>

"DEMONS"

"Fighting demon"

<ROUTINE I-FIGHT ("AUX" (FIGHT? <>) (LEN <GET ,VILLAINS 0>)
		  CNT OO O P)
      <COND (,DEAD <RFALSE>)>
      <SET CNT 0>
      <REPEAT ()
	      <SET CNT <+ .CNT 1>>
	      <COND (<EQUAL? .CNT .LEN> <RETURN>)>
	      <SET OO <GET ,VILLAINS .CNT>>
	      <COND (<AND <IN? <SET O <GET .OO ,V-VILLAIN>> ,HERE>
			  <NOT <FSET? .O ,INVISIBLE>>>
		     <COND (<AND <EQUAL? .O ,THIEF> ,THIEF-ENGROSSED>
			    <SETG THIEF-ENGROSSED <>>)
			   (<L? <GETP .O ,P?STRENGTH> 0>
			    <SET P <GET .OO ,V-PROB>>
			    <COND (<AND <NOT <0? .P>> <PROB .P>>
				   <PUT .OO ,V-PROB 0>
				   <AWAKEN .O>)
				  (T
				   <PUT .OO ,V-PROB <+ .P 25>>)>)
			   (<OR <FSET? .O ,FIGHTBIT>
				<APPLY <GETP .O ,P?ACTION> ,F-FIRST?>>
			    <SET FIGHT? T>)>)
		    (T
		     <COND (<FSET? .O ,FIGHTBIT>
			    <APPLY <GETP .O ,P?ACTION> ,F-BUSY?>)>
		     <COND (<EQUAL? .O ,THIEF> <SETG THIEF-ENGROSSED <>>)>
		     <FCLEAR ,WINNER ,STAGGERED>
		     <FCLEAR .O ,STAGGERED>
		     <FCLEAR .O ,FIGHTBIT>
		     <AWAKEN .O>)>>
      <COND (<NOT .FIGHT?> <RFALSE>)>
      <DO-FIGHT .LEN>>

<ROUTINE AWAKEN (O "AUX" (S <GETP .O ,P?STRENGTH>))
	 <COND (<L? .S 0>
		<PUTP .O ,P?STRENGTH <- 0 .S>>
		<APPLY <GETP .O ,P?ACTION> ,F-CONSCIOUS>)>
	 T>

"SWORD demon"

<ROUTINE I-SWORD ("AUX" (DEM <INT I-SWORD>) (G <GETP ,SWORD ,P?TVALUE>)
		        (NG 0) P T L)
	 <COND (<IN? ,SWORD ,ADVENTURER>
		<COND (<INFESTED? ,HERE> <SET NG 2>)
		      (T
		       <SET P 0>
		       <REPEAT ()
			       <COND (<0? <SET P <NEXTP ,HERE .P>>>
				      <RETURN>)
				     (<NOT <L? .P ,LOW-DIRECTION>>
				      <SET T <GETPT ,HERE .P>>
				      <SET L <PTSIZE .T>>
				      <COND (<EQUAL? .L ,UEXIT ,CEXIT ,DEXIT>
					     <COND (<INFESTED? <GETB .T 0>>
						    <SET NG 1>
						    <RETURN>)>)>)>>)>
		<COND (<EQUAL? .NG .G> <RFALSE>)
		      (<EQUAL? .NG 2>
		       <TELL "Your sword has begun to glow very brightly." CR>)
		      (<1? .NG>
		       <TELL "Your sword is glowing with a faint blue glow."
			     CR>)
		      (<0? .NG>
		       <TELL "Your sword is no longer glowing." CR>)>
		<PUTP ,SWORD ,P?TVALUE .NG>
		<RTRUE>)
	       (T
		<PUT .DEM ,C-ENABLED? 0>
		<RFALSE>)>>

<ROUTINE INFESTED? (R "AUX" (F <FIRST? .R>))
	 <REPEAT ()
		 <COND (<NOT .F> <RFALSE>)
		       (<AND <FSET? .F ,ACTORBIT> <NOT <FSET? .F ,INVISIBLE>>>
			<RTRUE>)
		       (<NOT <SET F <NEXT? .F>>> <RFALSE>)>>>

"THIEF demon"

<ROUTINE I-THIEF ("AUX" (RM <LOC ,THIEF>) ROBJ HERE? (ONCE <>) (FLG <>))
   <PROG ()
     <COND (<SET HERE? <NOT <FSET? ,THIEF ,INVISIBLE>>>
	    <SET RM <LOC ,THIEF>>)>
     <COND
      (<AND <EQUAL? .RM ,TREASURE-ROOM> <NOT <EQUAL? .RM ,HERE>>>
       <COND (.HERE? <HACK-TREASURES> <SET HERE? <>>)>
       <DEPOSIT-BOOTY ,TREASURE-ROOM> ;"silent")
      (<AND <EQUAL? .RM ,HERE>
	    <NOT <FSET? .RM ,ONBIT>>
	    <NOT <IN? ,TROLL ,HERE>>>
       <COND (<THIEF-VS-ADVENTURER .HERE?> <RTRUE>)>
       <COND (<FSET? ,THIEF ,INVISIBLE> <SET HERE? <>>)>)
      (T
       <COND (<AND <IN? ,THIEF .RM>
		   <NOT <FSET? ,THIEF ,INVISIBLE>>> ;"Leave if victim left"
	      <FSET ,THIEF ,INVISIBLE>
	      <SET HERE? <>>)>
       <COND (<FSET? .RM ,TOUCHBIT>     ;"Hack the adventurer's belongings"
	      <ROB .RM ,THIEF 75>
	      <SET FLG
		   <COND (<AND <FSET? .RM ,MAZEBIT>
			       <FSET? ,HERE ,MAZEBIT>>
			  <ROB-MAZE .RM>)
			 (T <STEAL-JUNK .RM>)>>)>)>
     <COND (<AND <SET ONCE <NOT .ONCE>> <NOT .HERE?>>
					   ;"Move to next room, and hack."
	    <RECOVER-STILETTO>
	    <REPEAT ()
		    <COND (<AND .RM <SET RM <NEXT? .RM>>>)
			  (T <SET RM <FIRST? ,ROOMS>>)>
		    <COND (<AND <NOT <FSET? .RM ,SACREDBIT>>
				<FSET? .RM ,RLANDBIT>>
			   <MOVE ,THIEF .RM>
			   <FCLEAR ,THIEF ,FIGHTBIT>
			   <FSET ,THIEF ,INVISIBLE>
			   <SETG THIEF-HERE <>>
			   <RETURN>)>>
	    <AGAIN>)>>
   <COND (<NOT <EQUAL? .RM ,TREASURE-ROOM>>
	  <DROP-JUNK .RM>)>
   .FLG>

<ROUTINE DROP-JUNK (RM "AUX" X N (FLG <>))
	 <SET X <FIRST? ,THIEF>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .FLG>)>
		 <SET N <NEXT? .X>>
		 <COND (<EQUAL? .X ,STILETTO ,LARGE-BAG>)
		       (<AND <0? <GETP .X ,P?TVALUE>> <PROB 30 T>>
			<FCLEAR .X ,INVISIBLE>
			<MOVE .X .RM>
			<COND (<AND <NOT .FLG> <EQUAL? .RM ,HERE>>
			       <TELL
"The robber, rummaging through his bag, dropped a few items he found
valueless." CR>
			       <SET FLG T>)>)>
		 <SET X .N>>>

<ROUTINE RECOVER-STILETTO ()
	 <COND (<IN? ,STILETTO <LOC ,THIEF>>
		<FSET ,STILETTO ,NDESCBIT>
		<MOVE ,STILETTO ,THIEF>)>>

<ROUTINE STEAL-JUNK (RM "AUX" X N)
	 <SET X <FIRST? .RM>>
	 <REPEAT ()
		 <COND (<NOT .X> <RFALSE>)>
		 <SET N <NEXT? .X>>
		 <COND (<AND <0? <GETP .X ,P?TVALUE>>
			     <FSET? .X ,TAKEBIT>
			     <NOT <FSET? .X ,SACREDBIT>>
			     <NOT <FSET? .X ,INVISIBLE>>
			     <OR <EQUAL? .X ,STILETTO>
				 <PROB 10 T>>>
			<MOVE .X ,THIEF>
			<FSET .X ,TOUCHBIT>
			<FSET .X ,INVISIBLE>
			<COND (<EQUAL? .X ,ROPE> <SETG DOME-FLAG <>>)>
			<COND (<EQUAL? .RM ,HERE>
			       <TELL "You suddenly notice that the "
				     D .X " vanished." CR>
			       <RTRUE>)
			      (ELSE <RFALSE>)>)>
		 <SET X .N>>>

<ROUTINE ROB (WHAT WHERE "OPTIONAL" (PROB <>) "AUX" N X (ROBBED? <>))
	 <SET X <FIRST? .WHAT>>
	 <REPEAT ()
		 <COND (<NOT .X> <RETURN .ROBBED?>)>
		 <SET N <NEXT? .X>>
		 <COND (<AND <NOT <FSET? .X ,INVISIBLE>>
			     <NOT <FSET? .X ,SACREDBIT>>
			     <G? <GETP .X ,P?TVALUE> 0>
			     <OR <NOT .PROB> <PROB .PROB>>>
			<MOVE .X .WHERE>
			<FSET .X ,TOUCHBIT>
			<COND (<EQUAL? .WHERE ,THIEF> <FSET .X ,INVISIBLE>)>
			<SET ROBBED? T>)>
		 <SET X .N>>>

;"special-cased routines"

<ROUTINE V-DIAGNOSE ("AUX" (MS <FIGHT-STRENGTH <>>)
		     (WD <GETP ,WINNER ,P?STRENGTH>) (RS <+ .MS .WD>))
	 #DECL ((MS WD RS) FIX)
	 <COND (<0? <GET <INT I-CURE> ,C-ENABLED?>> <SET WD 0>)
	       (ELSE <SET WD <- .WD>>)>
	 <COND (<0? .WD> <TELL "You are in perfect health.">)
	       (T
		<TELL "You have ">
		<COND (<1? .WD> <TELL "a light wound,">)
		      (<EQUAL? .WD 2> <TELL "a serious wound,">)
		      (<EQUAL? .WD 3> <TELL "several wounds,">)
		      (<G? .WD 3> <TELL "serious wounds,">)>)>
	 <COND (<NOT <0? .WD>>
		<TELL " which will be cured after ">
		<PRINTN
		 <+ <* ,CURE-WAIT <- .WD 1>>
		    <GET <INT I-CURE> ,C-TICK>>>
		<TELL " moves.">)>
	 <CRLF>
	 <TELL "You can ">
	 <COND (<0? .RS> <TELL "expect death soon">)
	       (<1? .RS> <TELL "be killed by one more light wound">)
	       (<EQUAL? .RS 2> <TELL "be killed by a serious wound">)
	       (<EQUAL? .RS 3> <TELL "survive one serious wound">)
	       (<G? .RS 3>
		<TELL "survive several wounds">)>
	 <TELL "." CR>
	 <COND (<NOT <0? ,DEATHS>>
		<TELL "You have been killed ">
		<COND (<1? ,DEATHS> <TELL "once">)
		      (T <TELL "twice">)>
		<TELL "." CR>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
	 #DECL ((ASK?) <OR ATOM FALSE>)
	 <TELL "Your score is ">
	 <TELL N ,SCORE>
	 <TELL " (total of 350 points), in ">
	 <TELL N ,MOVES>
	 <COND (<1? ,MOVES> <TELL " move.">) (ELSE <TELL " moves.">)>
	 <CRLF>
	 <TELL "This gives you the rank of ">
	 <COND (<EQUAL? ,SCORE 350> <TELL "Master Adventurer">)
	       (<G? ,SCORE 330> <TELL "Wizard">)
	       (<G? ,SCORE 300> <TELL "Master">)
	       (<G? ,SCORE 200> <TELL "Adventurer">)
	       (<G? ,SCORE 100> <TELL "Junior Adventurer">)
	       (<G? ,SCORE 50> <TELL "Novice Adventurer">)
	       (<G? ,SCORE 25> <TELL "Amateur Adventurer">)
	       (T <TELL "Beginner">)>
	 <TELL "." CR>
	 ,SCORE>

<ROUTINE JIGS-UP (DESC "OPTIONAL" (PLAYER? <>))
 	 <SETG WINNER ,ADVENTURER>
	 <COND (,DEAD
		<TELL "|
It takes a talented person to be killed while already dead. YOU are such
a talent. Unfortunately, it takes a talented person to deal with it.
I am not such a talent. Sorry." CR>
		<FINISH>)>
	 <TELL .DESC CR>
	 <COND (<NOT ,LUCKY>
		<TELL "Bad luck, huh?" CR>)>
	 <PROG ()
	       <SCORE-UPD -10>
	       <TELL "
|    ****  You have died  ****
|
|">
	       <COND (<FSET? <LOC ,WINNER> ,VEHBIT>
		      <MOVE ,WINNER ,HERE>)>
	       <COND
		(<NOT <L? ,DEATHS 2>>
		 <TELL
"You clearly are a suicidal maniac.  We don't allow psychotics in the
cave, since they may harm other adventurers.  Your remains will be
installed in the Land of the Living Dead, where your fellow
adventurers may gloat over them." CR>
		 <FINISH>)
		(T
		 <SETG DEATHS <+ ,DEATHS 1>>
		 <MOVE ,WINNER ,HERE>
		 <COND (<FSET? ,SOUTH-TEMPLE ,TOUCHBIT>
			<TELL
"As you take your last breath, you feel relieved of your burdens. The
feeling passes as you find yourself before the gates of Hell, where
the spirits jeer at you and deny you entry.  Your senses are
disturbed.  The objects in the dungeon appear indistinct, bleached of
color, even unreal." CR CR>
			<SETG DEAD T>
			<SETG TROLL-FLAG T>
			;<SETG GWIM-DISABLE T>
			<SETG ALWAYS-LIT T>
			<PUTP ,WINNER ,P?ACTION DEAD-FUNCTION>
			<GOTO ,ENTRANCE-TO-HADES>)
		       (T
			<TELL
"Now, let's take a look here...
Well, you probably deserve another chance.  I can't quite fix you
up completely, but you can't have everything." CR CR>
			<GOTO ,FOREST-1>)>
		 <FCLEAR ,TRAP-DOOR ,TOUCHBIT>
		 <SETG P-CONT <>>
		 <RANDOMIZE-OBJECTS>
		 <KILL-INTERRUPTS>
		 <RFATAL>)>>>

<ROUTINE RANDOMIZE-OBJECTS ("AUX" (R <>) F N L)
	 <COND (<IN? ,LAMP ,WINNER>
		<MOVE ,LAMP ,LIVING-ROOM>)>
	 <COND (<IN? ,COFFIN ,WINNER>
		<MOVE ,COFFIN ,EGYPT-ROOM>)>
	 <PUTP ,SWORD ,P?TVALUE 0>
	 <SET N <FIRST? ,WINNER>>
	 <SET L <GET ,ABOVE-GROUND 0>>
	 <REPEAT ()
		 <SET F .N>
		 <COND (<NOT .F> <RETURN>)>
		 <SET N <NEXT? .F>>
		 <COND (<G? <GETP .F ,P?TVALUE> 0>
			<REPEAT ()
				<COND (<NOT .R> <SET R <FIRST? ,ROOMS>>)>
				<COND (<AND <FSET? .R ,RLANDBIT>
					    <NOT <FSET? .R ,ONBIT>>
					    <PROB 50>>
				       <MOVE .F .R>
				       <RETURN>)
				      (ELSE <SET R <NEXT? .R>>)>>)
		       (ELSE
			<MOVE .F <GET ,ABOVE-GROUND <RANDOM .L>>>)>>>

<ROUTINE KILL-INTERRUPTS ()
	 <DISABLE <INT I-XB>>
	 <DISABLE <INT I-XC>>
	 <DISABLE <INT I-CYCLOPS>>
	 <DISABLE <INT I-LANTERN>>
	 <DISABLE <INT I-CANDLES>>
	 <DISABLE <INT I-SWORD>>
	 <DISABLE <INT I-FOREST-ROOM>>
	 <DISABLE <INT I-MATCH>>
	 <FCLEAR ,MATCH ,ONBIT>
	 <RTRUE>>

<ROUTINE BAG-OF-COINS-F ()
	 <STUPID-CONTAINER ,BAG-OF-COINS "coins">>

<ROUTINE TRUNK-F ()
	 <STUPID-CONTAINER ,TRUNK "jewels">>

<ROUTINE STUPID-CONTAINER (OBJ STR)
	 <COND (<VERB? OPEN CLOSE>
		<TELL
"The " .STR " are safely inside; there's no need to do that." CR>)
	       (<VERB? LOOK-INSIDE EXAMINE>
		<TELL
"There are lots of " .STR " in there." CR>)
	       (<AND <VERB? PUT> <EQUAL? ,PRSI .OBJ>>
		<TELL
"Don't be silly. It wouldn't be a " D .OBJ " anymore." CR>)>>

<ROUTINE DUMB-CONTAINER ()
	 <COND (<VERB? OPEN CLOSE LOOK-INSIDE>
		<TELL "You can't do that." CR>)
	       (<VERB? EXAMINE>
		<TELL "It looks pretty much like a " D ,PRSO "." CR>)>>

<ROUTINE GARLIC-F ()
	 <COND (<VERB? EAT>
		<REMOVE-CAREFULLY ,PRSO>
		<TELL
"What the heck! You won't make friends this way, but nobody around
here is too friendly anyhow. Gulp!" CR>)>>

<ROUTINE CHAIN-PSEUDO ()
	 <COND (<VERB? TAKE MOVE>
		<TELL "The chain is secure." CR>)
	       (<VERB? RAISE LOWER>
		<TELL "Perhaps you should do that to the basket." CR>)
	       (<VERB? EXAMINE>
		<TELL "The chain secures a basket within the shaft." CR>)>> 

<ROUTINE TROLL-ROOM-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <IN? ,TROLL ,HERE>>
		<THIS-IS-IT ,TROLL>)>>
