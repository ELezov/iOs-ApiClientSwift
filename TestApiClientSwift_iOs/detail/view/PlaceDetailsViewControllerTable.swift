//
//  PlaceDetailsViewControllerTable.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 23.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

extension PlaceDetailsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (viewModel?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel?.items[indexPath.section]
        let itemId = viewModel?.itemsId[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: itemId!) as! BaseTableViewCell
        cell.setData(item: item!)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel?.items[indexPath.section]
        let type = item?.type
        switch (type!) {
        case .placePhoto:
            showMailGallery()
        case .phoneView:
            makeCallPhone()
        case .map:
            openYandexMapView()
        default:
            break
        }
    }
    
}
