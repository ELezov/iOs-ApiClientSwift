//
//  PlaceDetailsViewController.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 16.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit

class PlaceDetailsViewController: UIViewController {

    var viewModel: DetailsViewModel?{
        didSet{
            tableView?.dataSource = viewModel
            tableView?.reloadData()
        }
    }
    
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var tableView: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView?.dataSource = viewModel
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableViewAutomaticDimension
        
        tableView?.register(HeaderPlaceDetailsViewCell.nib, forCellReuseIdentifier: HeaderPlaceDetailsViewCell.identifier)
        tableView?.register(DescriptionDetailsViewCell.nib, forCellReuseIdentifier: DescriptionDetailsViewCell.identifier)
        tableView?.register(TimeTableDetailsViewCell.nib, forCellReuseIdentifier: TimeTableDetailsViewCell.identifier)
        tableView?.register(VisitingPriceDetailsCell.nib, forCellReuseIdentifier: VisitingPriceDetailsCell.identifier)
        tableView?.register(PhoneDetailsViewCell.nib, forCellReuseIdentifier: PhoneDetailsViewCell.identifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
