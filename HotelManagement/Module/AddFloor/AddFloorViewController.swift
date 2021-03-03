//
//  AddFloorViewController.swift
//  HotelManagement
//
//  Created by Vinayaga Moorthy on 02/03/21.
//

import Foundation
import UIKit
import Toast_Swift

protocol AddFloorViewDelegate: NSObject {
    func refreshFloorList()
}

class AddFloorViewController: UIViewController {
    
    @IBOutlet var textName: UITextField!
    
    weak var delegate: AddFloorViewDelegate?
    
    var viewModel: AddFloorViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddFloorViewModel()
    }
 
    @IBAction func addFloor() {
        if let name = textName.text, name.count > 0 {
            viewModel.addFloorToDatabase(name: name)
            textName.text = ""
            self.view.makeToast("Added Floor Successfully")
        } else {
            self.view.makeToast("Floor Name Should not be empty")
        }
    }
    
    @IBAction func goBack() {
        self.dismiss(animated: true, completion: {
            self.delegate?.refreshFloorList()
        })
    }
    
}
