//
//  PlaceListViewControllerTable.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 23.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import Foundation

extension PlaceListViewController : UITableViewDataSource, UITableViewDelegate {
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
}
