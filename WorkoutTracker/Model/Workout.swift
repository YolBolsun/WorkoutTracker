//
//  Workout.swift
//  WorkoutTracker
//
//  Created by Jonathan Clinton on 2/11/18.
//  Copyright © 2018 Jonathan Clinton. All rights reserved.
//

import Foundation


class Workout : NSObject, NSCoding
{
    var name = ""
    var timeInMinutes = 0
    var intensity = 0
    var exercises = [Exercise]()
    var date = Date()
    
    override init()
    {
        super.init()
    }
    
    //Workout(name:"test", timeInMinutes:0, intensity:0)
    init?(name:String, timeInMinutes:Int, intensity:Int, date:Date)
    {
        if(name=="" || timeInMinutes < 0 || intensity < 0)
        {
            return nil
        }
        self.name = name
        self.timeInMinutes = timeInMinutes
        self.intensity = intensity
        self.date = date
    }
    
    //MARK: - Data Persistence
    struct PropertyKey
    {
        static let name = "name"
        static let timeInMinutes = "timeInMinutes"
        static let intensity = "intensity"
        static let exercises = "exercises"
        static let date = "date"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(timeInMinutes,forKey: PropertyKey.timeInMinutes)
        aCoder.encode(intensity, forKey: PropertyKey.intensity)
        let dateInterval = date.timeIntervalSince1970
        aCoder.encode(dateInterval,forKey:  PropertyKey.date)
        aCoder.encode(exercises,forKey: PropertyKey.exercises)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            //fail
            return nil
        }
        let timeInMinutes = aDecoder.decodeInt32(forKey: PropertyKey.timeInMinutes)
        let intensity = aDecoder.decodeInt32(forKey: PropertyKey.intensity)
        let dateInterval = aDecoder.decodeDouble(forKey: PropertyKey.date)
        let date = Date(timeIntervalSince1970: dateInterval)
        guard let exercises = aDecoder.decodeObject(forKey: PropertyKey.exercises) as? [Exercise] else {
            //fail
            return nil
        }
        
        self.init(name: name, timeInMinutes: Int(timeInMinutes), intensity: Int(intensity), date: date)
        self.exercises = exercises
    }
    /*static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("exercises")*/
}
