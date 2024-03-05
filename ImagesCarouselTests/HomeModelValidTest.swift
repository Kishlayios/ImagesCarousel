//
//  HomeModelValidTest.swift
//  ImagesCarouselTests
//
//  Created by Kishlay Kishore on 05/03/24.
//

import XCTest
@testable import ImagesCarousel

final class HomeModelValidTest: XCTestCase {
    
    var homeModel: HomeViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        homeModel = HomeViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        homeModel = nil
    }
    
    // function to test the check duplicate method
    func testRemoveDuplicateNames_WhenNonEmptyDataIsProvided_ShouldEqualToTestData() {
        // Arrange
        let testData = [HomeDataListModel(id: "1", author: "Name1", width: 20, height: 20, url: "", downloadURL: ""),HomeDataListModel(id: "1", author: "Name1", width: 20, height: 20, url: "", downloadURL: ""),HomeDataListModel(id: "1", author: "Name1", width: 20, height: 20, url: "", downloadURL: ""),HomeDataListModel(id: "2", author: "Name2", width: 20, height: 20, url: "", downloadURL: "")]
        let dataToMatch = [HomeDataListModel(id: "1", author: "Name1", width: 20, height: 20, url: "", downloadURL: ""),HomeDataListModel(id: "2", author: "Name2", width: 20, height: 20, url: "", downloadURL: "")]
        
        // Act
        let nonDuplicateDataFetched = homeModel.removeDuplicateElements(data: testData)
        
        // Assert
        XCTAssertEqual(nonDuplicateDataFetched, dataToMatch)
    }
    
    func testRemoveDuplicateNames_WhenEmptyDataIsProvided_ShouldEqualToEmpty() {
        // Arrange
        let testData = [HomeDataListModel]()
        
        // Act
        let emptyDataFetched = homeModel.removeDuplicateElements(data: testData)
        
        // Assert
        XCTAssertEqual(emptyDataFetched, [])
    }
}
