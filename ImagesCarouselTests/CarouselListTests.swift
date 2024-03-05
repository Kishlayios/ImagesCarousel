//
//  CarouselListTests.swift
//  ImagesCarouselTests
//
//  Created by Kishlay Kishore on 05/03/24.
//

import XCTest
@testable import ImagesCarousel

final class CarouselListTests: XCTestCase {

    var homeModel: HomeViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        homeModel = HomeViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        homeModel = nil
    }

    func testFetchImageList_FromServer_CanReturnNil() {
        // Arrange
        let exp = expectation(description:"fetching image list from server")
        
        // ACT
        homeModel.syncService.getTheImageListFromServer(pageNo: 1) { result in
            if result?.response != nil {
                // Assert
                XCTAssertNotNil(result?.response)
                exp.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0) { (error) in
            print(error?.localizedDescription ?? "error")
        }
    }

}
