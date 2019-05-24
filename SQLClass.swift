//
//  SQLClass.swift
//  CHANN
//
//  Created by 陳豐文 on 2019/05/19.
//  Copyright © 2019 BooLuON. All rights reserved.
//

import Foundation
import RealmSwift

// INSERT
func MAIN_INSERT() {
    print("--- MAIN_INSERT ---")
    
    gernerateKey()
    
    let realm = try! Realm()
    
    try! realm.write {
        realm.add(mainBook)
    }
    
}

func BOOK_INSERT() {
    
    
    
}


// RETRIEVE
func MAIN_RETRIEVE(){
    print("----- RETRIEVE -----")
    
    let realm = try! Realm()
    getMainBook = realm.objects(MainBook.self)
    
}




// DELETE_ALL
func DELETE_ALL() {
    
    let realm = try! Realm()
    try! realm.write {
        realm.deleteAll()
    }
    
}



// MIGRATION TABLE
func migrationTable() {
    print("----- MigrationTable -----")
    //Deleting Realm Files
//    DeletingRealmFiles()
    
    // Inside your application(application:didFinishLaunchingWithOptions:)
    
    let config = Realm.Configuration(
        
        // Set the new schema version. This must be greater than the previously used
        // version (if you've never set a schema version before, the version is 0).
        schemaVersion: 1,
        
        // Set the block which will be called automatically when opening a Realm with
        // a schema version lower than the one set above
        migrationBlock: { migration, oldSchemaVersion in
            // We haven’t migrated anything yet, so oldSchemaVersion == 0
            if (oldSchemaVersion < 1) {
                // Nothing to do!
                // Realm will automatically detect new properties and removed properties
                // And will update the schema on disk automatically
            }
    })
    
    // Tell Realm to use this new configuration object for the default Realm
    Realm.Configuration.defaultConfiguration = config
    
    // Now that we've told Realm how to handle the schema change, opening the file
    // will automatically perform the migration
    let realm = try! Realm()
    
}


func DeletingRealmFiles(){
    
    // Deleting Realm files
    let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
    let realmURLs = [
        realmURL,
        realmURL.appendingPathExtension("lock"),
        realmURL.appendingPathExtension("note"),
        realmURL.appendingPathExtension("management")
    ]
    for URL in realmURLs {
        do {
            try FileManager.default.removeItem(at: URL)
        } catch {
            // handle error
        }
    }
    
}
