//
//  RoomListCell.swift
//  HotelManagement
//
//  Created by Vinayaga Moorthy on 02/03/21.
//

struct RoomListCellViewModel {
    var name: String?
    var type: String?
    var guestentry: String?
}

import Foundation

import UIKit

class RoomListCell: UITableViewCell {
        
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblType: UILabel!
    @IBOutlet var lblWatts: UILabel!
    @IBOutlet var switchGuest: UISwitch!
    
    var switchChanged: ((String) -> ())?
    
    func loadData(model: RoomListCellViewModel) {
        lblName.text = model.name
        lblType.text = model.type
        lblWatts.text = "\(RoomType.getWatts(value: model.type!))"
        
        if model.guestentry == "ON" {
            switchGuest.isOn = true
        } else {
            switchGuest.isOn = false
        }
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {

        if switchGuest.isOn {
            self.switchChanged?("ON")
        }
        else {
            self.switchChanged?("OFF")
        }
    }
    
}
