----------------------------------------------------------------------------------------------
Evan Hope
Assignment 1
Last Modified: 02/15/2021
----------------------------------------------------------------------------------------------

Instructions:
1) Enter rooms csv file name
2) Enter schedule csv file name
3) Enter date of event
4) Enter time of event
5) Enter duration of event
6) Enter number of attendees
7) The following menu will appear:
    "[1] Main Menu"
    "[2] Change Information"
    "[3] List Rooms"
    "[4] List Schedule"
    "[5] Generate Schedule"
    "[6] Display Reserved Rooms"
    "[7] Exit"

[1] Reprints the main menu
[2] Prompts user to input same data that is listed at the top of this file
[3] Lists all rooms in provided room csv
[4] Lists schedule provided in schedule csv
[5] Generates suggested schedule based on user input and outputs a txt file
[6] Displays all rooms that have been Reserved
[7] Exits the program

Notice: you must select "[5] Generate Schedule" before options [6] or [7].
If you do not generate before choosing these option the program will ask you
to generate the schedule first.

Design Decisions:
1) Application allows users to choose which room the opening session and final
presentation are in. This is due to these event being the most important rooms
where as the user does not select the rooms that attendees will eat in and use
to work in.
2) The generated .txt file prints how many attendees are participating in
each seperate activity then prints the rooms those activities are occuring in.


Missing Features:
1) Output file is a .txt file instead of a .csv file
2) Duration format is in hours and not suggested format of hh:mm

Known Bugs:
1) If date switches during event program fails without error
2) If user enters invalid input for startime, duration, or attendees program will fail without error