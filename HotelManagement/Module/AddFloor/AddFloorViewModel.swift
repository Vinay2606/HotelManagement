//
//  AddFloorViewModel.swift
//  HotelManagement
//
//  Created by Vinayaga Moorthy on 02/03/21.
//

import Foundation

class AddFloorViewModel: NSObject {
    func addFloorToDatabase(name: String) {
            let dataProvider: DataProvider = DataProvider()
            if dataProvider.getFloors(name: name).count > 0 {
            } else {
                dataProvider.insertFloorData(name: name)
            }
    }
}
