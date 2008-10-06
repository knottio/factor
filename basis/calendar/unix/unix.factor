USING: alien alien.c-types alien.syntax arrays calendar
kernel structs math unix unix.time namespaces system ;
IN: calendar.unix

: make-timeval ( ms -- timeval )
    1000 /mod 1000 *
    "timeval" <c-object>
    [ set-timeval-usec ] keep
    [ set-timeval-sec ] keep ;

: make-timespec ( ms -- timespec )
    1000 /mod 1000000 *
    "timespec" <c-object>
    [ set-timespec-nsec ] keep
    [ set-timespec-sec ] keep ;

: get-time ( -- alien )
    f time <uint> localtime ;

: timezone-name ( -- string )
    get-time tm-zone ;

M: unix gmt-offset ( -- hours minutes seconds )
    get-time tm-gmtoff 3600 /mod 60 /mod ;
