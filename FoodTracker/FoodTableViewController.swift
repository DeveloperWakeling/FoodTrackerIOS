//
//  FoodTableViewController.swift
//  FoodTracker
//
//  Created by Michael Wakeling on 4/22/18.
//  Copyright © 2018 Michael Wakeling. All rights reserved.
//

import UIKit
import os.log


class FoodTableViewController: UITableViewController {

    //MARK: Properties
    var foods = [Food]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedFood = loadFoods() {
            foods += savedFood
        }
        else{
            loadSampleFoods()
        }
        
        loadSampleFoods()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return foods.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FoodTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FoodTableViewCell else {
            fatalError("The dequeued cell is not an instance of FoodTableCell.")
        }

        let food = foods[indexPath.row]
        // Configure the cell...
        cell.nameLabel.text = food.name
        cell.photoImageView.image = food.photo
        cell.ratingControl.rating = food.rating

        return cell
    }
 

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            foods.remove(at: indexPath.row)
            saveFoods()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? ""){
            case "AddItem":
                os_log("Adding Item", log: OSLog.default, type: .debug)
            
            case "ShowDetail":
                guard let foodDetailViewController = segue.destination as? FoodViewController else {
                    fatalError("Unexpected Destination \(segue.destination)")
                }
                guard let selectedFoodCell = sender as? FoodTableViewCell else {
                    fatalError("Unexpected Sender \(sender)")
                }
                guard let indexPath = tableView.indexPath(for: selectedFoodCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                let selectedFood = foods[indexPath.row]
                foodDetailViewController.food = selectedFood
            
            default:
                fatalError("Unexpected Segue Identifier \(segue.identifier)")
            }
    }
    

    //MARK: Actions
    @IBAction func unwindToFoodList(sender:UIStoryboardSegue) {
        if let sourceViewController = sender.source as? FoodViewController, let food = sourceViewController.food {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //Update existing food
                foods[selectedIndexPath.row] = food
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                
                //Add new food
                let newIndexPath = IndexPath(row: foods.count, section: 0)
                foods.append(food)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveFoods()
        }
    }
    
    //MARK: Private Methods
    private func loadSampleFoods () {
        print("Loaded Sample Meals")
    }
    
    private func saveFoods() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(foods, toFile: Food.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Meals Successfully saved", log: OSLog.default, type: .debug)
        } else {
            os_log("Meals failed to save", log: OSLog.default, type: .error)
        }
    }
    
    private func loadFoods() -> [Food]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Food.ArchiveURL.path) as? [Food]
    }
    
}
