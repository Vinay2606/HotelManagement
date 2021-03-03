//
//  FloorListViewModel.swift
//  HotelManagement
//
//  Created by Vinayaga Moorthy on 02/03/21.
//

import Foundation
import UIKit

enum RoomType: String {
    case standard = "Standard"
    case deluxe = "Deluxe"
    case vip = "VIP"
    
    static let allValues = [standard, deluxe, vip]
    static func getValue(index: Int) -> String {
        return RoomType.allValues[index].rawValue
    }

    static func getWatts(value: String) -> Int {
        guard let roomType = RoomType(rawValue: value) else {
            return 0
        }

        switch roomType {
        case .standard:
            return 150
        case .deluxe:
            return 400
        case .vip:
            return 550
        }
    }
}

class FloorListViewModel: NSObject {
    
    var floorsLoaded: (() -> ())?
    var floors: [CDFloor]?
    
    override init() {
        super.init()
    }
    
    func loadFloors() {
        let dataProvider: DataProvider = DataProvider()
        self.floors = dataProvider.getFloors()
        floorsLoaded?()
    }
    
    func getCount() -> Int {
        return floors?.count ?? 0
    }
    
    func geFloorModel(index: Int) -> FloorListCellViewModel {
        let floor = self.floors![index]
        
        let rooms = self.getFloorRooms(index: index)
        var consumedWatts: Int = 0
        let filtered =  rooms.filter { $0.guestentry == "ON" }
        _ = filtered.map { (room) -> String in
            consumedWatts = consumedWatts + RoomType.getWatts(value: room.type!)
            return ""
        }
        print("Consumed Watss \(consumedWatts)")
        var statusColor: UIColor!
        if consumedWatts > 750 {
            statusColor = UIColor.red
        } else {
            statusColor = UIColor.green
        }
        
        return FloorListCellViewModel(name: floor.name, totalRooms: "\(rooms.count)", roomsOccupied: "\(filtered.count)", watts: "\(consumedWatts) Watts", status: statusColor)
    }
    
    func getFloorRooms(index: Int) -> [CDRoom] {
        let floor = self.floors![index]
        return floor.rooms ?? []
    }
    


}

