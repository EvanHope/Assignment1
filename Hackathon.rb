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

Room1 = Room.new("Armstrong", 12, 29, true, "desks", "Tiered", true, "Engineering", "Classroom")
#For each line - 1 in file 1 create a new room obj and 
#set all varibles before moving to next line 
puts Room1.building
puts Room1.roomNum
puts Room1.capacity