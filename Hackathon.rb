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
#Varribles: roomTable, scheduleTable, roomCsvLength, scheduleTable.size, inputDate, inputStartTime,
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
#scheduleTable.size = scheduleTable.size

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

    puts "Enter start time of event (Format: hh:mm AM/PM)"
    inputStartTime = gets.chomp
    #inputStartTime = Time.parse(inputStartTime)
    #dateAndTime = inputDate + " " + inputStartTime
    #startTime = Time.strptime(dateAndTime)
    #puts startTime

    puts "Enter duration of event (Format: hh:mm)"
    inputDuration = gets.chomp.to_i

    puts "Enter number of attendees"
    inputNumOfAttendees = gets.chomp
=begin
roomTable = CSV.parse(File.read("rooms.csv"), headers: true)
scheduleTable = CSV.parse(File.read("schedule.csv"), headers: true)
roomCsvLength = roomTable.size
inputDate = "2020-02-13"
inputStartTime = "02:00 AM"
#inputStartTime = Time.parse(inputStartTime)
inputDuration = 5
inputNumOfAttendees = 150
=end


#------------------------------------------------------------------------------------------------------------
#Iterate Time
#------------------------------------------------------------------------------------------------------------
def initialTimeDecimal(inputStartTime)
    split = inputStartTime.split(':')
    hours = split[0].to_i
    split = split[1].split(' ')
    #mins = split[0].to_i
    if (split[1] == "PM")
        hours += 12
    end
    return hours
end

def timeIteratorDecimal(timeDec)
    return timeDec + 1
end

def timeDecToString(timeDec)
    case timeDec
    when 1
        return "01:00 AM"
    when 2
        return "02:00 AM"
    when 3
        return "03:00 AM"
    when 4
        return "04:00 AM"
    when 5
        return "05:00 AM"
    when 6
        return "06:00 AM"
    when 7
        return "07:00 AM"
    when 8
        return "08:00 AM"
    when 9
        return "09:00 AM"
    when 10
        return "10:00 AM"
    when 11
        return "11:00 AM"
    when 12
        return "12:00 PM"
    when 13
        return "01:00 PM"
    when 14
        return "02:00 PM"
    when 15
        return "03:00 PM"
    when 16
        return "04:00 PM"
    when 17
        return "05:00 PM"
    when 18
        return "06:00 PM"
    when 19
        return "07:00 PM"
    when 20
        return "08:00 PM"
    when 21
        return "09:00 PM"
    when 22
        return "10:00 PM"
    when 23
        return "11:00 PM"
    when 24
        return "12:00 AM"
    else
        puts "ERROR: IN TIME TO STRING"
    end
end

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
        @currentCapacity = 0
    end
    #Method used to check availibility of room using schedule csv
    def checkRoomAvailibilty(date, time, scheduleTable)
        j=0
        while j < scheduleTable.size
            if date == scheduleTable[j]["Date"] && time == scheduleTable[j]["Time"] && self.building == scheduleTable[j]["Building"] && self.roomNum == scheduleTable[j]["Room"] && "true" == scheduleTable[j]["Available"]
                return true
            else
                j+=1
            end
        end
        return false
    end
    #Function that adds students to rooms current capacity and returns amount of leftover students.
    def addToCapacity(amountToAdd)
        if (amountToAdd.to_i + self.currentCapacity.to_i) <= self.capacity.to_i
            newCapacity = self.currentCapacity.to_i + amountToAdd.to_i
            @currentCapacity = newCapacity
            return 0
        else
            difference = self.capacity.to_i - self.currentCapacity.to_i
            @currentCapacity += difference
            return amountToAdd - difference
        end
    end
    def getCurrentCapacity()
        return self.currentCapacity
    end

    def displayInfo()
        return "Buidling: " + self.building + ", Room: " + self.roomNum.to_s + ", Current Capacity: " + self.currentCapacity.to_s + ", Max Capacity: " + self.capacity.to_s
    end

    def emptyRoom()
        @currentCapacity = 0
    end
end

#------------------------------------------------------------------------------------------------------------
#Room Object Creation
#Creates a room object for each room in roomTable and assigns its varibles using roomTable data then returns
#array holding all rooms
#------------------------------------------------------------------------------------------------------------
#While loop to create a Room obj for each row in rooms.csv
def createRooms(roomCsvLength, roomTable)

    roomsArray = []
    i = 0
    while i < roomCsvLength
        roomsArray[i] = Room.new(roomTable[i]["Building"], roomTable[i]["Room"], roomTable[i]["Capacity"], roomTable[i]["Computers Available"], roomTable[i]["Seating Available"], roomTable[i]["Seating Type"], roomTable[i]["Food Allowed"], roomTable[i]["Priority"], roomTable[i]["Room Type"])
        i+=1
    end
    return roomsArray
end

#puts roomsArray[0].checkRoomAvailibilty("2020-02-13", "02:00 AM", scheduleTable.size, scheduleTable) #Works!!!!
#puts roomsArray[1].roomNum
#puts roomsArray[2].roomNum


def displayAllRooms(roomsArray)
    i = 0
    while i < roomsArray.length()
        puts "Building: " + roomsArray[i].building + ", Room: " + roomsArray[i].roomNum + ", Max Capacity: " + roomsArray[i].capacity + ", Computers Availible: " + roomsArray[i].computerAvail + ", Seating Availible: " + roomsArray[i].seatingAvail + ", Seating Type: " + roomsArray[i].seatingType + ", Food Allowed: " + roomsArray[i].food + ", Priority: " + roomsArray[i].priority + ", Room Type: " + roomsArray[i].roomType
        i+=1
    end
end

def displaySchedule(scheduleTable)
    i = 0
    while i < scheduleTable.length()
        puts scheduleTable[i]
        i+=1
    end
end

#------------------------------------------------------------------------------------------------------------
#Three seperate functions that seperate rooms into arrays by their specialties and returns those arrays.
#------------------------------------------------------------------------------------------------------------
def seperateFullCapacityRooms(roomsArray, inputNumOfAttendees)
    i = 0
    j = 0
    fullCapacityRoomsArray = []
    while i < roomsArray.length
        if roomsArray[i].capacity.to_i >= inputNumOfAttendees.to_i 
            fullCapacityRoomsArray[j] = roomsArray[i]
            j += 1
        end
        i+=1
    end
    return fullCapacityRoomsArray
end
def seperateFoodRooms(roomsArray)
    i = 0
    j = 0
    foodRoomsArray = []

    while i < roomsArray.length
        if roomsArray[i].food == "Yes"
            foodRoomsArray[j] = roomsArray[i]
            j += 1
        end
        i+=1
    end
    return foodRoomsArray
end

def seperateComputerRooms(roomsArray)
    i = 0
    j = 0
    computerRoomsArray = []
    while i < roomsArray.length
        if roomsArray[i].computerAvail == "Yes"
            computerRoomsArray[j] = roomsArray[i]
            j += 1
        end
        i+=1
    end
    return computerRoomsArray
end

#Rooms that have computer rooms can also be considered generic
def seperateGenericRooms(roomsArray)
    i = 0
    j = 0
    genericRoomsArray = []
    while i < roomsArray.length
        if roomsArray[i].food == "No" #Allows computer rooms in generic rooms for practicality reasons
            genericRoomsArray[j] = roomsArray[i]
            j+=1
        end
        i+=1
    end
    return genericRoomsArray
end

#------------------------------------------------------------------------------------------------------------
#User Selection of availible rooms
#------------------------------------------------------------------------------------------------------------
def fullCapacityGetter(fullCapacityRoomsArray, inputDate, timeString, scheduleTable, inputNumOfAttendees)
    puts "The following rooms are suitible for hosting a full capcity session:"
    j = 0
    while j < fullCapacityRoomsArray.length()
        if fullCapacityRoomsArray[j].checkRoomAvailibilty(inputDate, timeString, scheduleTable)
            puts j.to_s + ": Building: " + fullCapacityRoomsArray[j].building + ", Room: " + fullCapacityRoomsArray[j].roomNum + ", Capacity: " + fullCapacityRoomsArray[j].capacity + ", Computers Availible: " + fullCapacityRoomsArray[j].computerAvail + ", Food Allowed: " + fullCapacityRoomsArray[j].food
        end
        j+=1
    end
    puts "Enter number corresponding to the room you would like to reserve:"
    roomIndex = gets.chomp
    fullCapacityRoomsArray[roomIndex.to_i].addToCapacity(inputNumOfAttendees.to_i)
    return fullCapacityRoomsArray[roomIndex.to_i]
end


#Returns Array with all food rooms availible at given time
def foodRoomsCheck(foodRoomsArray, inputDate, timeString, scheduleTable)
    j=0
    i=0
    foodRoomsAvailible = []
    while j < foodRoomsArray.length()
        if foodRoomsArray[j].checkRoomAvailibilty(inputDate, timeString, scheduleTable)
            foodRoomsAvailible[i] = foodRoomsArray[j]
            i += 1
        end
        j += 1
    end
    return foodRoomsAvailible
end

def computerRoomsCheck(computerRoomsArray, inputDate, timeString, scheduleTable)
    j=0
    i=0
    computerRoomsAvailible = []
    while j < computerRoomsArray.length()
        if computerRoomsArray[j].checkRoomAvailibilty(inputDate, timeString, scheduleTable)
            computerRoomsAvailible[i] = computerRoomsArray[j]
            i += 1
        end
        j += 1
    end
    return computerRoomsAvailible
end

def genericRoomsCheck(genericRoomsArray, inputDate, timeString, scheduleTable)
    j=0
    i=0
    genericRoomsAvailible = []
    while j < genericRoomsArray.length()
        if genericRoomsArray[j].checkRoomAvailibilty(inputDate, timeString, scheduleTable)
            genericRoomsAvailible[i] = genericRoomsArray[j]
            i += 1
        end
        j += 1
    end
    return genericRoomsAvailible
end

#------------------------------------------------------------------------------------------------------------
#Function to empty all rooms in order to reset each hour
#------------------------------------------------------------------------------------------------------------
def emptyAllRooms(roomsArray)
    i=0
    while i < roomsArray.length()
        roomsArray[i].emptyRoom()
        i+=1
    end
end



#------------------------------------------------------------------------------------------------------------
#Adjustable variables
percentOfAttendeesWhoEat = 0.6
percentOfAttendeesWhoNeedComputers = 0.1
#------------------------------------------------------------------------------------------------------------
roomsArray = createRooms(roomCsvLength, roomTable)

def checkAvailibility(roomsArray, inputNumOfAttendees, inputStartTime, inputDate, scheduleTable, inputDuration, percentOfAttendeesWhoNeedComputers, percentOfAttendeesWhoEat)
    fullCapacityRoomsArray = seperateFullCapacityRooms(roomsArray, inputNumOfAttendees)
    foodRoomsArray = seperateFoodRooms(roomsArray)
    computerRoomsArray = seperateComputerRooms(roomsArray)
    genericRoomsArray = seperateGenericRooms(roomsArray)


    timeDec = initialTimeDecimal(inputStartTime)
    timeString = timeDecToString(timeDec)
    puts timeString


    openingSessionRoom = fullCapacityGetter(fullCapacityRoomsArray, inputDate, inputStartTime, scheduleTable, inputNumOfAttendees)
    puts "Time: " + timeString
    puts "Opening event is occuring: "
    puts openingSessionRoom.displayInfo()
    #puts eventByHour[0][0].displayInfo()



    i = 1
    while i <= inputDuration.to_i - 1 #while the hour is before 1 hour before the end of the event continue to loop

        emptyAllRooms(roomsArray)
        timeDec = timeIteratorDecimal(timeDec)
        timeString = timeDecToString(timeDec)
        puts "Time: " + timeString

        currNumOfAttendees = inputNumOfAttendees.to_i
        computerNeedingAttendees = currNumOfAttendees * percentOfAttendeesWhoNeedComputers
        currNumOfAttendees -= computerNeedingAttendees
        #Used for hours where attendees eat
        if i == 4 || i == 10 || i == 16 || i == 22                                                                  #Times when attendees eat
            eatingAttendees = (currNumOfAttendees * percentOfAttendeesWhoEat)                                       #Calculates how many attendees are eating
            currNumOfAttendees -= eatingAttendees                                                                   #Seperates eating attendees from total # of attendees to deal with seperately
            puts "There will be a total of " + eatingAttendees.to_s + " attendees eating in the following rooms:"   #Tells user how many attendees are eating
            j = 0
            foodRoomsAvailible = foodRoomsCheck(foodRoomsArray, inputDate, timeString, scheduleTable)               #Returns food rooms availible at the given time and date
            while j <= foodRoomsAvailible.length() - 1 && eatingAttendees > 0                                       #loops through all availible food rooms
                eatingAttendees = foodRoomsAvailible[j].addToCapacity(eatingAttendees)                              #Adds attendees to rooms then returns amount of remaining attendees not added to eatingAttendees
                puts foodRoomsAvailible[j].displayInfo()
                if eatingAttendees == 0
                    break
                end
                j+=1
            end
            if(eatingAttendees > 0)
                puts "IMPORTANT: Not enough rooms for attendees to eat in during meal time!!!!"
                #TODO: Exit to menu
            end
        end
        
        computerRoomsAvailible = computerRoomsCheck(computerRoomsArray, inputDate, timeString, scheduleTable)
        puts "There will be a total of " + computerNeedingAttendees.to_s + " attendees using computers in the following rooms:" 
        j = 0
        while j <= computerRoomsAvailible.length() - 1 && computerNeedingAttendees > 0                                   #loops through all availible food rooms
            computerNeedingAttendees = computerRoomsAvailible[j].addToCapacity(computerNeedingAttendees)                 #Adds attendees to rooms then returns amount of remaining attendees not added to eatingAttendees
            puts computerRoomsAvailible[j].displayInfo()
            if computerNeedingAttendees == 0
                break
            end
            j+=1
        end
        if(computerNeedingAttendees > 0)
            puts "IMPORTANT: Not enough rooms for attendees to use computers in!!!!"
            #TODO: Exit to menu
        end

        genericRoomsAvailible = genericRoomsCheck(genericRoomsArray, inputDate, timeString, scheduleTable)
        puts "There will be a total of " + currNumOfAttendees.to_s + " attendees working in the following rooms:" 
        j = 0
        while j <= genericRoomsAvailible.length() - 1 && currNumOfAttendees > 0                                     #loops through all availible food rooms
            currNumOfAttendees = genericRoomsAvailible[j].addToCapacity(currNumOfAttendees)                         #Adds attendees to rooms then returns amount of remaining attendees not added to eatingAttendees
            puts genericRoomsAvailible[j].displayInfo()
            if currNumOfAttendees == 0
                break
            end
            j+=1
        end
        if(currNumOfAttendees > 0)
            puts "IMPORTANT: Not enough rooms for attendees to use work in!!!!"
            #TODO: Exit to menu
        end
        

        i+=1
    end
    #TODO: Final Presentation Event
end


#------------------------------------------------------------------------------------------------------------
#Main
#------------------------------------------------------------------------------------------------------------
selection = 1
while selection == 1
    puts "[1] Main Menu"
    puts "[2] List Rooms"
    puts "[3] List Schedule"
    puts "[4] Find Schedule"
    puts "[5] Exit"
    puts "Enter Selection: "
    selection = gets.chomp
    case selection.to_i
    when 2
        displayAllRooms(roomsArray)
        selection = 1
    when 3
        displaySchedule(scheduleTable)
        selection = 1
    when 4
        checkAvailibility(roomsArray, inputNumOfAttendees, inputStartTime, inputDate, scheduleTable, inputDuration, percentOfAttendeesWhoNeedComputers, percentOfAttendeesWhoEat)
        selection = 1
    when 5
        exit(true)
    else
        selection = 1
    end
    
end

