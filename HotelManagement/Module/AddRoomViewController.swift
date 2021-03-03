//
//  AddRoomViewController.swift
//  HotelManagement
//
//  Created by Vinayaga Moorthy on 02/03/21.
//

struct PicketCellViewModel {
    var name: String?
}

import Foundation
import UIKit

class AddRoomViewController: UIViewController {
    
    @IBOutlet var textName: UITextField!
    @IBOutlet var textFloor: UITextField!
    @IBOutlet var textType: UITextField!
    
    var picker: UIPickerView?
    var pickerAccessory: UIToolbar?
    
    var viewModel: AddRoomViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AddRoomViewModel()
        viewModel.loadFloors()
        
        configurePicker()
    }
    
    @IBAction func goBack() {
        self.dismiss(animated: true, completion: {
        })
    }
    
    @IBAction func addRoom() {
        guard let name = textName.text, name.count > 0 else {
            self.view.makeToast("Room Name should not be empty")
           return
        }
        guard let floor = textFloor.text, floor.count > 0 else {
           self.view.makeToast("Please select floor")
           return
        }
        guard let type = textType.text, type.count > 0 else {
            self.view.makeToast("Please select room type")
           return
        }
        
        viewModel.addRoomToDatabase(roomName: name, floorName: floor, type: type)
        textName.text = ""
        textFloor.text = ""
        textType.text = ""
        self.view.makeToast("Added Room Successfully")
    }
    
    func configurePicker() {
        picker = UIPickerView()
        picker?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        picker?.backgroundColor = UIColor.white
        picker?.delegate = self
        picker?.dataSource = self
        
        textFloor.inputView = picker
        textType.inputView = picker
        
        pickerAccessory = UIToolbar()
        pickerAccessory?.autoresizingMask = .flexibleHeight

        //this customization is optional
        pickerAccessory?.barStyle = .default
        pickerAccessory?.barTintColor = UIColor.systemBlue
        pickerAccessory?.backgroundColor = UIColor.systemBlue
        pickerAccessory?.isTranslucent = false
        var frame = pickerAccessory?.frame
        frame?.size.height = 44.0
        pickerAccessory?.frame = frame!
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(AddRoomViewController.cancelBtnClicked(_:)))
        cancelButton.tintColor = UIColor.white
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //a flexible space between the two buttons
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(AddRoomViewController.doneBtnClicked(_:)))
        doneButton.tintColor = UIColor.white

        //Add the items to the toolbar
        pickerAccessory?.items = [cancelButton, flexSpace, doneButton]
        textFloor.inputAccessoryView = pickerAccessory
        textType.inputAccessoryView = pickerAccessory
    }

    @objc func cancelBtnClicked(_ button: UIBarButtonItem?) {
        if textFloor.isFirstResponder {
            textFloor?.resignFirstResponder()
        } else if textType.isFirstResponder {
            textType?.resignFirstResponder()
        }
        
    }

    @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
        if textFloor.isFirstResponder {
            textFloor?.resignFirstResponder()
            let component = 0
            let row = picker!.selectedRow(inComponent: component)
            textFloor.text = viewModel.geFloorModel(index: row).name
        } else if textType.isFirstResponder {
            textType?.resignFirstResponder()
            let component = 0
            let row = picker!.selectedRow(inComponent: component)
            textType.text = viewModel.getRoomType(index: row).name
        }
    }
    
}

extension AddRoomViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if textFloor.isFirstResponder {
            return viewModel.getFloorsCount()
        } else {
            return viewModel.getRoomTypeCount()
        }
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if textFloor.isFirstResponder {
            return viewModel.geFloorModel(index: row).name
        } else {
            return viewModel.getRoomType(index: row).name
        }
    }
}


