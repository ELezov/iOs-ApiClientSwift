//
//  PlaceListViewController.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 22.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import CZPicker

class PlaceListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var imageError: UIImageView!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var textErrorLabel: UILabel!
    
    var selectedRows = [Int]()
    
    static let id = "PlaceListViewController"
    
    var viewModel : PlaceTableViewModel!
        {
        didSet {
           updateData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        let placeManager = PlaceManager()
        let placeTableViewModel = PlaceTableViewModel(placeManager: placeManager)
        self.viewModel = placeTableViewModel
    }
    
    func initTableView(){
        tableView.backgroundColor = UIColor.clear
        tableView.contentInset = UIEdgeInsets(top: 64.0, left: 0.0, bottom: 0.0, right: 0.0)
        let nib = UINib(nibName: "PlaceTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PlaceTableViewXibCell.id)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func initViews(){
        initTableView()
        self.imageError.image = UIImage(named: "ic_sad_cloud")
        let text = "Whoops!\n No Internet connetion found. Check your connection or try again."
        let errorAttrText = NSMutableAttributedString(string: text)
        errorAttrText.addAttribute(NSFontAttributeName, value: UIFont(name: "OpenSans-Semibold", size: 23.0)!, range: NSRange(location: 0, length: 7))
        self.textErrorLabel.attributedText = errorAttrText
        self.textErrorLabel.textAlignment = .center
        self.textErrorLabel.numberOfLines = 0;
        self.textErrorLabel.lineBreakMode = .byWordWrapping
        hideError()
    }
    
    @IBAction func filterAction(_ sender: UIBarButtonItem) {
        let picker = CZPickerView(headerTitle: NSLocalizedString("SELECT_CATEGORIES", comment: "Select categories"), cancelButtonTitle: NSLocalizedString("CANCEL", comment: "Cancel"), confirmButtonTitle: NSLocalizedString("CONFIRM", comment: "Confirm") )
        let categories = self.viewModel.categoriesArray
        let count = (categories?.count)! - 1
        for index in 0...count{
            self.selectedRows.append(index)
        }
        picker?.setSelectedRows(selectedRows)
        picker?.delegate = self
        picker?.dataSource = self
        picker?.needFooterView = false
        picker?.headerBackgroundColor = UIColor.lightGray
        picker?.cancelButtonBackgroundColor = UIColor.lightGray
        picker?.confirmButtonBackgroundColor = UIColor.gray
        picker?.allowMultipleSelection = true
        picker?.show()
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        let prefs = UserDefaults.standard
        prefs.removeObject(forKey:userToken)
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateData(){
        LoadingIndicatorView.show("Loading")
        viewModel.updatePlace { [weak self] () in
            LoadingIndicatorView.hide()
            if self?.viewModel.error != nil{
                self?.showError()
            } else {
                self?.hideError()
                self?.tableView.reloadData()
            }
        }
    }
    
    func showError(){
        self.imageError.isHidden = false
        self.textErrorLabel.isHidden = false
        self.tryAgainButton.isHidden = false
        self.filterButton.isEnabled = false
    }
    
    func hideError(){
        self.imageError.isHidden = true
        self.textErrorLabel.isHidden = true
        self.filterButton.isEnabled = true
        self.tryAgainButton.isHidden = true
    }
    
    @IBAction func tryAgainAction(_ sender: UIButton) {
        updateData()
    }
    
    
}

