//
//  PlaceListViewController.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 22.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit
import Kingfisher
import Toast_Swift
import AMScrollingNavbar
import CZPicker

class PlaceListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories = [Category]()
    
    var selectedRows = [Int]()
    
    static let id = "PlaceListViewController"
    
    var viewModel : PlaceTableViewModel!
        {
        didSet {
            viewModel.updatePlace {
                LoadingIndicatorView.hide()
                if self.viewModel.error != nil{
                    self.view.makeToast(self.viewModel.error!, duration: 5.0, position: .center)
                } else {
                    self.categories = self.viewModel.categoriesArray
                    let count = self.categories.count - 1
                    for index in 0...count{
                        self.selectedRows.append(index)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib(nibName: "PlaceTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PlaceTableViewXibCell.id)
        tableView.dataSource = self
        tableView.delegate = self
        let placeManager = PlaceManager()
        let placeTableViewModel = PlaceTableViewModel(placeManager: placeManager)
        LoadingIndicatorView.show("Loading")
        self.viewModel = placeTableViewModel
    }
    
    @IBAction func filterAction(_ sender: UIBarButtonItem) {
        let picker = CZPickerView(headerTitle: NSLocalizedString("SELECT_CATEGORIES", comment: "Select categories"), cancelButtonTitle: NSLocalizedString("CANCEL", comment: "Cancel"), confirmButtonTitle: NSLocalizedString("CONFIRM", comment: "Confirm") )
        picker?.setSelectedRows(selectedRows)
        picker?.delegate = self
        picker?.dataSource = self
        picker?.needFooterView = false
        picker?.allowMultipleSelection = true
        picker?.show()
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfPlaces()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewXibCell.id, for: indexPath) as? PlaceTableViewXibCell else {
            fatalError("PlaceTableViewXibCell doesn't exist")
        }
        cell.selectionStyle = .none
        cell.viewModel = self.viewModel.cellViewModel(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let degree: Double = 90
        let rotationAngle = CGFloat(degree * M_PI/180)
        let rotationTransform = CATransform3DMakeRotation(rotationAngle, 0, 1, 0)
        cell.layer.transform = rotationTransform
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: nameMainStoryBoard, bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: PlaceDetailsViewController.id) as? PlaceDetailsViewController
        vc?.viewModel = viewModel.getDetailsNewModel(indexPath.row)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        let prefs = UserDefaults.standard
        prefs.removeObject(forKey:userToken)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension PlaceListViewController: CZPickerViewDelegate, CZPickerViewDataSource{
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        return categories.count
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        return categories[row].name
    }
    
    func czpickerViewDidClickCancelButton(_ pickerView: CZPickerView!) {
        pickerView.isHidden = true
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!) {
        
        var ids = [Int]()
        selectedRows = [Int]()
        for row in rows {
            if let row = row as? Int {
                selectedRows.append(row)
                ids.append(categories[row].id!)
            }
        }
        viewModel.updateFilter(ids: ids){
            self.tableView.reloadData()
        }
        
    }
    
}
