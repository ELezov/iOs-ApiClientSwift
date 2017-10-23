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
        let type = item?.type
        switch type!{
        case .placePhoto:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PhotoDetailViewCell.identifier, for: indexPath) as? PhotoDetailViewCell{
                cell.item = item
                cell.selectionStyle = .none
                return cell
            }
            
        case .header:
            if let cell = tableView.dequeueReusableCell(withIdentifier: HeaderPlaceViewCell.identifier, for: indexPath) as? HeaderPlaceViewCell{
                cell.item = item
                cell.selectionStyle = .none
                return cell
            }
        case .description:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionViewCell.identifier, for: indexPath) as? DescriptionViewCell{
                cell.item = item
                cell.selectionStyle = .none
                return cell
            }
        case .timeTable:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TimeTableViewCell.identifier, for: indexPath) as? TimeTableViewCell{
                cell.item = item
                cell.selectionStyle = .none
                return cell
            }
        case .visitingPrice:
            if let cell = tableView.dequeueReusableCell(withIdentifier: VisitingPriceCell.identifier, for: indexPath) as? VisitingPriceCell{
                cell.item = item
                cell.selectionStyle = .none
                return cell
            }
        case .phoneView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PhoneViewCell.identifier, for: indexPath) as? PhoneViewCell{
                cell.item = item
                cell.selectionStyle = .none
                return cell
            }
        case .location:
            if let cell = tableView.dequeueReusableCell(withIdentifier: LocationViewCell.identifier, for: indexPath) as? LocationViewCell{
                cell.item = item
                cell.selectionStyle = .none
                return cell
            }
        case .map:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MapViewCell.identifier, for: indexPath) as? MapViewCell{
                cell.item = item
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel?.items[indexPath.section]
        let type = item?.type
        switch (type!){
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