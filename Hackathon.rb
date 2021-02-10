require 'csv'




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
end


table = CSV.parse(File.read("rooms.csv"), headers: true)
#puts table[0]["Building"]
numOfLines = table.size

#TO DO: add a for loop for to create a Room obj for each row in rooms.csv
Room1 = Room.new(table[0]["Building"], table[0]["Room"], table[0]["Capacity"], table[0]["Computers Available"], table[0]["Seating Available"], table[0]["Seating Type"], table[0]["Food Allowed"], table[0]["Priority"], table[0]["Room Type"])

puts Room1.building
puts Room1.roomNum
puts Room1.capacity