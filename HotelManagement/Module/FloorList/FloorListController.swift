//
//  ViewController.swift
//  HotelManagement
//
//  Created by Vinayaga Moorthy on 01/03/21.
//

import UIKit



class FloorListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let identifierFloor = "AddFloorViewController"
    private let identifierRoom = "AddRoomViewController"
    private let identifierRoomlist = "RoomListViewController"
    private let identiferCell = "FloorListCell"
    private let cStoryboard = "Main"
    
    var viewModel: FloorListViewModel!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = FloorListViewModel()
        viewModel.floorsLoaded = {
            self.tableView.reloadData()
        }

        viewModel.loadFloors()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func goToAddFloor() {
        let storyBoard : UIStoryboard = UIStoryboard(name: cStoryboard, bundle:nil)
        let floorViewController = storyBoard.instantiateViewController(withIdentifier: identifierFloor) as! AddFloorViewController
        floorViewController.delegate = self
        self.present(floorViewController, animated: true, completion: nil)
    }
    
    @IBAction func goToAddRoom() {
        let storyBoard : UIStoryboard = UIStoryboard(name: cStoryboard, bundle:nil)
        let roomViewController = storyBoard.instantiateViewController(withIdentifier: identifierRoom) as! AddRoomViewController
        roomViewController.delegate = self
        self.present(roomViewController, animated: true, completion: nil)
    }

}

// Implementing UITableViewDataSource, UITableViewDelegate delegate methods
extension FloorListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identiferCell, for: indexPath as IndexPath) as! FloorListCell
        let cellModel = self.viewModel.geFloorModel(index: indexPath.row)
        cell.loadData(model: cellModel)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: cStoryboard, bundle:nil)
        let roomListViewController = storyBoard.instantiateViewController(withIdentifier: identifierRoomlist) as! RoomListViewController
        roomListViewController.delegate = self
        roomListViewController.viewModel = RoomListViewModel(rooms: viewModel.getFloorRooms(index: indexPath.row))
        self.navigationController?.pushViewController(roomListViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 202
    }
}

extension FloorListViewController: AddFloorViewDelegate, RoomListViewDelegate, AddRoomViewDelegate {
    func refreshFloorList() {
        viewModel.loadFloors()
    }
}



