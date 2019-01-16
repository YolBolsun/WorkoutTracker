//
//  UtilityTests.swift
//  WorkoutTrackerTests
//
//  Created by Jonathan Clinton on 2/11/18.
//  Copyright © 2018 Jonathan Clinton. All rights reserved.
//

import XCTest
@testable import WorkoutTracker

class UtilityTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testGetDate() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testDateString = "01-15-1990"
        let testDate = Utility.getDate(date: testDateString)
        XCTAssert(testDate != nil)
        let unitFlags: NSCalendar.Unit = [.hour, .day, .month, .year]
        let calendar = NSCalendar(calendarIdentifier: .gregorian)!
        let components = calendar.components(unitFlags, from:testDate!)
        XCTAssert(components.hour == 0)
        XCTAssert(components.day == 15)
        XCTAssert(components.month == 1)
        XCTAssert(components.year == 1990)
    }
    func testGetDateString() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testDateString = "01-15-1990"
        //let testDate = Utility.getDate(date: testDateString)
        let components = NSDateComponents()
        //components.calendar = calendar!
        components.day = 15
        components.month = 1
        components.year = 1990
        //let timeInterval =
        //let testDate = NSDate(timeIntervalSince1970: timeInterval)
        
        //let unitFlags: NSCalendar.Unit = [.hour, .day, .month, .year]
        //let calendar = NSCalendar(calendarIdentifier: .gregorian)!
        //let components = calendar.components(unitFlags, from:testDate!)
        
        //let testDateValue1 = Utility.getDateString(date: components.date!)
        //XCTAssert(testDateValue1 == testDateString)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
