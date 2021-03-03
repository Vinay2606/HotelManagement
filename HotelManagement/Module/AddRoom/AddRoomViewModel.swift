//
//  AddRoomViewModel.swift
//  HotelManagement
//
//  Created by Vinayaga Moorthy on 02/03/21.
//

import Foundation

class AddRoomViewModel: NSObject {
   
    var floors: [CDFloor]?
    
    func addRoomToDatabase(roomName: String, floorName: String, type: String) {
        let filtered: [CDFloor] = self.floors!.filter { $0.name == floorName }
        let dataProvider: DataProvider = DataProvider()
        dataProvider.insertRoomData(roomName: roomName, type: type, floor: filtered[0])
    }
    
    func loadFloors() {
        let dataProvider: DataProvider = DataProvider()
        self.floors = dataProvider.getFloors()
    }
    
    func getRoomTypeCount() -> Int {
        return RoomType.allValues.count
    }
    
    func getFloorsCount() -> Int {
        return floors?.count ?? 0
    }
    
    func getRoomType(index: Int) -> PicketCellViewModel {
        return PicketCellViewModel(name: RoomType.getValue(index: index))
    }
    
    func geFloorModel(index: Int) -> PicketCellViewModel {
        let floor = self.floors![index]
        return PicketCellViewModel(name: floor.name)
    }
    
}
