//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Michael Wakeling on 4/21/18.
//  Copyright © 2018 Michael Wakeling. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    //MARK: Food Class Tests
    func testFoodInitializationSucceeds() {
        let zeroRatingFood = Food.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingFood)
        
        let positiveRatingFood = Food.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingFood)
    }
    
    func testFoodInitializationFails() {
        let negativeRatingFood = Food.init(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingFood)
        
        let largeRatingFood = Food.init(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingFood)
        
        let emptyStringFood = Food.init(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringFood)
    }
    
}
