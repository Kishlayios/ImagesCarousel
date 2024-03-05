//
//  HomeViewModel.swift
//  ImagesCarousel
//
//  Created by Kishlay Kishore on 04/03/24.
//

import Foundation

protocol HomeListVMTrigger: AnyObject {
    func reloadOnDataReceive()
}

class HomeViewModel: NSObject {
    
    // MARK: - Variables
    weak var delegate: HomeListVMTrigger?
    let syncService = HomeRepository()
    var pageCount = 1
    var arrImageList = [HomeDataListModel]()
    
    // MARK: - Helper Methods
    func callInitialApis() {
        let savedDataCheck = DatabaseManager.sharedInstance.loadAuthorLocalData()
        if savedDataCheck.isEmpty {
            self.getTheImageList()
        } else {
            self.setupTheModelWhenFetchFromLocal()
        }
        
    }
    
    
    func removeDuplicateElements(data: [HomeDataListModel]) -> [HomeDataListModel] {
        if !data.isEmpty {
            var uniqueList = [HomeDataListModel]()
            for item in data {
                if !uniqueList.contains(where: {$0.author == item.author }) {
                    uniqueList.append(item)
                }
            }
            return uniqueList
        } else {
           return []
        }
    }
    
    func setupTheModelWhenFetchFromLocal() {
        self.arrImageList.removeAll()
        let savedDataCheck = DatabaseManager.sharedInstance.loadAuthorLocalData()
        var dataModel = [HomeDataListModel]()
        for item in savedDataCheck {
            let homeModel = HomeDataListModel(id: item.id, author: item.author, width: Int(item.width), height: Int(item.height), url: item.url, downloadURL: item.downloadURL)
            dataModel.append(homeModel)
        }
        
        for var item in dataModel {
            item.addChildData(arrList: dataModel)
            self.arrImageList.append(item)
        }
        self.delegate?.reloadOnDataReceive()
    }
}

// MARK: - Get The Author List From Server
extension HomeViewModel {
    
    func getTheImageList() {
        syncService.getTheImageListFromServer(pageNo: self.pageCount) { result in
            if result?.response != nil {
                do {
                    let decodedData = try JSONDecoder().decode([HomeDataListModel].self, from: (result?.response)!)
                    let newFilteredData = self.removeDuplicateElements(data: decodedData)
                    let savedDataCheck = DatabaseManager.sharedInstance.loadAuthorLocalData()
                    if savedDataCheck.isEmpty {
                        for var item in newFilteredData {
                            item.addChildData(arrList: newFilteredData)
                            self.arrImageList.append(item)
                            DatabaseManager.sharedInstance.addAuthorDataToLocalStorage(data: item)
                        }
                    }
                    self.delegate?.reloadOnDataReceive()
                } catch let err {
                    debugPrint("Err", err)
                }
            } else {
                ServiceManager.shared.executeFailureBlock()
            }
        }
    }
}
