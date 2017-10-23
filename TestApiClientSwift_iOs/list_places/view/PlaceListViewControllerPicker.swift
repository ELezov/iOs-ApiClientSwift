//
//  PlaceListViewControllerPicker.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 23.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//
import CZPicker

extension PlaceListViewController: CZPickerViewDelegate, CZPickerViewDataSource{
    
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        return viewModel.categoriesArray.count
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        return viewModel.categoriesArray[row].name
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
                ids.append(viewModel.categoriesArray[row].id!)
            }
        }
        viewModel.updateFilter(ids: ids){
            self.tableView.reloadData()
        }
        
    }
    
}
