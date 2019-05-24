//
//  SetTableView.swift
//  CHANN
//
//  Created by 陳豐文 on 2019/05/19.
//  Copyright © 2019 BooLuON. All rights reserved.
//

import UIKit

class SetTableView: UITableViewController {

    let setCell = "setCell"
    
    let setTableItem: [String] = [
        "重置（刪除所有資料）", "", "", "", "版本"
    ]
    
    let settableAlert = UIAlertController(title: "刪除所有資料", message: "確定要刪除嗎？", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initFunc()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return setTableItem.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: setCell, for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = setTableItem[indexPath.section]
        cell.textLabel?.textAlignment = .center

        return cell
    }
    
    //Select Data
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            resetData()
        case 4:
            versionData()
        default:
            print("")
//            print("Default")
        }
        
    }
 
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        tableView.tableHeaderView?.frame.size.height = 2
//
//        let closeButton = UILabel()
//        closeButton.text = ""
//        closeButton.backgroundColor = UIColor.brown
//
//        return closeButton
//    }
    
    
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func initFunc() {
        
//        print("------ INIT ------")
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: setCell)
        
        // Set Title
        navigationItem.title = "MY SETTING"
        
        // Hidden Edundant Cell
        tableView.tableFooterView = UIView()
    }
    
    
    
    func resetData() {
//        print("-- ResetData")
        resetDataFunc()
        present(settableAlert, animated: true, completion: nil)
    }
    
    func versionData() {
//        print("-- VersionData")
    }
    
    // Add new Book Function
    func resetDataFunc(){
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
//            print("--- Ok Action START ---")
            
            DELETE_ALL()
            
            MAIN_RETRIEVE()
            
            // Done to reintantiate the storyboards instantly
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateInitialViewController()
            
//            print("--- Ok Action END ---")
        }
        
        settableAlert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        settableAlert.addAction(cancelAction)
        
        //        present(alertController, animated: true, completion: nil)
        
    }

}
