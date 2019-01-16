//
//  WorkoutTestClass.swift
//  WorkoutTrackerTests
//
//  Created by Jonathan Clinton on 2/10/18.
//  Copyright © 2018 Jonathan Clinton. All rights reserved.
//

import XCTest
@testable import WorkoutTracker

class WorkoutTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWorkoutInit() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.\let testExercise = Exercise(name:"test", time: 0, reps:0, weight:0)
        let testWorkout1 = Workout(name:"test", timeInMinutes:0, intensity:0,date:Date())
        XCTAssert(testWorkout1 != nil)
        let testWorkout2 = Workout(name:"", timeInMinutes: 0, intensity:0, date:Date())
        XCTAssert(testWorkout2 == nil)
        let testWorkout3 = Workout(name:"test", timeInMinutes: -1, intensity:0, date:Date())
        XCTAssert(testWorkout3 == nil)
        let testWorkout4 = Workout(name:"test", timeInMinutes: 0, intensity:-1, date:Date())
        XCTAssert(testWorkout4 == nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
