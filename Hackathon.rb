#------------------------------------------------------------------------------------------------------------
#Evan Hope
#2/15/21
#Assignment 1: Application Development
#Program which user inputs 2 csv files containing information about rooms and the times the rooms are booked.
#The user also enters information about an event they would like to host. The program then parses the 2 csv 
#files and compares the file and input from user and generates a schedule for the event.
#------------------------------------------------------------------------------------------------------------
require 'csv'
#------------------------------------------------------------------------------------------------------------
#User Input collection
##getRoomFileName: Prompts user to enter room information csv and ensures that file exsists and returns
#a table of the data.
##getScheduleFileName: Prompts user to enter schedule information csv and ensures that file exsists and
#returns a table of the data.
##getDateString: prompts user to enter event date and ensures it is a valid date and returns the data
#as a string.
##getStartTime: prompts user to enter start time of the event and returns the time as a string.
##getDuration: prompts user to enter the duration of the event in hours and returns the duration as an int.
##getAttendees: prompts user to enter number of attendees and return number as an int.
#------------------------------------------------------------------------------------------------------------
def getRoomFileName()
    j = 1
    while j == 1 #getting user input for room information file
        puts "Enter room information filename (including .csv): "
        file = gets.chomp
        if File.exist?(file)#if file exists, continue
            roomTable = CSV.parse(File.read(file), headers: true)
            j = 0
            return roomTable
        else #if file doesnt exist, loop back
            puts "Incorrect file, please try again \n"
        end
    end
end


def getScheduleFileName()
    j = 1
    while j == 1 #getting user input for schedule file
        puts "Enter schedule filename (including .csv): "
        file = gets.chomp
        if File.exist?(file)#if file exists, continue
            scheduleTable = CSV.parse(File.read(file), headers: true)
            j = 0
            return scheduleTable
        else #if file doesnt exist, loop back
            puts "Incorrect file, please try again \n"
        end
    end
end

def getDateString()
    j = 1
    while j == 1
        puts "Enter date of event (Format: yyyy-mm-dd)"
        #TODO:Make sure user enters correct format
        inputDate = gets.chomp
        y, m, d = inputDate.split '-'
        if Date.valid_date? y.to_i, m.to_i, d.to_i
            j = 0
            return inputDate
        else
            puts "incorrect format, please try again"
        end
    end
end

def getStartTime()
    puts "Enter start time of event (Format: hh:mm AM/PM)"
    inputStartTime = gets.chomp
    return inputStartTime
end

def getDuration()
    puts "Enter duration of event in hours"
    inputDuration = gets.chomp.to_i
    return inputDuration
end

def getAttendees()
    puts "Enter number of attendees"
    inputNumOfAttendees = gets.chomp
    return inputNumOfAttendees
end
#------------------------------------------------------------------------------------------------------------
#Time Handler Functions
#initialTimeDecimal: converts users input of time into decimal format.
#timeIteratorDecimal: simply adds 1 to the given time decimal.
#timeDecToString: converts time decimal into a time string which can be used to parse the schedule file.
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
##Room class Varibles: building, roomNum, capacity, computerAvail, seatingAvail, seatingType, food, priority,
#roomType
##Room class functions:
##initialize: intializes the majority of the room classes varribles.
##checkRoomAvailibilty: cross checks the building and room number of the room with the scheduleTable using
#provided date and time to return if the room is availible
##reserveRoom: sets "Available" column in scheduleTable to false for the provided date and time
##addToCapacity: adds attendees to room until capcity is full and returns amount of atendees that could
#not be added do to max capacity
##getCurrentCapacity: returns current capcity
##displayInfo: returns the rooms varribles used for printing information
##emptyRoom: sets current capcity of the room to 0
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

    #Method to change rooms availibility in scheulde csv IMPORTANT: not working correctly
    def reserveRoom(date, time, scheduleTable)
        j=0
        reservedRooms = []
        while j < scheduleTable.size
            if date == scheduleTable[j]["Date"] && time == scheduleTable[j]["Time"] && self.building == scheduleTable[j]["Building"] && self.roomNum == scheduleTable[j]["Room"]
                scheduleTable[j]["Available"] = "false"
            end
            j+=1
        end
    end

    #Method that adds students to rooms current capacity and returns amount of leftover students.
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
        return "Buidling: " + self.building + ", Room: " + self.roomNum.to_s + ", Max Capacity: " + self.capacity.to_s + ", Computers Availible: " + self.computerAvail + ", Seating Availible: " + self.seatingAvail + ", Seating Type: " + self.seatingType + ", Food Allowed: " + self.food + ", Priority: " + self.priority + ", Room Type: " + self.roomType
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
def createRooms(roomTable)

    roomsArray = []
    i = 0
    while i < roomTable.size
        roomsArray[i] = Room.new(roomTable[i]["Building"], roomTable[i]["Room"], roomTable[i]["Capacity"], roomTable[i]["Computers Available"], roomTable[i]["Seating Available"], roomTable[i]["Seating Type"], roomTable[i]["Food Allowed"], roomTable[i]["Priority"], roomTable[i]["Room Type"])
        i+=1
    end
    return roomsArray
end
#------------------------------------------------------------------------------------------------------------
##emptyAllRooms: empties all rooms in roomsArray will be used every itteration of time to ensure all rooms
#are cleared
#------------------------------------------------------------------------------------------------------------
def emptyAllRooms(roomsArray)
    i=0
    while i < roomsArray.length()
        roomsArray[i].emptyRoom()
        i+=1
    end
end
#------------------------------------------------------------------------------------------------------------
#Display Functions
##displayAllRooms: loops through roomArray calling displayInfo function for each room in the array
##displaySchedule: loops through scheduleTable printing each row of the table
#------------------------------------------------------------------------------------------------------------
def displayAllRooms(roomsArray)
    i = 0
    while i < roomsArray.length()
        puts roomsArray[i].displayInfo()
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
#Seperating Functions
##seperateFullCapacityRooms: returns an array of all rooms that can hold all attendees at once
##seperateFoodRooms: returns an array of all rooms where food is allowed (Note: with this functionality we are
#assuming that food rooms will never be used to work in and only to eat in)
##seperateComputerRooms: returns an array of all rooms with computers availible
##seperateGenericRooms: returns an array of all rooms except for rooms you can eat in (Note: with this
#functionality event center rooms and conferance rooms will be added to this array therefore, we are assuming
#attendees can and will work in these rooms)
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
#Checkers
##fullCapacityGetter: checks availibily of each room in fullCapacityRoomsArray for given date and time
#displays all availible rooms and allows user to pick which room they would like to use then returns that room
#(Note: because the opening event is only one room and an important event the user has control of which room it 
#takes place in this functionality is not present for every room in the schedule)
##foodRoomsCheck: returns an array of all food rooms availible at given time and date using foodRoomsArray
##computerRoomsCheck: returns an array of all computer rooms availible at given time and date using computerRoomsArray
##genericRoomsCheck : returns and array of all generic rooms availible at given time and date using genericRoomsArray
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
#Adjustable variables (Note: for this assignment these varibles are set for an actual program it would be
#smart to allow the user to adjust these varribles)
percentOfAttendeesWhoEat = 0.6
percentOfAttendeesWhoNeedComputers = 0.1
#------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------
#Generating Schedule (Note: This is where the code gets a little messy)
#
#------------------------------------------------------------------------------------------------------------
def generateSchedule(roomsArray, inputNumOfAttendees, inputStartTime, inputDate, scheduleTable, inputDuration, percentOfAttendeesWhoNeedComputers, percentOfAttendeesWhoEat)
    x = 0
    reservedRooms = []
    fullCapacityRoomsArray = seperateFullCapacityRooms(roomsArray, inputNumOfAttendees)
    foodRoomsArray = seperateFoodRooms(roomsArray)
    computerRoomsArray = seperateComputerRooms(roomsArray)
    genericRoomsArray = seperateGenericRooms(roomsArray)


    timeDec = initialTimeDecimal(inputStartTime)
    timeString = timeDecToString(timeDec)
    puts timeString


    openingSessionRoom = fullCapacityGetter(fullCapacityRoomsArray, inputDate, inputStartTime, scheduleTable, inputNumOfAttendees)
    openingSessionRoom.reserveRoom(inputDate, timeString, scheduleTable)
    reservedRooms[x] = openingSessionRoom
    x+=1
    puts "Time: " + timeString
    puts "Opening event is occuring: "
    puts openingSessionRoom.displayInfo()

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
                reservedRooms[x] = foodRoomsAvailible[j]
                x+=1
                foodRoomsAvailible[j].reserveRoom(inputDate, timeString, scheduleTable)
                puts foodRoomsAvailible[j].displayInfo()
                if eatingAttendees == 0
                    break
                end
                j+=1
            end
            if(eatingAttendees > 0)
                puts "IMPORTANT: Not enough rooms for attendees to eat in during meal time!!!!"
                break
            end
        end
        
        computerRoomsAvailible = computerRoomsCheck(computerRoomsArray, inputDate, timeString, scheduleTable)
        puts "There will be a total of " + computerNeedingAttendees.to_s + " attendees using computers in the following rooms:" 
        j = 0
        while j <= computerRoomsAvailible.length() - 1 && computerNeedingAttendees > 0                                   #loops through all availible food rooms
            computerNeedingAttendees = computerRoomsAvailible[j].addToCapacity(computerNeedingAttendees)                 #Adds attendees to rooms then returns amount of remaining attendees not added to eatingAttendees
            reservedRooms[x] = computerRoomsAvailible[j]
            x+=1
            computerRoomsAvailible[j].reserveRoom(inputDate, timeString, scheduleTable)
            puts computerRoomsAvailible[j].displayInfo()
            if computerNeedingAttendees == 0
                break
            end
            j+=1
        end
        if(computerNeedingAttendees > 0)
            puts "IMPORTANT: Not enough rooms for attendees to use computers in!!!!"
            break
        end

        genericRoomsAvailible = genericRoomsCheck(genericRoomsArray, inputDate, timeString, scheduleTable)
        puts "There will be a total of " + currNumOfAttendees.to_s + " attendees working in the following rooms:" 
        j = 0
        while j <= genericRoomsAvailible.length() - 1 && currNumOfAttendees > 0                                     #loops through all availible food rooms
            currNumOfAttendees = genericRoomsAvailible[j].addToCapacity(currNumOfAttendees)                         #Adds attendees to rooms then returns amount of remaining attendees not added to eatingAttendees
            reservedRooms[x] = genericRoomsAvailible[j]
            x+=1
            genericRoomsAvailible.reserveRoom(inputDate, timeString, scheduleTable)
            puts genericRoomsAvailible[j].displayInfo()
            if currNumOfAttendees == 0
                break
            end
            j+=1
        end
        if(currNumOfAttendees > 0)
            puts "IMPORTANT: Not enough rooms for attendees to use work in!!!!"
            break
        end
        

        i+=1
    end
    emptyAllRooms(roomsArray)
    timeDec = timeIteratorDecimal(timeDec)
    timeString = timeDecToString(timeDec)
    
    closingSessionRoom = fullCapacityGetter(fullCapacityRoomsArray, inputDate, timeString, scheduleTable, inputNumOfAttendees)
    reservedRooms[x] = closingSessionRoom
    puts "Time: " + timeString
    puts "Closing event will occur: "
    closingSessionRoom.reserveRoom(inputDate, timeString, scheduleTable)
    puts closingSessionRoom.displayInfo()

    return reservedRooms
end
#------------------------------------------------------------------------------------------------------------
##cleanReservedList: the way the reservedRooms array is create causes many duplicates since we just want to
#see the rooms that are reserved throughout the entire event this function deletes duplicate rooms from the
#array.
#------------------------------------------------------------------------------------------------------------
def cleanReservedList(reservedRooms)
    i = 0
    j = 0
    while i < reservedRooms.length()
        temp = reservedRooms[i]
        j = i + 1
        while j < reservedRooms.length()
            if temp == reservedRooms[j]
                reservedRooms.delete_at(j)
                j -=1
            end
            j +=1
        end
        i+=1
    end
end
#------------------------------------------------------------------------------------------------------------
#Main
#prompts user to enter all required information then displays menu:
#[1] Displays menu again
#[2] Prompts user to enter all required information again if they would like to change something
#[3] Lists all rooms in provided room csv
#[4] Lists schedule provided in schedule csv
#[5] Generates suggested schedule based on user input
#[6] Displays all rooms that have been Reserved
#[7] Generates a csv output file with all rooms that have been reserved and their Information
#[8] Exits the program
#------------------------------------------------------------------------------------------------------------
roomTable = getRoomFileName()
scheduleTable = getScheduleFileName()
inputDate = getDateString()
inputStartTime = getStartTime()
inputDuration = getDuration()
inputNumOfAttendees = getAttendees()

roomsArray = createRooms(roomTable)


selection = 1
while selection == 1
    puts "[1] Main Menu"
    puts "[2] Change Information"
    puts "[3] List Rooms"
    puts "[4] List Schedule"
    puts "[5] Generate Schedule"
    puts "[6] Display Reserved Rooms"
    puts "[7] Exit"
    puts "Enter Selection: "
    selection = gets.chomp
    case selection.to_i
    when 2
        roomTable = getRoomFileName()
        scheduleTable = getScheduleFileName()
        inputDate = getDateString()
        inputStartTime = getStartTime()
        inputDuration = getDuration()
        inputNumOfAttendees = getAttendees()
        roomsArray = createRooms(roomTable)
        selection = 1
    when 3
        displayAllRooms(roomsArray)
        selection = 1
    when 4
        displaySchedule(scheduleTable)
        selection = 1
    when 5
        reservedRooms = []
        reservedRooms = generateSchedule(roomsArray, inputNumOfAttendees, inputStartTime, inputDate, scheduleTable, inputDuration, percentOfAttendeesWhoNeedComputers, percentOfAttendeesWhoEat)
        selection = 1
    when 6
        if reservedRooms != nil
            cleanReservedList(reservedRooms)
            i = 0
            while i < reservedRooms.length()
                puts reservedRooms[i].displayInfo() 
                i+=1
            end
        else
            puts "You must generate schedule before seeing reserved rooms."
        end
        selection = 1
    when 7
        exit(true)
    else
        selection = 1
    end
end