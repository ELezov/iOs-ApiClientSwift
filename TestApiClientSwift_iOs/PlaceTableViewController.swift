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
import Kingfisher
import RealmSwift
import Toast_Swift


class PlaceTableViewController: UITableViewController {

    let cellIdentifier = "PlaceTableViewCell"
    var places = [Place]()
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //loadSampleData()
        print(Realm.Configuration.defaultConfiguration.description)
       

        getData()
    }

    func loadSampleData(){
        let place1 = Place(name: "King's Castle", description: "There is cool")
        let place2 = Place(name: "Soviet's House", description: "This is shit")
        places += [place1,place2]

    }

    func getData(){
        let real = try! Realm()
        let placesRealm = real.objects(PlaceRealm.self)
        let categoriesListReal = real.objects(CategoryListRealm.self)
        print("Size Realm Place One",String(describing: placesRealm.count))
        if placesRealm.count == 0 {
            print("Data From Network")
            loadDataFromNetwork()
        } else{
            print("Data From Realm")
            for item in placesRealm{
                let place = Place()
                place.name = item.name
                place.id = item.id
                place.description = item.description_1
                var photos = [String]()
                for photo in item.photos{
                    var photoUrl = ""
                    photoUrl = photo.value
                    photos.append(photoUrl)
                }
                place.photos = photos

                var categoryList = [Int]()
                for category in item.categories{
                    categoryList.append(category.id)
                }
                place.category_id = categoryList
                self.places.append(place)
            }

            for item in categoriesListReal{
                var category = Category()
                category.name = item.name
                category.id = item.id
                category.icon = item.icon
                category.picture = item.picture
                self.categories.append(category)
            }
            self.tableView.reloadData()
        }

    }

    func loadDataFromNetwork(){

        let header : HTTPHeaders = ["Authorization" : "Token 88428fb28837e841dc949c13a0550c3e2c4645ad"]
        // Do any additional setup after loading the view, typically from a nib.


        Alamofire.request("http://138.68.68.166:9999/api/1/content",headers: header).validate().responseObject{
            (response: DataResponse<ApiBaseResult>) in
            switch response.result{
            case .success(let value):
                let resultObject = response.result.value
                let resultPlaces = resultObject?.places
                let resultCategories = resultObject?.categories
                self.places = resultPlaces!
                self.categories = resultCategories!
                print("Size places", self.places.count)
                self.saveDataByRealm()
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                self.view.makeToast(error.localizedDescription, duration: 10.0, position: .center)
            }
        }
    }

    func saveDataByRealm(){
        let realm = try! Realm()
        saveCategoryByRealm(realm: realm)
        savePlaceByRealm(realm: realm)
    }

    func saveCategoryByRealm(realm: Realm){
        for category in self.categories{
            try! realm.write{
                let categoryListRealm = CategoryListRealm()
                categoryListRealm.id = category.id!
                categoryListRealm.name = category.name!
                categoryListRealm.icon = category.icon!
                categoryListRealm.picture = category.picture!
                realm.add(categoryListRealm)
            }
        }
    }

    func savePlaceByRealm(realm: Realm)  {
        for place in self.places{
            try! realm.write {
                let placeRealm = PlaceRealm()
                placeRealm.id = place.id!
                placeRealm.name = place.name!
                placeRealm.description_1 = place.description!
                let categoryListRealm = List<CategoryRealm>()
                for item in place.category_id!{
                    if let i = self.categories.index( where: {$0.id == item}){
                        let category = self.categories[i]
                        let categoryReal = CategoryRealm()
                        categoryReal.name = category.name!
                        categoryReal.id = category.id!
                        categoryReal.icon = category.icon!
                        categoryReal.picture = category.picture!
                        categoryListRealm.append(categoryReal)
                    }
                }
                let photosRealm = List<StringObject>()
                for photo in place.photos!{
                    let stringObject = StringObject()
                    stringObject.value = photo
                    photosRealm.append(stringObject)
                }
                placeRealm.photos = photosRealm
                placeRealm.categories = categoryListRealm
                realm.add(placeRealm)
            }
        }

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

            let selectedPlace = places[indexPath.row]
            placeDetailViewController.place = selectedPlace
            placeDetailViewController.category = categories[(selectedPlace.category_id?[0])!]

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
        return places.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PlaceTableViewCell else{
            fatalError("The dequeued call is not an instance of PlaceTableViewCell")
        }

        let place = places[indexPath.row]
        let category = categories[(place.category_id?[0])!]
        let url = BASE_URL_API + category.icon!
        let urlTypeImage = URL(string: url)
        

        cell.categoryImageView.kf.setImage(with: urlTypeImage)
        cell.categoryNameLabel.text = category.name
        cell.placeNameLabel.text = place.name
        cell.placeDescriptionLabel.text = place.description
        


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
