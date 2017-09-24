//
//  PlaceTableViewController.swift
//  TestApiClientSwift_iOs
//
//  Created by KODE_H6 on 24.09.17.
//  Copyright © 2017 KODE. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire


class PlaceTableViewController: UITableViewController {

    let cellIdentifier = "PlaceTableViewController"
    var places = [Place]()
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func loadDataFromNetwork(){

        let header : HTTPHeaders = ["Authorization" : "Token 88428fb28837e841dc949c13a0550c3e2c4645ad"]
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request("http://138.68.68.166:9999/api/1/content",headers: header).validate().responseObject{
            (response: DataResponse<ApiBaseResult>) in
            switch response.result{
            case .success(let value):
                print(value)
                let resultObject = response.result.value
                let resultPlaces = resultObject?.places
                let resultCategories = resultObject?.categories

                self.places = resultPlaces!
                self.categories = resultCategories!
            case .failure(let error):
                print(error)
            }
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
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlaceTableViewCell else{
            fatalError("The dequeued call is not an instance of PlaceTableViewCell")
        }

        let place = places[indexPath.row]
        let category = categories[(place.category_id?[0])!]

        let urlTypeImage = category.icon
        


        // Configure the cell...

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
