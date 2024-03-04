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
    //var arrBaseData = [CountryList]()
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
//    
//    func addBaseCurrencyDataToLocalStorage(country: String, rate: String) {
//        let context = persistentContainer.viewContext
//        let data = CountryList(context: context)
//        data.baseCurrency = "USD"
//        data.country = country
//        data.rate = NSDecimalNumber(string: rate)
//        saveContext()
//    }
//    
//    func loadBaseCurrencyData() -> [CountryList] {
//        let context = persistentContainer.viewContext
//        let request: NSFetchRequest<CountryList> = CountryList.fetchRequest()
//        do {
//            arrBaseData = try context.fetch(request)
//        } catch {
//            print("Error Loading Items \(error)")
//        }
//        return arrBaseData
//    }
//    
//    func deleteEntityData() {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CountryList")
//        let deleteReq = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        let context = persistentContainer.viewContext
//        
//        do {
//            try context.execute(deleteReq)
//        } catch let error as NSError {
//            // TODO: handle the error
//            print(error.localizedDescription)
//        }
//        saveContext()
//    }
    
    
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

