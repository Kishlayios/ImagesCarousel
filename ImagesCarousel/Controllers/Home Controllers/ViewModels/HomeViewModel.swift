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
    private let syncService = HomeRepository()
    var pageCount = 1
    var arrImageList = [HomeDataListModel]()
    
    // MARK: - Helper Methods
    func callInitialApis() {
        self.getTheImageList()
    }
    
    
    func removeDuplicateElements(data: [HomeDataListModel]) -> [HomeDataListModel] {
        var uniqueList = [HomeDataListModel]()
        for item in data {
            if !uniqueList.contains(where: {$0.author == item.author }) {
                uniqueList.append(item)
            }
        }
        return uniqueList
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
                    for var item in newFilteredData {
                        item.addChildData(arrList: newFilteredData)
                        self.arrImageList.append(item)
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
