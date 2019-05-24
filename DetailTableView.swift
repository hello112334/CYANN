//
//  DetailTableView.swift
//  CHANN
//
//  Created by 陳豐文 on 2019/05/19.
//  Copyright © 2019 BooLuON. All rights reserved.
//

import UIKit
import RealmSwift

class DetailTableView: UITableViewController {

    
    
//    let cellDetailId = "detailCell"
    
    var getMainKey: String = ""
    var bookTitle: String = ""
    
    // Alert Box of Creating a New Book
    let alertController = UIAlertController(title: "加入新詞", message: "請輸入詞彙和註釋", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        print(getMainKey)
        
        initFunc()
        
        MainFunc()
        
        EndFunc()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if getBooks.count > 0 {
            return getBooks.count
        }
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> DetailTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
    
        
//        cell.textLabel?.text = getBooks[indexPath.row].vocabs
        cell.vocabLabelText.text = "\(getBooks[indexPath.row].vocabs ?? "")"
        cell.noteLabelText.text  = "\(getBooks[indexPath.row].bookNote ?? "")"
        
        return cell
    }
    

    @IBAction func addNewVocb(_ sender: Any) {
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    // Add new Book Function
    func AddNewBook(){
        
        alertController.addTextField { (textField) in
            textField.placeholder = "標題"
            textField.keyboardType = UIKeyboardType.alphabet
        }
        alertController.addTextField { (textField_Note) in
   
            textField_Note.placeholder = "註釋"
            textField_Note.keyboardType = UIKeyboardType.alphabet
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
//            print("--- Ok Action START ---")

            let book2 = Books()
            book2.vocabs = self.alertController.textFields?[0].text
            book2.bookNote = self.alertController.textFields?[1].text
            
            let realm = try! Realm()
            gernerateKey()
            book2.bookId = String(itemKey!)
            
            if let mainBook1 = getMainBook?.filter("mainId = '\(self.getMainKey)'")[0] {
                try! realm.write {
                    mainBook1.books.append(book2)
                }
                getBooks = mainBook1.books
                self.BOOK_RETRIEVE()
                self.tableView.reloadData()
            }
            
            MAIN_RETRIEVE()
            self.tableView.reloadData()
            self.alertController.textFields?[0].text = ""
            self.alertController.textFields?[1].text = ""
//            print("--- Ok Action END ---")
        }
        
        alertController.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        //        present(alertController, animated: true, completion: nil)
        
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
//        print("---- INIT ----")
        
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellDetailId)
        getBookByKey()
        gernerateKey()
        
//        print("---- CHECK POINt ----")
        
        // Set Title
        navigationItem.title = bookTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func MainFunc() {
//        print("---- MAIN ----")
        
        BOOK_RETRIEVE()
        
        AddNewBook()
        
    }
    
    func EndFunc() {
//        print("---- ENd ----")
        
        let realm = try! Realm()
        let results = realm.objects(MainBook.self)
//        print(results.count)
        
        //Show Log
//        print("-------- DATABASE PATH ---------")
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "")
//        print("-----------------")
        
    }
    
    func getBookByKey(){
//        print("--- GetBookByKey ---")
        
//        let book1 = Books()
//
//        book1.bookId = String(itemKey!)
//        book1.vocabs = "Harry"
//        book1.bookNote = "MAN"
        
//        print("--- SAVE DATA ---")
        
        let realm = try! Realm()
        
        if let mainBook1 = getMainBook?.filter("mainId = '\(getMainKey)'")[0] {
            bookTitle = mainBook1.bookName ?? ""
            
//            try! realm.write {
//                mainBook1.books.append(book1)
//            }
            
            getBooks = mainBook1.books
//            print(getBooks)
        }
        
        //        print(bookTitle)
    }
    
    
    
    //delete Items
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "DELETE") { (rowAction, indexPath) in
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.delete(getBooks[indexPath.row])
            }
            
            self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            self.BOOK_RETRIEVE()
            self.tableView.reloadData()
        }
        deleteAction.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        return [deleteAction]
    }
    
    
    // Retrieve Book
    func BOOK_RETRIEVE(){
//        print("----- RETRIEVE -----")
        
        let realm = try! Realm()
        //        getBook1 = realm.objects(Books.self)
        if let mainBook1 = getMainBook?.filter("mainId = '\(getMainKey)'")[0] {
            getBooks = mainBook1.books
        }
        
        
    }
    
    
}
