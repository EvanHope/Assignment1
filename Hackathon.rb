#------------------------------------------------------------------------------------------------------------
#Evan Hope
#2/15/21
#Assignment 1: Application Development
#Program which user inputs 2 csv files containing information about rooms and the times the rooms are booked.
#The user also enters information about an event they would like to host. The program then parses the 2 csv 
#files and compares the file and input from user to find suitible rooms and times for specified event.
#------------------------------------------------------------------------------------------------------------
require 'csv'


#------------------------------------------------------------------------------------------------------------
#User Input collection
#Gets name of csv files and formats into parsed table also gets required information about event
#
#Varribles: roomTable, scheduleTable, roomCsvLength, scheduleCsvLength, inputDate, inputStartTime,
#inputDuration, inputNumOfAttendees
#------------------------------------------------------------------------------------------------------------
j = 1
while j == 1 #getting user input for room information file
    puts "Enter room information filename (including .csv): "
    file = gets.chomp
    if File.exist?(file)#if file exists, continue
        roomTable = CSV.parse(File.read(file), headers: true)
        j = 0
        break
    else #if file doesnt exist, loop back
        puts "Incorrect file, please try again \n"
    end
end

j = 1
while j == 1 #getting user input for schedule file
    puts "Enter schedule filename (including .csv): "
    file = gets.chomp
    if File.exist?(file)#if file exists, continue
        scheduleTable = CSV.parse(File.read(file), headers: true)
        j = 0
        break
    else #if file doesnt exist, loop back
        puts "Incorrect file, please try again \n"
    end
end

roomCsvLength = roomTable.size
scheduleCsvLength = scheduleTable.size

#j = 1
#while j == 1
    puts "Enter date of event (Format: yyyy-mm-dd)"
    #TODO:Make sure user enters correct format
    inputDate = gets.chomp
    #if inputDate is valid
        #j = 0
        #break
    #else
        #puts incorrect format, please try again
    #end

    puts "Enter start time of event (Format: hh.mm AM/PM)"
    inputStartTime = gets.chomp

    puts "Enter duration of event (Format: hh.mm)"
    inputDuration = gets.chomp

    puts "Enter number of attendees"
    inputNumOfAttendees = gets.chomp

#------------------------------------------------------------------------------------------------------------
#Room Class Definition
#Room class Varibles: building, roomNum, capacity, computerAvail, seatingAvail, seatingType, food, priority,
#roomType
#
#------------------------------------------------------------------------------------------------------------
#Room Object
class Room
    attr_reader :building, :roomNum, :capacity, :computerAvail, :seatingAvail, :seatingType, :food, :priority, :roomType

    def initialize(building, roomNum, capacity, computerAvail, seatingAvail, seatingType, food, priority, roomType)
        @building = building
        @roomNum = roomNum
        @capacity = capacity
        @computerAvail = computerAvail
        @seatingAvail = seatingAvail
        @seatingType = seatingType
        @food = food
        @priority = priority
        @roomType = roomType
    end
#    def setSchedule(index, availiblity, )
#        availiblity[index] = availiblity
#    end
end

#------------------------------------------------------------------------------------------------------------
#Room Object Creation
#Creates a room object for each room in roomTable and assigns its varibles using roomTable data
#
#------------------------------------------------------------------------------------------------------------
#While loop to create a Room obj for each row in rooms.csv
roomsArray = []
i = 0
while i < roomCsvLength
    roomsArray[i] = Room.new(roomTable[i]["Building"], roomTable[i]["Room"], roomTable[i]["Capacity"], roomTable[i]["Computers Available"], roomTable[i]["Seating Available"], roomTable[i]["Seating Type"], roomTable[i]["Food Allowed"], roomTable[i]["Priority"], roomTable[i]["Room Type"])
#    j = 0
#    a = 0
#    while j < scheduleCsvLength
#        if roomsArray[i].building == scheduleTable[j]["Building"] && roomsArray[i].roomNum == scheduleTable[j]["Room"]
#            roomsArray[i].setSchedule(a, scheduleTable[j]["Available"], )
#    end
    i+=1
end

puts roomsArray[1].roomNum
puts roomsArray[2].roomNum

#------------------------------------------------------------------------------------------------------------
#Seperates speciality rooms into their own arrays so certain requirements can be satisfied easily
#------------------------------------------------------------------------------------------------------------

i = 0
fullCapacityRoomsArray = []
foodRoomsArray = []
computerRoomsArray = []
while i < roomsArray.length
    if roomsArray[i].capacity >= inputNumOfAttendees && (roomsArray[i].roomType == "Conference Room" || roomsArray[i].roomType == "Event Center")
        fullCapacityRoomsArray.append(roomsArray[i])
    end
    if roomsArray[i].food == "yes"
        foodRoomsArray.append(roomsArray[i])
    end
    i+=1
end