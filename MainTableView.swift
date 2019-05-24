//
//  MainTableView.swift
//  CHANN
//
//  Created by 陳豐文 on 2019/05/19.
//  Copyright © 2019 BooLuON. All rights reserved.
//

import UIKit
import RealmSwift

class MainTableView: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let cellId = "cellId"
    
    
    // Alert Box of Creating a New Book
    let alertController = UIAlertController(title: "登入新詞本", message: "請輸入標題和語言", preferredStyle: .alert)
    
    
    // Language Picker View
    var getLanguage = LanguagesList()
    var textField_Langulage =  UITextField()
    let languPickerView = UIPickerView()
    let toolBar = UIToolbar()
    var getSelectedLan: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("-------- ViewDidLoad --------")
        
        initFunc()
        
        mainFunc()
        
        endFunc()
        
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let realm = try! Realm()
        
        getMainBook = realm.objects(MainBook.self)
        
        if getMainBook != nil {
            return getMainBook!.count
        }
        return 0
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //     cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        // Configure the cell...
        
        //     cell.textLabel?.text = name
        
        
        if getMainBook != nil {
//            print("PRINT OUT OK")
            cell.textLabel?.text = getMainBook![indexPath.row].bookName
            
        } else {
//            print("PRINT OUT NG")
//            print(getMainBook!.count)
        }
        
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
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func initFunc() {
        
//        print("------ INIT ------")
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        migrationTable()
//        DELETE_ALL()
        gernerateKey()
        
//        creatTestData()
        
        //Language
        setLanguagePickerView()
        
        // Set Title
        navigationItem.title = "MY BOOKS"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func mainFunc() {
        
//        print("------ MAIN ------")
//        migrationTable()
        
        MAIN_RETRIEVE()
        
        AddNewBook()
        
        tableView.reloadData()
    }
    
    //

    
    
    func endFunc() {
        
//        print("------ END ------")
        let realm = try! Realm()
        let results = realm.objects(MainBook.self)
//        print(results.count)
        
        
        //Show Log
//        print("-------- DATABASE PATH ---------")
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
//        print("-----------------")
        
    }
    
    
    // Add Book Button
    @IBAction func AddBook(_ sender: Any) {
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    // Add new Book Function
    func AddNewBook(){
        
        alertController.addTextField { (textField) in
            textField.placeholder = "標題"
            textField.keyboardType = UIKeyboardType.alphabet
        }
        alertController.addTextField { (textField_Langulage) in
//                        textField_Langulage.placeholder = "語言"
//                        textField.isSecureTextEntry = true
            
            textField_Langulage.inputView = self.languPickerView
            textField_Langulage.inputAccessoryView = self.toolBar
            textField_Langulage.text = self.getLanguage.languages[0]
//            textField_Langulage.tag = 100
            
            
            
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
//            print("--- Ok Action START ---")
//            let bookTitle = self.alertController.textFields?[0].text
//            let bookLangu = self.alertController.textFields?[1].text
            //            print(bookTitle, bookLangu)
            let mainBook = MainBook()
            mainBook.bookName = self.alertController.textFields?[0].text
            mainBook.bookLangu = self.alertController.textFields?[1].text
           
            
            let realm = try! Realm()
            gernerateKey()
            mainBook.mainId = String(itemKey!)
            try! realm.write {
                realm.add(mainBook)
            }
            
            
            MAIN_RETRIEVE()
            self.tableView.reloadData()
            self.alertController.textFields?[0].text = ""
//            print("--- Ok Action END ---")
        }
        
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
//        present(alertController, animated: true, completion: nil)
        
    }
    
    //MARK: Language Picker View Sets
    func setLanguagePickerView(){
        //Create PickerView
        
        languPickerView.showsSelectionIndicator = true
        languPickerView.delegate = self
        languPickerView.dataSource = self
        
        //        languageText.inputView = languPickerView
        //        languageText.text = getLanguage.languages[0]
        //        languageText.tag = 100
        
        //        textField_Langulage.inputView = languPickerView
        //        textField_Langulage.inputAccessoryView = toolBar
        //        textField_Langulage.text = getLanguage.languages[0]
        //        textField_Langulage.tag = 100
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "SELECT", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicker))
        
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.setItems([spaceButton,spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return getLanguage.languages.count
        }
        return getLanguage.languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return getLanguage.languages[row]
        }else{
            return getLanguage.languages[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//                textField_Langulage = view.viewWithTag(100) as! UITextField
//        let textField_Langulage = view.viewWithTag(100) as? UITextField
//
//        if textField_Langulage != nil {
//            textField_Langulage!.text = getLanguage.languages[row]
//        } else {
//            print("\(row)")
//            print(getLanguage.languages[row])
//        }
        
        getSelectedLan = getLanguage.languages[row]
        
    }
    
    @objc func donePicker() {
//        print("DONE donePicker")
        alertController.textFields?[1].text = getSelectedLan
    }
    
    
    //delete Items
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "DELETE") { (rowAction, indexPath) in
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.delete(getMainBook![indexPath.row])
            }
            
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            MAIN_RETRIEVE()
            self.tableView.reloadData()
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        return [deleteAction]
    }
    
    
    //Select Data
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
        
        let itemString = getMainBook![indexPath.row].mainId as String
        self.performSegue(withIdentifier: "showDetail", sender: itemString)
        
    }
    
    //Send message to next page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let controller = segue.destination as! DetailTableView
            
            controller.getMainKey = sender as! String
        }
    }
    
    
    // TEST DATA
    func creatTestData() {
        let notebook1 = MainBook()
        let notebook2 = MainBook()
        
        notebook1.mainId = String(itemKey!)
        notebook1.bookName = "HarryPotter XI"
        notebook1.bookLangu = "Enlish"
        
        sleep(1)
        gernerateKey()
        
        notebook2.mainId = String(itemKey!)
        notebook2.bookName = "水滸傳"
        notebook2.bookLangu = "Chinese"
        
        do {
            let realm = try Realm()
            
            try! realm.write {
                realm.add(notebook1)
                realm.add(notebook2)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}


