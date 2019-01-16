//
//  ExerciseTestClass.swift
//  WorkoutTrackerTests
//
//  Created by Jonathan Clinton on 2/10/18.
//  Copyright © 2018 Jonathan Clinton. All rights reserved.
//

import XCTest
@testable import WorkoutTracker

class ExerciseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExerciseInit() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //init?(name:String,time:Int,reps:Int,weight:Int, notes:String)
        let testExercise = Exercise(name:"test", time: 0, reps:0, weight:0,notes:"")
        XCTAssert(testExercise != nil)
        let testExercise2 = Exercise(name:"test", time: -1, reps:0, weight:0,notes:"")
        XCTAssert(testExercise2 == nil)
        let testExercise3 = Exercise(name:"test", time: 0, reps:-1, weight:0,notes:"")
        XCTAssert(testExercise3 == nil)
        let testExercise4 = Exercise(name:"test", time: 0, reps:0, weight:-1,notes:"")
        XCTAssert(testExercise4 == nil)
        let testExercise5 = Exercise(name:"", time: 0, reps:0, weight:0,notes:"")
        XCTAssert(testExercise5 == nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
