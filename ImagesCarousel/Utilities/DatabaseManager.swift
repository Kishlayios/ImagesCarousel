//
//  DatabaseManager.swift
//  ImagesCarousel
//
//  Created by Kishlay Kishore on 04/03/24.
//

import UIKit
import CoreData

class DatabaseManager: NSObject {
    
    // MARK: - Variables
    var arrBaseData = [AuthorBooks]()
    var persistentContainer: NSPersistentContainer!
    static let sharedInstance: DatabaseManager = {
        let instance = DatabaseManager()
        return instance
    }()
    
    // MARK: - Class Life Cycle
    override init() {
        super.init()
        persistentContainer = {
            let container = NSPersistentContainer(name: "ImagesCarousel")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    debugPrint(error.localizedDescription)
                }
            })
            return container
        }()
    }
    
//    // MARK: Function to Add data To Core data Database
   
    func addAuthorDataToLocalStorage(data: HomeDataListModel) {
        let context = persistentContainer.viewContext
        let tableObj = AuthorBooks(context: context)
        tableObj.id = data.id
        tableObj.author = data.author
        tableObj.height = Int64(data.height ?? 0)
        tableObj.width = Int64(data.width ?? 0)
        tableObj.downloadURL = data.downloadURL
        tableObj.url = data.url
        saveContext()
    }
    
    func loadAuthorLocalData() -> [AuthorBooks] {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<AuthorBooks> = AuthorBooks.fetchRequest()
        do {
            arrBaseData = try context.fetch(request)
        } catch {
            print("Error Loading Items \(error)")
        }
        return arrBaseData
    }
    
    func deleteEntityData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "AuthorBooks")
        let deleteReq = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let context = persistentContainer.viewContext
        
        do {
            try context.execute(deleteReq)
        } catch let error as NSError {
            // TODO: handle the error
            print(error.localizedDescription)
        }
        saveContext()
    }
    
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                let nserror = error as NSError
                debugPrint(nserror.localizedDescription)
            }
        }
    }
    
}

