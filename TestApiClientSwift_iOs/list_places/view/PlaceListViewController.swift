//
//  PlaceListViewController.swift
//  TestApiClientSwift_iOs
//
//  Created by Nikolay on 22.10.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit
import AMScrollingNavbar

class PlaceListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    @IBOutlet weak var imageError: UIImageView!
    @IBOutlet weak var tryAgainButton: UIButton!
    @IBOutlet weak var textErrorLabel: UILabel!
    @IBOutlet weak var amberCardImageView: UIImageView!
    
    var locationManager: CLLocationManager = CLLocationManager()
    
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
        initLocationManager()
        let placeManager = PlaceManager()
        let placeTableViewModel = PlaceTableViewModel(placeManager: placeManager)
        self.viewModel = placeTableViewModel
    }
    
    func doRefresh() {
        print("Refresh")
        LoadingIndicatorView.show()
        self.locationManager.stopUpdatingLocation()
        viewModel.pullToRefresh(){ [weak self] () in
            LoadingIndicatorView.hide()
            if self?.viewModel.error != nil{
                self?.showError()
                self?.tableView.refreshControl?.endRefreshing()
            } else {
                self?.hideError()
                self?.tableView.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
                self?.locationManager.startUpdatingLocation()
                //self?.initLocation()
            }
        }
    }
    
    func initLocationManager(){
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.delegate = self
        locationManager.distanceFilter = 50.0
        locationManager.pausesLocationUpdatesAutomatically = true
        locationManager.requestWhenInUseAuthorization()
    }
    
    func initTableView(){
        tableView.separatorColor = UIColor.amberCardSeparator
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 215
        tableView.backgroundColor = UIColor.clear
        tableView.contentInset = UIEdgeInsets(top: 284.0, left: 0.0, bottom: 0.0, right: 0.0)
        let nib = UINib(nibName: "PlaceTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: PlaceTableViewXibCell.id)
        let amberNib = UINib(nibName: AmberCardTableViewCell.id, bundle: nil)
        tableView.register(amberNib, forCellReuseIdentifier: AmberCardTableViewCell.id)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func initViews(){
        initTableView()
        filterButton.tintColor = UIColor.amberCardBlue
        self.imageError.image = UIImage(named: "ic_sad_cloud")
        self.amberCardImageView.isHidden = true
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
        if let categories = self.viewModel.categoriesArray {
            let mainStoryBoard: UIStoryboard = UIStoryboard(name: nameMainStoryBoard, bundle: nil)
            let vc = mainStoryBoard.instantiateViewController(withIdentifier: PopUpFilterViewController.id) as! PopUpFilterViewController
            vc.viewModel = viewModel.getFilterNewModel()
            vc.delegate = self
            self.addChildViewController(vc)
            vc.view.frame = self.view.frame
            self.view.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
            filterButton.isEnabled = false
            logOutButton.isEnabled = false
        }
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        let prefs = UserDefaults.standard
        prefs.removeObject(forKey:userToken)
        self.locationManager.stopUpdatingLocation()
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateData(){
        locationManager.stopUpdatingLocation()
        LoadingIndicatorView.show("Loading")
        viewModel.updatePlace { [weak self] () in
            LoadingIndicatorView.hide()
            if self?.viewModel.error != nil{
                self?.showError()
            } else {
                self?.hideError()
                self?.initRefreshControl()
                self?.tableView.reloadData()
                self?.locationManager.startUpdatingLocation()
                //self?.initLocation()
            }
        }
    }
    
    func initRefreshControl(){
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(doRefresh), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    func showError(){
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.reloadData()
        self.imageError.isHidden = false
        self.textErrorLabel.isHidden = false
        self.tryAgainButton.isHidden = false
        self.filterButton.isEnabled = false
        self.amberCardImageView.isHidden = true
    }
    
    func hideError(){
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        self.imageError.isHidden = true
        self.textErrorLabel.isHidden = true
        self.filterButton.isEnabled = true
        self.tryAgainButton.isHidden = true
        self.amberCardImageView.isHidden = false
    }
    
    @IBAction func tryAgainAction(_ sender: UIButton) {
        updateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

