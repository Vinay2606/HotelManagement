//
//  RoomListViewController.swift
//  HotelManagement
//
//  Created by Vinayaga Moorthy on 02/03/21.
//

import Foundation

import UIKit

protocol RoomListViewDelegate: NSObject {
    func refreshFloorList()
}

class RoomListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    weak var delegate: RoomListViewDelegate?
    
    var viewModel: RoomListViewModel!
    private let identiferCell = "RoomListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func goBack() {
        self.dismiss(animated: true, completion: {
            self.delegate?.refreshFloorList()
        })
    }
    
}

// Implementing UITableViewDataSource, UITableViewDelegate delegate methods
extension RoomListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identiferCell, for: indexPath as IndexPath) as! RoomListCell
        let cellModel = self.viewModel.geRoomModel(index: indexPath.row)
        cell.loadData(model: cellModel)
        cell.switchChanged = { value in
            self.viewModel.updateGuestEntry(name: cellModel.name!, value: value)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
