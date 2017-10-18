//
//  PlaceDetailsViewController.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit
import AMScrollingNavbar

class PlaceDetailsViewController: UIViewController{
    
    var viewModel: DetailsViewModel?
    
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var tableView: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.contentInset = UIEdgeInsets(top: 245, left: 0, bottom: 0, right: 0)
        
        placeImage.kf.setImage(with: URL(string: BASE_URL_API + (viewModel?.placeImgUrl[0])!))
        tableView?.dataSource = viewModel
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableViewAutomaticDimension
        
        tableView?.register(HeaderPlaceViewCell.nib, forCellReuseIdentifier: HeaderPlaceViewCell.identifier)
        tableView?.register(DescriptionViewCell.nib, forCellReuseIdentifier: DescriptionViewCell.identifier)
        tableView?.register(TimeTableViewCell.nib, forCellReuseIdentifier: TimeTableViewCell.identifier)
        tableView?.register(VisitingPriceCell.nib, forCellReuseIdentifier: VisitingPriceCell.identifier)
        tableView?.register(PhoneViewCell.nib, forCellReuseIdentifier: PhoneViewCell.identifier)
        tableView?.register(LocationViewCell.nib, forCellReuseIdentifier: LocationViewCell.identifier)
    }
    
    override func viewWillLayoutSubviews() {
        self.tableView?.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableView!, delay: 0.0)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView()
        }
    }
    
   
    
}
