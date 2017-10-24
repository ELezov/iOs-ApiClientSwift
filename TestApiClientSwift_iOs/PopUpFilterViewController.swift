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

class PopUpFilterViewController: UIViewController{
    
    static let id = "PopUpFilterViewController"
   
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: FilterViewModel!
    @IBOutlet weak var backgroundView: UIView!
   
    var delegate: DataFromFilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    func initViews(){
        //backgroundView.roundCorners(corners: [.topLeft], radius: 1.0)
        backgroundView.layer.cornerRadius = 10.0
        backgroundView.clipsToBounds = true
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
    
    @IBAction func confirmAction(_ sender: UIButton) {
        delegate?.getDataFromPopUpFilter(rows: self.viewModel.selectedRows)
        self.view.removeFromSuperview()
    }
    
}
