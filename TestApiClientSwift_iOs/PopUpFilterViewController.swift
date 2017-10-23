//
//  PopUpFilterViewController.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 23.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

protocol DataFromFilterDelegate {
    func getDataFromPopUpFilter(rows: [Int])
}

class PopUpFilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    static let id = "PopUpFilterViewController"
   
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: FilterViewModel!
   
    var selectedRows = [Int]()
    var delegate: DataFromFilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    func initViews(){
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        initTable()
    }
    
    func initTable(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableViewAutomaticDimension
        let nib = UINib(nibName: "FilterTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: FilterTableViewCell.id)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.viewModel.numberOfPlaces())
        return self.viewModel.numberOfPlaces()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.id, for: indexPath) as? FilterTableViewCell else {
            fatalError("FilterTableViewCell doesn't exist")
        }
        if selectedRows.contains(indexPath.row){
            cell.accessoryType = .checkmark
        }
        cell.selectionStyle = .none
        cell.viewModel = self.viewModel.cellViewModel(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == .checkmark{
                let row = selectedRows.index(of: indexPath.row)
                selectedRows.remove(at: row!)
                cell.accessoryType = .none
            }
            else{
                cell.accessoryType = .checkmark
                self.selectedRows.append(indexPath.row)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == .checkmark{
                let row = selectedRows.index(of: indexPath.row)
                selectedRows.remove(at: row!)
                cell.accessoryType = .none
            }
            else{
                cell.accessoryType = .checkmark
                self.selectedRows.append(indexPath.row)
            }

        }
    }

    
    @IBAction func confirmAction(_ sender: UIButton) {
        delegate?.getDataFromPopUpFilter(rows: selectedRows)
        self.view.removeFromSuperview()
    }
}
