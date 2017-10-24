//
//  PopUpFilterViewControllerTable.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 24.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation

extension PopUpFilterViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfPlaces()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.id, for: indexPath) as? FilterTableViewCell else {
            fatalError("FilterTableViewCell doesn't exist")
        }
        if self.viewModel.selectedRows.contains(indexPath.row){
            cell.accessoryType = .checkmark
        }
        cell.selectionStyle = .none
        cell.viewModel = self.viewModel.cellViewModel(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == .checkmark{
                let row = viewModel.selectedRows.index(of: indexPath.row)
                self.viewModel.selectedRows.remove(at: row!)
                cell.accessoryType = .none
            }
            else{
                cell.accessoryType = .checkmark
                self.viewModel.selectedRows.append(indexPath.row)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            if cell.accessoryType == .checkmark{
                let row = self.viewModel.selectedRows.index(of: indexPath.row)
                self.viewModel.selectedRows.remove(at: row!)
                cell.accessoryType = .none
            }
            else{
                cell.accessoryType = .checkmark
                self.viewModel.selectedRows.append(indexPath.row)
            }
            
        }
    }
    
}
