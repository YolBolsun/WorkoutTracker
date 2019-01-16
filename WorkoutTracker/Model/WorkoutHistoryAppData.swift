//
//  WorkoutHistoryAppData.swift
//  WorkoutTracker
//
//  Created by Jonathan Clinton on 2/22/18.
//  Copyright © 2018 Jonathan Clinton. All rights reserved.
//

import Foundation
import os.log

class WorkoutHistory{
    
    static var workoutList = [Workout]()
    static var exerciseNames = Set<String>()
    
    /*static func getExercisesWithPrefix(prefix: String) -> [String]
    {
        var exercises = [String]()
        for exerciseName in exerciseNames
        {
            if(exerciseName.hasPrefix(prefix))
            {
                exercises.append(exerciseName)
            }
        }
        return exercises
    }*/
    
    func AddWorkout(workout:Workout)
    {
        WorkoutHistory.workoutList.append(workout)
    }
    static func SaveAppData()
    {
        var isSuccessfulSave = NSKeyedArchiver.archiveRootObject(WorkoutHistory.workoutList, toFile: WorkoutHistory.WorkoutHistoryArchiveURL.path)
        if isSuccessfulSave {
            os_log("Workout History successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save Workout History...", log: OSLog.default, type: .error)
        }
        
        let names = [String](WorkoutHistory.exerciseNames)
        
        isSuccessfulSave = NSKeyedArchiver.archiveRootObject(names, toFile: WorkoutHistory.ExerciseNamesArchiveURL.path)
        if isSuccessfulSave {
            os_log("Exercise Names successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save Exercise Names...", log: OSLog.default, type: .error)
        }
    }
    static func LoadAppData()
    {
        guard let workouts = (NSKeyedUnarchiver.unarchiveObject(withFile: WorkoutHistory.WorkoutHistoryArchiveURL.path) as? [Workout])
        else{
            return;
        }
        //data loaded successfully
        WorkoutHistory.workoutList = workouts
        
        guard let names = (NSKeyedUnarchiver.unarchiveObject(withFile: WorkoutHistory.ExerciseNamesArchiveURL.path) as? [String])
            else{
                return;
        }
        //data loaded successfully
        WorkoutHistory.exerciseNames = Set<String>(names)
    }
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let WorkoutHistoryArchiveURL = DocumentsDirectory.appendingPathComponent("workoutHistory")
    static let ExerciseNamesArchiveURL = DocumentsDirectory.appendingPathComponent("exerciseNames")
}


