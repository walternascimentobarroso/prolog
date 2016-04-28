% Author: Chris
% Date: 10/6/2012

:-style_check(-singleton).
:- dynamic airport/2.
:- dynamic cost/2.
:- dynamic canfly/7.
:- dynamic directinfo/10.



%AIRLINE COST
%*******************************************************************************
cost('American Airlines 11',260).
cost('American Airlines 12',260).
cost('American Airlines 45',150).
cost('American Airlines 44',320).
cost('American Airlines 55',350).
cost('American Airlines 42',270).

cost('Denver Airways 12',220).
cost('Denver Airways 33',450).

cost('United Airways 13',220).
cost('United Airways 15',150).

cost('Jet Blue 23',175).
cost('Jet Blue 12',175).

cost('Caribbean Airlines 11',545).
cost('Caribbean Airlines 12',75).
cost('Caribbean Airlines 32',250).

cost('NorthWest Airlines 24',430).

%AIRPORTS
%*******************************************************************************
airport('Montego Bay','Sangsters').
airport('New York','JFK').
airport('Kingston','Norman Manly').
airport('LA','LAX').
airport('Denver','Denver International').
airport('Dallas','Forth Worth').
airport('Florida','Miami International').
airport('Chicago','Midway').

%DEPARTURE TO DESTINATION
%*******************************************************************************

canfly('Caribbean Airlines 11','Montego Bay',1500,'New York',2130,630,0).
canfly('Caribbean Airlines 32','Kingston',1000,'Florida',1200,200,70).
canfly('Caribbean Airlines 12','Montego Bay',0900,'Kingston',0930,30,0).

canfly('American Airlines 11','LA',1300,'Denver',1500,200,0).
canfly('American Airlines 44','Montego Bay',1600,'Florida',1830,230,0).
canfly('American Airlines 12','LA',1000,'Dallas',1312,312,0).
canfly('American Airlines 45','Dallas',1500,'Denver',1700,200,1470).
canfly('American Airlines 55','Denver',0800,'Chicago',1224,424,0).
canfly('American Airlines 42','Florida',1600,'New York',1930,330,300).

canfly('NorthWest Airlines 24','Dallas',2000,'New York',0200,600,0).

canfly('Denver Airways 33','Denver',1900,'New York',2400,500,0).
canfly('Denver Airways 12','LA',2100,'Denver',2300,200,0).


canfly('United Airways 13','LA',0600,'Dallas',1000,400,0).
canfly('United Airways 15','Chicago',1000,'New York',1300,300,0).

canfly('Jet Blue 23','Florida',2100,'Dallas',0030,330,0).
canfly('Jet Blue 12','Kingston',1100,'Florida',1300,200,170).
%*******************************************************************************

delay('Jet Blue 23','Florida','Dallas',0).
delay('American Airlines 45','Dallas','Denver',1470).
delay('Caribbean Airlines 12','Montego Bay','Kingston',0).
delay('Caribbean Airlines 32','Kingston','Florida',70).
delay('Jet Blue 12','Kingston','Florida',170).
delay('American Airlines 42','Florida','New York',300).


%MAIN MENU
%*******************************************************************************
main:-write('[MAIN MENU]*************************************'),
      nl,tab(10),write('[1]'),tab(5),write('Check Flight'),
      nl,tab(10),write('[2]'),tab(5),write('View Flight Schedule'),
      nl,tab(10),write('[3]'),tab(5),write('Cancel Flight'),
      nl,tab(10),write('[4]'),tab(5),write('Show Canceled Flights'),
      nl,tab(10),write('[5]'),tab(5),write('Close/Re-Open  Airport'),
      nl,tab(10),write('[6]'),tab(5),write('Show Closed Airports'),
      nl,tab(10),write('[7]'),tab(5),write('Flight Display Based on Time'),
      nl,tab(10),write('[0]'),tab(5),write('Exit'),
      nl,write('************************************************'),
      nl,nl,write('Please enter your option: '),
      catch(read(Option), _,(nl, write('** INVALID INPUT **'),nl,nl, fail)),select_option(Option).
       select_option(1):-nl, report.
       select_option(2):-nl,(flight_schedule-> abort;nl,nl,write('Would you like to continue [yes/no]: '),read(Reply),(Reply == 'yes'->nl,nl,main;Reply == 'no'->write('Thank you for using the system, goodbye !!!'))).
       select_option(3):-nl, (cancel_flight->abort;nl,nl,main).
       select_option(4):-nl, (show_canceled_flight->abort;nl,write('Press [1] to return to main menu: '),read(Ans),Ans==1->main;abort).
       select_option(5):-nl,nl,write('[CLOSE/RE-OPEN AIRPORTS]'),nl,close_reopen_airport.
       select_option(6):-nl,write('*********************************************************'),
                         (show_closed_airport->abort;nl,write('*********************************************************')),
                         nl,write('Press [1] to return to main menu: '),read(Ans),Ans==1->main;write('Thank you for using the system, goodbye !!!').
       select_option(7):-nl,write('Please enter the neccessary info'),
                         nl,write('Estimated Departure Time: '),read(Dtime),
                         nl,write('Estimated Landing Time: '),read(Ltime),
                         nl,nl,write('*********************************************************'),
                         (display_info(Dtime,Ltime)->abort;nl,write('*********************************************************')),
                         nl,nl,write('Press [1] to return to main menu: '),read(Ans),Ans==1->main;nl,write('Thank you for using the system, goodbye !!!').
       select_option(0):-nl,write('Thank you for using the system, goodbye !!!').

%*******************************************************************************


%REPORT MENU
%*******************************************************************************
report:-write('AIRPORT NAMES AND LOCATIONS ARE AS FOLLOWS:'),nl,nl,write('Montego Bay: \t\tSangsters'),nl,write('New York: \t\tJFK'),
        nl,write('Kingston: \t\tNorman Manly'),nl,write('LA: \t\t\tLAX'),nl,write('Denver: \t\tDenver International'),nl,write('Dallas: \t\tForth Worth'),
        nl,write('Florida: \t\tMiami International'),nl,write('Chicago: \t\tMidway'),nl,nl,
        write('State your departing airport: '),read(Portname1),nl,write('State your destination airport: '),read(Portname2),nl,
        write('Displayed below is the information needed to get your destination depending on your choice of either direct or connecting travel'),nl,nl,
        write('Do you prefer a [Direct/Connecting] flight? Enter [D/C]: '),read(Response),
        airport(Depart,Portname1),airport(Arrive,Portname2),
        (Response == 'D'->nl,(direct_flight(Depart,Arrive,Portname1,Portname2),nl,nl,write('There are no more direct flights from '),write(Depart),write(' to '),write(Arrive),nl,write('Would you like to check for other options [yes/no]: '),read(Reply),(Reply == 'yes'->nl,write('Is your preference based on Cost, Time or Number of stops: '),read(Ans),
        (Ans == 'Cost'-> cost_preference;
        (Ans == 'Time'-> duration_preference;
        (Ans == 'Number of stops'-> order_by_stops;nl,write('Incorrect Option!!!!!'))));(Reply == 'no'->write('Thank you for using the system, goodbye !!!'))));
        (Response == 'C'->nl,write('You can take '),(connect_flight(Depart,Arrive,Cost,Duration,Delay),
        TDuration is Delay + Duration,Temp is TDuration/100, Temp2 is (TDuration mod 100)/100,Durationhrs is Temp - Temp2,Durationmins is (TDuration mod 100),
        nl,write('Total travel time '),(Durationhrs >= 24-> write('1 day '),Hours is Durationhrs - 24,format('~0f',Hours),write(' hrs ');format('~0f',Durationhrs),write(' hrs ')),
        write(Durationmins),write(' minutes'),write(' and cost is $US '),format('~2f',Cost)))).
%*******************************************************************************



%COMPLETE FLIGHT SCHEDULE
%*******************************************************************************
flight_schedule:-canfly(Airline,Depart,Dtime,Arrive,Atime,Duration,Delay),
                 nl,write(Airline),write(' is scheduled to depart '),write(Depart),write(' at '),write(Dtime),write(' hrs'),write(' and will arrive in '),write(Arrive),write(' at '),write(Atime),write(' hrs'),fail,nl.
%*******************************************************************************



%DIRECT FLIGHT FUNCTION
%*******************************************************************************
direct_flight(Depart,Arrive,Portname1,Portname2):-canfly(Airline,Depart,Dtime,Arrive,Atime,Duration,Delay),cost(Airline,Cost),
                                                  Durationhrs is ((Duration//100) mod 10),Durationmins is (Duration mod 100),
                                                  assert(directinfo(Cost,Airline,Depart,Dtime,Portname1,PortName2,Arrive,Atime,Durationhrs,Durationmns)),
                                                  nl,nl,write(Airline),write(' departs '),write(Portname1),write(', '),write(Depart),write(' at '),write(Dtime),write(' hrs'),write(' and should arrive at '),write(Portname2),write(', '),write(Arrive),write(' at '),(Atime =:= 2400->write('0000');write(Atime)),write(' hrs. '),
                                                  nl,write('Total travel time '),write(Durationhrs),write(' hrs '),write(Durationmins),write(' minutes'),write(' and cost is $US '),format('~2f',Cost).
%*******************************************************************************



%CONNECTING FLIGHTS
%*******************************************************************************
connect_flight(Depart,Arrive,Cost,Duration,Delay):- canfly(Airline,Depart,Dtime,Arrive,Atime,Duration,Delay),cost(Airline,Cost),airport(Depart,Portname1),airport(Arrive,Portname2),
                                                    nl,write(Airline),write(' departing at '),write(Dtime),write(' hrs'),write(' from '),write(Portname1),write(', '),write(Depart),write(' then connect to '),write(Portname2),write(', '),write(Arrive),write(', ').



connect_flight(Depart,Arrive,Cost,Duration,Delay):- canfly(Airline,NewDepart,Dtime,Arrive,Atime,Duration1,Delay1),cost(Airline,Cost1),airport(NewDepart,Portname1),airport(Arrive,Portname2),
                                                    connect_flight(Depart,NewDepart,Cost2,Duration2,Delay2),
                                                    Delay is Delay1 + Delay2,Cost is Cost1 + Cost2,Duration is Duration1 + Duration2,
                                                    nl,write(Airline),write(' departing at '),write(Dtime),write(' hrs'),write(' from '),write(Portname1),write(', '),write(NewDepart),write(' then connect to '),write(Portname2),write(', '),write(Arrive),write(', ').
%*******************************************************************************



%CANCEL A FLIGHT
%*******************************************************************************
cancel_flight:- nl,write('[CANCEL FLIGHT]--Example Entry: ''Caribbean Airlines 12'' using single quotes as shown'),
                nl,write('Enter the Airline Flight Name: '),read(Airline),
                retract(cost(Airline,_)),retract(canfly(Airline,Depart,Dtime,Arrive,Atime,_,_)),
                assert(canceled_flights(Airline,Depart,Dtime,Arrive,Atime)),
                nl,write('Flight: '),write(Airline),write(' was canceled'),
                nl,nl,write('Would you like to see all canceled flights? [yes/no]: '),read(Reply),
                (Reply=='yes'->nl,write('[CANCELED FLIGHTS]'),nl,(show_canceled_flight->abort;nl,nl,write('Press [1] to return to main menu: '),read(Ans),Ans==1->main;abort);
                (Reply=='no'->nl,main;nl,write('Incorrect Response!!!!'),abort)).

show_canceled_flight:- canceled_flights(Airline,Depart,Dtime,Arrive,Atime),
                       write('*********************************************************'),
                       nl,write('Flight: '),write(Airline),
                       nl,write('Departing '),write(Depart),write(' to '),write(Arrive),write('\tDeparture Time: '),write(Dtime),write('\tArrival Time: '),write(Atime),nl,fail.
%*******************************************************************************



%CLOSE/REOPEN AIRPORT
%*******************************************************************************
close_reopen_airport:- nl,write('AIRPORT NAMES AND LOCATIONS ARE AS FOLLOWS:'),nl,nl,write('Montego Bay: \t\tSangsters'),nl,write('New York: \t\tJFK'),
                       nl,write('Kingston: \t\tNorman Manly'),nl,write('LA: \t\t\tLAX'),nl,write('Denver: \t\tDenver International'),nl,write('Dallas: \t\tForth Worth'),
                       nl,write('Florida: \t\tMiami International'),nl,write('Chicago: \t\tMidway'),nl,nl,
                       write('Would you like to close or reopen an airport [close/reopen]: '),read(Response),nl,nl,
                       write('Enter time periods in which the airport will be closed Ex.[0900 - 1100]'),nl,
                       write('From: '),read(Closetime),write('  '),write('To: '),read(Opentime),
                       (Response=='close'->nl,write('Example Entry: ''Sangsters'' using single quotes as shown'),nl,
                       write('Enter the Airport Name: '),read(Portname),(function_close(Portname,Closetime,Opentime)->abort;
                       nl,write('Airport: '),write(Portname),tab(10),write('Status: CLOSED'),tab(10),write('From: '),write(Closetime),write(' hrs'),tab(10),write('To: '),write(Opentime),write(' hrs'),
                       nl,nl,write('Press [1] to return to main menu: '),read(Ans),Ans==1->nl,main;abort);
                       
                       (Response=='reopen'->nl,write('Example Entry: ''Sangsters'' using single quotes as shown'),nl,
                       write('Enter the Airport Name: '),read(Portname),(function_open(Portname,Closetime,Opentime)->abort;
                       nl,write('Airport: '),write(Portname),tab(10),write('Status: RE-OPENED'),tab(10),write('From: '),write(Closetime),write(' hrs'),tab(10),write('To: '),write(Opentime),write(' hrs'),
                       nl,nl,write('Press [1] to return to main menu: '),read(Ans),Ans==1->nl,main;abort))).
                       
function_close(Portname,Closetime,Opentime):-airport(Departure,Portname),(canfly(_,Departure,Detime,_,_,_,_),
                                             Detime >= Closetime,Detime < Opentime,
                                             retract(canfly(Airway,Departure,Detime,Arrival,Arrtime,Duration,Delay)),
                                             assert(closed_airport(Airway,Departure,Detime,Arrival,Arrtime,Duration,Delay)),fail).%;fail).
                                             
function_open(Portname,Closetime,Opentime):-airport(Departure,Portname),(closed_airport(_,Departure,Detime,_,_,_,_),
                                             Detime >= Closetime,Detime < Opentime,
                                             retract(closed_airport(Airway,Departure,Detime,Arrival,Arrtime,Duration,Delay)),
                                             assert(canfly(Airway,Departure,Detime,Arrival,Arrtime,Duration,Delay)),fail).
                          

show_closed_airport:- closed_airport(Airway,Departure,_,Arrival,_,_,_),
                      airport(Departure,Portname),
                       nl,write('Aiport: '),write(Portname),
                       nl,write('Flight: '),write(Airway),
                       nl,write('Departing '),write(Departure),write(' to '),write(Arrival),nl,fail.
%*******************************************************************************


%DEPART/LAND WITH A SPECIFIC PERIOD
%*******************************************************************************
display_info(Dtime,Ltime):- canfly(Airline,Depart,NDtime,Arrive,NLtime,_,_),
                            (NDtime >= Dtime,NLtime >= Dtime,NLtime =< Ltime),
                            nl,write('Flight: '),write(Airline),
                            nl,write('Departing '),write(Depart),write(' to '),write(Arrive),write('\tDeparture Time: '),write(NDtime),write('\tArrival Time: '),write(NLtime),nl,fail.


%*******************************************************************************



%ADD/RESCHEDULE FLIGHT
%*******************************************************************************

reflight(Airline):-retract(canfly(Airline,_,_,_,_,_,_)).
reflight2(Airline,Depart,Destination,Atime,Dtime,Diff):-assert(canfly(Airline,Depart,Dtime,Destination,Atime,Diff,0)).

reschedule:-nl,write('[RESCHEDULE FLIGHT]--Example Entry: ''Caribbean Airlines 12'' using single quotes as shown'),nl,write('Enter Flight Number:'),read(Airline),nl,write('Are you sure you want to reschdeulde this flight:'),read(Response),
        ((Response == 'yes')->canfly(Airline,Depart,Dtime,Destination,Atime,Diff,_),reflight(Airline),nl,write('Enter new departure time:'),read(NDtime),nl,write('Enter the new duration:'),read(NAtime),nl,write(Airline),
            write('has been rescheduled with the new information.')),NDiff is NDtime-NAtime,reflight2(Airline,Depart,NDtime,Destination,NAtime,NDiff).

%*******************************************************************************


%COST PREFERENCE
%*******************************************************************************
cost_preference:-nl,write('Select a cost range to view information'),nl,write('Flight below 200 (US): \t\t\t1'),nl,write('Flight between 200-400 (US): \t\t2'),
        nl,write('Flight between 400-600 (US): \t\t3'),nl,write('Flight between 600-800 (US): \t\t4'),nl,write('Flight between 800-1000 (US): \t\t5'),nl,
       write('Enter Choice:'),catch(read(Ans), _,(nl, write('** INVALID INPUT **'),nl,nl, fail)),select_option1(Ans).

select_option1(1):-directinfo(Cost,Airline,Depart,Dtime,Portname1,Portname2,Arrive,Atime,Durationhrs,Durationmns),((Cost<200)-> nl,write(Airline),write(' departs '),write(Portname1),write(', '),write(Depart),
                                                  write(' at '),write(Dtime),write(' hrs'),write(' and should arrive at '),write(Portname2),write(', '),write(Arrive),write(' at '),(Atime =:= 2400->write('0000');write(Atime)),write(' hrs. '),
                                                  nl,write('Total travel time '),write(Durationhrs),write(' hrs '),write(Durationmns),write(' minutes'),write(' and cost is $US '),format('~2f',Cost)),nl,fail.

select_option1(2):-directinfo(Cost,Airline,Depart,Dtime,Portname1,Portname2,Arrive,Atime,Durationhrs,Durationmns),((Cost>200,Cost<400)-> nl,write(Airline),write(' departs '),write(Portname1),write(', '),write(Depart),
                                                  write(' at '),write(Dtime),write(' hrs'),write(' and should arrive at '),write(Portname2),write(', '),write(Arrive),write(' at '),(Atime =:= 2400->write('0000');write(Atime)),write(' hrs. '),
                                                  nl,write('Total travel time '),write(Durationhrs),write(' hrs '),write(Durationmns),write(' minutes'),write(' and cost is $US '),format('~2f',Cost)),nl,fail.

select_option1(3):-directinfo(Cost,Airline,Depart,Dtime,Portname1,Portname2,Arrive,Atime,Durationhrs,Durationmns),((Cost>400,Cost<600)-> nl,write(Airline),write(' departs '),write(Portname1),write(', '),write(Depart),
                                                  write(' at '),write(Dtime),write(' hrs'),write(' and should arrive at '),write(Portname2),write(', '),write(Arrive),write(' at '),(Atime =:= 2400->write('0000');write(Atime)),write(' hrs. '),
                                                  nl,write('Total travel time '),write(Durationhrs),write(' hrs '),write(Durationmns),write(' minutes'),write(' and cost is $US '),format('~2f',Cost)),nl,fail.

select_option1(4):-directinfo(Cost,Airline,Depart,Dtime,Portname1,Portname2,Arrive,Atime,Durationhrs,Durationmns),((Cost>600,Cost<800)-> nl,write(Airline),write(' departs '),write(Portname1),write(', '),write(Depart),
                                                  write(' at '),write(Dtime),write(' hrs'),write(' and should arrive at '),write(Portname2),write(', '),write(Arrive),write(' at '),(Atime =:= 2400->write('0000');write(Atime)),write(' hrs. '),
                                                  nl,write('Total travel time '),write(Durationhrs),write(' hrs '),write(Durationmns),write(' minutes'),write(' and cost is $US '),format('~2f',Cost)),nl,fail.

select_option1(5):-directinfo(Cost,Airline,Depart,Dtime,Portname1,Portname2,Arrive,Atime,Durationhrs,Durationmns),((Cost>800,Cost<1000)-> nl,write(Airline),write(' departs '),write(Portname1),write(', '),write(Depart),
                                                  write(' at '),write(Dtime),write(' hrs'),write(' and should arrive at '),write(Portname2),write(', '),write(Arrive),write(' at '),(Atime =:= 2400->write('0000');write(Atime)),write(' hrs. '),
                                                  nl,write('Total travel time '),write(Durationhrs),write(' hrs '),write(Durationmns),write(' minutes'),write(' and cost is $US '),format('~2f',Cost)),nl,fail.


%*******************************************************************************

%DURATION PREFERENCE
%*******************************************************************************
duration_preference:-nl,write('Select a duration range to view information'),nl,write('Duration below 4 (hrs): \t\t1'),nl,write('Duration between 4-8 (hrs): \t\t2'),
        nl,write('Duration between 8-12 (hrs): \t\t3'),nl,write('Duration between 12-16 (hrs): \t\t4'),nl,write('Duration between 16-20 (hrs): \t\t5'),nl,write('Duration between 20-24 (hrs): \t\t6'),nl,
       write('Enter Choice:'),catch(read(Ans), _,(nl, write('** INVALID INPUT **'),nl,nl, fail)),select_option2(Ans).

select_option2(1):-directinfo(Cost,Airline,Depart,Dtime,Portname1,Portname2,Arrive,Atime,Durationhrs,Durationmns),((Durationhrs<4)-> nl,write(Airline),write(' departs '),write(Portname1),write(', '),write(Depart),
                                                  write(' at '),write(Dtime),write(' hrs'),write(' and should arrive at '),write(Portname2),write(', '),write(Arrive),write(' at '),(Atime =:= 2400->write('0000');write(Atime)),write(' hrs. '),
                                                  nl,write('Total travel time '),write(Durationhrs),write(' hrs '),write(Durationmns),write(' minutes'),write(' and cost is $US '),format('~2f',Cost)),nl,fail.

select_option2(2):-directinfo(Cost,Airline,Depart,Dtime,Portname1,Portname2,Arrive,Atime,Durationhrs,Durationmns),((Durationhrs>4,Durationhrs<8)-> nl,write(Airline),write(' departs '),write(Portname1),write(', '),write(Depart),
                                                  write(' at '),write(Dtime),write(' hrs'),write(' and should arrive at '),write(Portname2),write(', '),write(Arrive),write(' at '),(Atime =:= 2400->write('0000');write(Atime)),write(' hrs. '),
                                                  nl,write('Total travel time '),write(Durationhrs),write(' hrs '),write(Durationmns),write(' minutes'),write(' and cost is $US '),format('~2f',Cost)),nl,fail.

select_option2(3):-directinfo(Cost,Airline,Depart,Dtime,Portname1,Portname2,Arrive,Atime,Durationhrs,Durationmns),((Durationhrs>8,Cost<12)-> nl,write(Airline),write(' departs '),write(Portname1),write(', '),write(Depart),
                                                  write(' at '),write(Dtime),write(' hrs'),write(' and should arrive at '),write(Portname2),write(', '),write(Arrive),write(' at '),(Atime =:= 2400->write('0000');write(Atime)),write(' hrs. '),
                                                  nl,write('Total travel time '),write(Durationhrs),write(' hrs '),write(Durationmns),write(' minutes'),write(' and cost is $US '),format('~2f',Cost)),nl,fail.

select_option2(4):-directinfo(Cost,Airline,Depart,Dtime,Portname1,Portname2,Arrive,Atime,Durationhrs,Durationmns),((Durationhrs>12,Durationhrs<16)-> nl,write(Airline),write(' departs '),write(Portname1),write(', '),write(Depart),
                                                  write(' at '),write(Dtime),write(' hrs'),write(' and should arrive at '),write(Portname2),write(', '),write(Arrive),write(' at '),(Atime =:= 2400->write('0000');write(Atime)),write(' hrs. '),
                                                  nl,write('Total travel time '),write(Durationhrs),write(' hrs '),write(Durationmns),write(' minutes'),write(' and cost is $US '),format('~2f',Cost)),nl,fail.

select_option2(5):-directinfo(Cost,Airline,Depart,Dtime,Portname1,Portname2,Arrive,Atime,Durationhrs,Durationmns),((Durationhrs>16,Cost<20)-> nl,write(Airline),write(' departs '),write(Portname1),write(', '),write(Depart),
                                                  write(' at '),write(Dtime),write(' hrs'),write(' and should arrive at '),write(Portname2),write(', '),write(Arrive),write(' at '),(Atime =:= 2400->write('0000');write(Atime)),write(' hrs. '),
                                                  nl,write('Total travel time '),write(Durationhrs),write(' hrs '),write(Durationmns),write(' minutes'),write(' and cost is $US '),format('~2f',Cost)),nl,fail.

select_option2(6):-directinfo(Cost,Airline,Depart,Dtime,Portname1,Portname2,Arrive,Atime,Durationhrs,Durationmns),((Durationhrs>20,Cost<24)-> nl,write(Airline),write(' departs '),write(Portname1),write(', '),write(Depart),
                                                  write(' at '),write(Dtime),write(' hrs'),write(' and should arrive at '),write(Portname2),write(', '),write(Arrive),write(' at '),(Atime =:= 2400->write('0000');write(Atime)),write(' hrs. '),
                                                  nl,write('Total travel time '),write(Durationhrs),write(' hrs '),write(Durationmns),write(' minutes'),write(' and cost is $US '),format('~2f',Cost)),nl,fail.

%*******************************************************************************

retract_all:-retractall(directinfo(_,_,_,_,_,_,_,_,_,_)).

%560(Total duration) + 170 + 300

/*if(Flight 1 Atime < Flight 2 Dtime)
   {Delay = Flight 2 Dtime - Flight 1 Atime}
   
   else if (Flight 1 Atime > Flight 2 Dtime)
   {Delay = Flight 1 Atime - Flight 2 Dtime)
 */
