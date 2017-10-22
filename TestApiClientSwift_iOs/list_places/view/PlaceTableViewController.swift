import UIKit
import Kingfisher
import Toast_Swift
import AMScrollingNavbar
import CZPicker

class PlaceTableViewController: UITableViewController {

    
    var categories = [Category]()
    
    var selectedRows = [Int]()
    
    static let id = "PlaceTableViewController"
    
    var viewModel : PlaceTableViewModel!
    {
       didSet {
           viewModel.updatePlace {
               if self.viewModel.error != nil{
                  self.view.makeToast(self.viewModel.error!, duration: 5.0, position: .center)
              } else {
                    self.categories = self.viewModel.categoriesArray
                    let count = self.categories.count - 1
                    for index in 0...count{
                        self.selectedRows.append(index)
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let placeManager = PlaceManager()
        let placeTableViewModel = PlaceTableViewModel(placeManager: placeManager)
        self.viewModel = placeTableViewModel
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier ?? "") {
        case PlaceDetailsViewController.idSegueShow:
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
        let picker = CZPickerView(headerTitle: NSLocalizedString("SELECT_CATEGORIES", comment: "Select categories"), cancelButtonTitle: NSLocalizedString("CANCEL", comment: "Cancel"), confirmButtonTitle: NSLocalizedString("CONFIRM", comment: "Confirm") )
        picker?.setSelectedRows(selectedRows)
        picker?.delegate = self
        picker?.dataSource = self
        picker?.needFooterView = false
        picker?.allowMultipleSelection = true
        picker?.show()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfPlaces()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.id, for: indexPath) as? PlaceTableViewCell else{
            fatalError("The dequeued call is not an instance of PlaceTableViewCell")
        }
        cell.viewModel = self.viewModel.cellViewModel(indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let degree: Double = 90
        let rotationAngle = CGFloat(degree * M_PI/180)
        let rotationTransform = CATransform3DMakeRotation(rotationAngle, 0, 1, 0)
        cell.layer.transform = rotationTransform
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        })
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        let prefs = UserDefaults.standard
        prefs.removeObject(forKey:userToken)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension PlaceTableViewController: CZPickerViewDelegate, CZPickerViewDataSource{
    func numberOfRows(in pickerView: CZPickerView!) -> Int {
        return categories.count
    }
    
    func czpickerView(_ pickerView: CZPickerView!, titleForRow row: Int) -> String! {
        return categories[row].name
    }
    
    func czpickerViewDidClickCancelButton(_ pickerView: CZPickerView!) {
        pickerView.isHidden = true
    }
    
    func czpickerView(_ pickerView: CZPickerView!, didConfirmWithItemsAtRows rows: [Any]!) {
        
        var ids = [Int]()
        selectedRows = [Int]()
        for row in rows {
            if let row = row as? Int {
                selectedRows.append(row)
                ids.append(categories[row].id!)
            }
        }
        viewModel.updateFilter(ids: ids){
            self.tableView.reloadData()
        }

    }
    
    
}
