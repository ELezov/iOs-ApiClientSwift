import UIKit
import AlamofireObjectMapper
import Alamofire
import Kingfisher
import RealmSwift
import Toast_Swift


class PlaceTableViewController: UITableViewController {


    var viewModel : PlaceTableViewModel!
   {
       didSet {
           viewModel.updatePlace {
               if self.viewModel.error != nil{
                  self.view.makeToast(self.viewModel.error!, duration: 5.0, position: .center)
              } else {
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
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier ?? "") {
        case "ShowDetail":
            guard let placeDetailViewController = segue.destination as? PlaceViewController  else {
                fatalError("Unexpected destination:\(segue.destination)")
            }

            guard let selectedPlaceCell = sender as? PlaceTableViewCell else{
               fatalError("The selected cell is not being displayed by the table")
            }

            guard let indexPath = tableView.indexPath(for: selectedPlaceCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }

            placeDetailViewController.viewModel = self.viewModel.getDetailsViewModel(indexPath.row)

        default:
            fatalError("Global prepare Error in PlaceTableViewController")
        }
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
