//
//  HomeListModel.swift
//  ImagesCarousel
//
//  Created by Kishlay Kishore on 04/03/24.
//

import Foundation

struct ResponseData {
    let error: Error?
    let response: Data?
    
    init(error: Error? = nil, response: Data?) {
        self.error = error
        self.response = response
    }
}

// MARK: - Home Data List Model
struct HomeDataListModel: Equatable,Codable {
    let id, author: String?
    let width, height: Int?
    let url, downloadURL: String?
    var childList: [HomeDataListModel]?
    var filteredChildList: [HomeDataListModel]?

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
    
    
    mutating func addChildData(arrList: [HomeDataListModel]) {
        self.childList = arrList
        self.filteredChildList = self.childList
    }
    
    mutating func revertData() {
        self.filteredChildList = self.childList
    }
    
    mutating func clearData() {
        self.filteredChildList?.removeAll()
    }
    
}
