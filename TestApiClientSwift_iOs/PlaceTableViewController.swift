import UIKit
import Kingfisher
import Toast_Swift
import AMScrollingNavbar
import CZPicker

class PlaceTableViewController: UITableViewController {

    
    var categories = [Category]()
    var viewModel : PlaceTableViewModel!
   {
       didSet {
           viewModel.updatePlace {
               if self.viewModel.error != nil{
                  self.view.makeToast(self.viewModel.error!, duration: 5.0, position: .center)
              } else {
                    self.categories = self.viewModel.categoriesArray
                    self.tableView.reloadData()
                }
            }

        }
    }

    let cellIdentifier = "PlaceTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "PlaceTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PlaceTableViewCellXib")
        let placeManager = PlaceManager()
        let placeTableViewModel = PlaceTableViewModel(placeManager: placeManager)
        
        self.viewModel = placeTableViewModel
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if let navigationController = navigationController as? ScrollingNavigationController{
//            navigationController.followScrollView(tableView, delay: 25.0)
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier ?? "") {
        case "ShowDetail":
//            guard let placeDetailViewController = segue.destination as? PlaceViewController  else {
//                fatalError("Unexpected destination:\(segue.destination)")
//            }
//
//            guard let selectedPlaceCell = sender as? PlaceTableViewCell else{
//               fatalError("The selected cell is not being displayed by the table")
//            }
//
//            guard let indexPath = tableView.indexPath(for: selectedPlaceCell) else {
//                fatalError("The selected cell is not being displayed by the table")
//            }
//
//            placeDetailViewController.viewModel = self.viewModel.getDetailsViewModel(indexPath.row)
            
            guard let placeDetailViewController = segue.destination as? PlaceDetailsViewController  else {
                fatalError("Unexpected destination:\(segue.destination)")
            }
            
            guard let selectedPlaceCell = sender as? PlaceTableViewCell else{
                fatalError("The selected cell is not being displayed by the table")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedPlaceCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            placeDetailViewController.viewModel =  self.viewModel.getDetailsNewModel(indexPath.row)

        default:
            fatalError("Global prepare Error in PlaceTableViewController")
        }
    }
    
    
    @IBAction func filterNavBarAction(_ sender: UIBarButtonItem) {
        let picker = CZPickerView(headerTitle: "Выберите категории", cancelButtonTitle: "Отменить", confirmButtonTitle: "Подтвердить" )
        picker?.delegate = self
        picker?.dataSource = self
        picker?.needFooterView = false
        picker?.allowMultipleSelection = true
        picker?.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfPlaces()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlaceTableViewCell else{
            fatalError("The dequeued call is not an instance of PlaceTableViewCell")
        }
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceTableViewCellXib", for: indexPath) as? PlaceTableViewXibCell else{
//            fatalError("PlaceTableViewCellXib doesn't exist")
//        }
        
        cell.viewModel = self.viewModel.cellViewModel(indexPath.row)
        
        return cell
    }
}

extension PlaceTableViewController: CZPickerViewDelegate, CZPickerViewDataSource{
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        return categories.count
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        return categories[row].name
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemAtRow row: Int) {
        print(categories[row].name)
        //self.navigationController?.setNavigationBarHidden((true), animated: true)
        pickerView.isHidden = true
    }
    
    func czpickerViewDidClickCancelButton(_ pickerView: CZPickerView!) {
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
        pickerView.isHidden = true
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!) {
        for row in rows {
            if let row = row as? Int {
                print(categories[row].name)
            }
        }

    }
}
