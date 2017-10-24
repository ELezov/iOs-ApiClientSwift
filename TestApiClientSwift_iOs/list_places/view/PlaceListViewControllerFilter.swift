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
        var selectedRows = [Int]()
        for row in rows {
            selectedRows.append(row)
            ids.append(viewModel.categoriesArray[row].id!)
        }
        viewModel.selectedRows = selectedRows
        locationManager.stopUpdatingLocation()
        viewModel.updateFilter(ids: ids){ [weak self] () in
            self?.locationManager.startUpdatingLocation()
            self?.filterButton.isEnabled = true
            self?.logOutButton.isEnabled = true
            self?.tableView.reloadData()
        }

    }
}
