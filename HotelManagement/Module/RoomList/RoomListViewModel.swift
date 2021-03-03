//
//  RoomListViewModel.swift
//  HotelManagement
//
//  Created by Vinayaga Moorthy on 02/03/21.
//

import Foundation

class RoomListViewModel: NSObject {
    
    var rooms: [CDRoom]!
    
    override init() {
        super.init()
    }
    
    convenience init(rooms: [CDRoom]) {
        self.init()
        self.rooms = rooms
    }
    
    func updateGuestEntry(name: String, value: String) {
        let filtered: [CDRoom] = self.rooms.filter { $0.name == name }
        let dataProvider: DataProvider = DataProvider()
        dataProvider.updateRoom(room: filtered[0], guestentry: value)
    }
    
    func getCount() -> Int {
        return rooms.count 
    }
    
    func geRoomModel(index: Int) -> RoomListCellViewModel {
        let room = self.rooms[index]
        return RoomListCellViewModel(name: room.name, type: room.type, guestentry: room.guestentry)
    }
    
}
