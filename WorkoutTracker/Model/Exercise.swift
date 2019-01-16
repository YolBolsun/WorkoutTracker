//
//  Exercise.swift
//  WorkoutTracker
//
//  Created by Jonathan Clinton on 2/11/18.
//  Copyright © 2018 Jonathan Clinton. All rights reserved.
//

import Foundation


class Exercise: NSObject, NSCoding{
    
    var name = ""
    var time = 0
    var reps = 0
    var weight = 0
    var notes = ""
    
    override init()
    {
        super.init()
    }
    
    //Exercise(name:"test", time: 0, reps:0, weight:0)
    init?(name:String,time:Int,reps:Int,weight:Int, notes:String)
    {
        if(name == "" || time < 0 || reps < 0 || weight < 0)
        {
            return nil
        }
        self.name = name
        self.time = time
        self.reps = reps
        self.weight = weight
        self.notes = notes
    }
    
    //MARK: - Data Persistence
    struct PropertyKey
    {
        static let name = "name"
        static let time = "time"
        static let reps = "reps"
        static let weight = "weight"
        static let notes = "notes"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(time, forKey: PropertyKey.time)
        aCoder.encode(reps, forKey: PropertyKey.reps)
        aCoder.encode(weight, forKey: PropertyKey.weight)
        aCoder.encode(notes, forKey: PropertyKey.notes)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
                //fail
            return nil
        }
        let time = aDecoder.decodeInt32(forKey: PropertyKey.time)
        let reps = aDecoder.decodeInt32(forKey: PropertyKey.reps)
        let weight = aDecoder.decodeInt32(forKey: PropertyKey.weight)
        guard let notes = aDecoder.decodeObject(forKey: PropertyKey.notes) as? String else {
            //fail
            return nil
        }
        
        self.init(name: name, time: Int(time), reps: Int(reps), weight: Int(weight), notes: notes)
        
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("exercises")
}
