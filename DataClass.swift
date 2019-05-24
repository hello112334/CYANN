//
//  DataClass.swift
//  CHANN
//
//  Created by 陳豐文 on 2019/05/19.
//  Copyright © 2019 BooLuON. All rights reserved.
//

import Foundation
import RealmSwift

//var realm = try! Realm()
var itemKey: String?
var mainBook = MainBook()
var books = Books()

var getMainBook: Results<MainBook>?
//var getBooks: Results<Books>?
var getBooks = List<Books>()

//var getMainKey: String = ""

// Main Book
class MainBook: Object {
    
    @objc dynamic var mainId: String = ""
    @objc dynamic var bookName: String?
    @objc dynamic var bookLangu: String?
    
    let books = List<Books>()
    
    override static func primaryKey() -> String? {
        return "mainId"
    }
}

// Main Book 
class Books: Object {
    
    @objc dynamic var bookId: String = ""
    @objc dynamic var vocabs: String?
    @objc dynamic var bookNote: String?
    
    
    
}



// Languages List
struct LanguagesList{
    
    var languages: [String] = [
        
        "Chinese",  //0
        "Enlish",   //1
        "Japanese", //2
        "Spanishs", //3
        
    ]
    
}
