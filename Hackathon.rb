#------------------------------------------------------------------------------------------------------------
#Evan Hope
#2/15/21
#Assignment 1: Application Development
#Program which user inputs 2 csv files containing information about rooms and the times the rooms are booked.
#The user also enters information about an event they would like to host. The program then parses the 2 csv 
#files and compares the file and input from user to find suitible rooms and times for specified event.
#------------------------------------------------------------------------------------------------------------
require 'csv'
require 'date'
require 'time'

#------------------------------------------------------------------------------------------------------------
#User Input collection
#Gets name of csv files and formats into parsed table also gets required information about event
#
#Varribles: roomTable, scheduleTable, roomCsvLength, scheduleCsvLength, inputDate, inputStartTime,
#inputDuration, inputNumOfAttendees
#------------------------------------------------------------------------------------------------------------
=begin
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
    #Date = Date.iso8601(inputDate)
    #if Date.valid_date?(inputDate.slice(0...3), inputDate.slice(5...6), inputDate.slice(8...9))
        #j = 0
        #break
    #else
        #puts "incorrect format, please try again"
    #end
#end

    puts "Enter start time of event (Format: hh.mm AM/PM)"
    inputStartTime = gets.chomp
    inputStartTime = Time.parse(inputStartTime)
    #dateAndTime = inputDate + " " + inputStartTime
    #startTime = Time.strptime(dateAndTime)
    #puts startTime

    puts "Enter duration of event (Format: hh.mm)"
    inputDuration = gets.chomp

    puts "Enter number of attendees"
    inputNumOfAttendees = gets.chomp
=end
roomTable = CSV.parse(File.read("rooms.csv"), headers: true)
scheduleTable = CSV.parse(File.read("schedule.csv"), headers: true)
roomCsvLength = roomTable.size
scheduleCsvLength = scheduleTable.size
inputDate = "2000-04-12"
inputStartTime = "10.00 AM"
inputStartTime = Time.parse(inputStartTime)
inputDuration = 5.00
inputNumOfAttendees = 50

#------------------------------------------------------------------------------------------------------------
#Room Class Definition
#Room class Varibles: building, roomNum, capacity, computerAvail, seatingAvail, seatingType, food, priority,
#roomType
#
#------------------------------------------------------------------------------------------------------------
#Room Object
class Room
    attr_reader :building, :roomNum, :capacity, :computerAvail, :seatingAvail, :seatingType, :food, :priority, :roomType, :currentCapacity

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
    #Method used to check availibility of room using schedule csv
    def checkRoomAvailibilty(date, time, scheduleCsvLength, scheduleTable)
        j=0
        while j < scheduleCsvLength
            if date == scheduleTable[j]["Date"] && time == scheduleTable[j]["Time"] && self.building == scheduleTable[j]["Building"] && self.roomNum == scheduleTable[j]["Room"] && "true" == scheduleTable[j]["Available"]
                return true
            else
                j+=1
            end
        end
        return false
    end
    #TODO: Better way to deal with capcity issues prob fill room and return amount of students still left.
    def setCurrentCapacity(newCapacity)
        if newCapacity <= self.capacity
            @currentCapacity = newCapacity
        else
            puts "error capacity overloaded not filling room"
        end
    end
    def getCurrentCapacity()
        return @currentCapcity
    end
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
    i+=1
end

puts roomsArray[0].checkRoomAvailibilty("2020-02-10", "12:00 AM", scheduleCsvLength, scheduleTable) #Works!!!!
#puts roomsArray[1].roomNum
#puts roomsArray[2].roomNum

#------------------------------------------------------------------------------------------------------------
#Seperates speciality rooms into their own arrays so certain requirements can be satisfied easily
#------------------------------------------------------------------------------------------------------------
=begin
i = 0
j = 0
x = 0
fullCapacityRoomsArray = []
foodRoomsArray = []
computerRoomsArray = []
while i < roomsArray.length
    if roomsArray[i].capacity >= inputNumOfAttendees && (roomsArray[i].roomType == "Conference Room" || roomsArray[i].roomType == "Event Center")
        fullCapacityRoomsArray[j] = roomsArray[i]
        j += 1
    end
    if roomsArray[i].food == "yes"
        foodRoomsArray[x] = roomsArray[i]
        x += 1
    end
    i+=1
end
=end