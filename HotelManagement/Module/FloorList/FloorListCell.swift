//
//  FloorListCell.swift
//  HotelManagement
//
//  Created by Vinayaga Moorthy on 02/03/21.
//

struct FloorListCellViewModel {
    var name: String?
    var totalRooms: String?
    var roomsOccupied: String?
    var watts: String?
    var status: UIColor?
}

import Foundation

import UIKit

class FloorListCell: UITableViewCell {
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblTotalRooms: UILabel!
    @IBOutlet var lblRoomsOccupied: UILabel!
    @IBOutlet var lblWatts: UILabel!
    
    @IBOutlet var viewStatus: UIView!
    
    func loadData(model: FloorListCellViewModel) {
        lblName.text = model.name
        lblTotalRooms.text = model.totalRooms
        lblRoomsOccupied.text = model.roomsOccupied
        lblWatts.text = model.watts
        viewStatus.backgroundColor = model.status
    }
        
}
