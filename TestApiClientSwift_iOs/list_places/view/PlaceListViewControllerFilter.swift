//
//  PlaceListViewControllerFilter.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 23.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation

extension PlaceListViewController: DataFromFilterDelegate{
    
    func getDataFromPopUpFilter(rows: [Int]) {
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
