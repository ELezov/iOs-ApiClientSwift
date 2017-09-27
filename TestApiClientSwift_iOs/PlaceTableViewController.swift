import UIKit
import AlamofireObjectMapper
import Alamofire
import Kingfisher
import RealmSwift
import Toast_Swift


class PlaceTableViewController: UITableViewController {

    weak var viewModel : PlaceTableViewModel! {
        didSet {
            viewModel.updatePlace {
                if self.viewModel.error != nil{
                    self.view.makeToast(self.viewModel.error!, duration: 5.0, position: .center)
                } else{
                    self.tableView.reloadData()
                }

            }

        }
    }

    let cellIdentifier = "PlaceTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
            //placeTableController.viewModel = placeTableViewModel
        //let navController = UINavigationController(rootViewController: self)
        //self.present(navController, animated: true, completion: nil)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //loadSampleData()
        //print(Realm.Configuration.defaultConfiguration.description)
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return self.viewModel.numberOfPlaces()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlaceTableViewCell else{
            fatalError("The dequeued call is not an instance of PlaceTableViewCell")
        }
        print("CellModel", self.viewModel)
        cell.viewModel = self.viewModel.cellViewModel(indexPath.row)
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
