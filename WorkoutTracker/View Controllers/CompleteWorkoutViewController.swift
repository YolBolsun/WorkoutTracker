//
//  CompleteWorkoutViewController.swift
//  WorkoutTracker
//
//  Created by Jonathan Clinton on 3/21/18.
//  Copyright © 2018 Jonathan Clinton. All rights reserved.
//

import UIKit

class CompleteWorkoutViewController: UIViewController {
    
    public var minutes = 0;
    public var seconds = 0.0;
    var validationError = false
    public var workoutToSave = Workout()
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var length: UITextField!
    @IBOutlet weak var intensity: UITextField!
    
    
    @IBOutlet weak var tempLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //tempLabel.text = String(minutes) + " " + String(seconds)
        name.text = workoutToSave.name
        date.date = workoutToSave.date
        length.text = String(minutes)
        intensity.text = String(workoutToSave.intensity)
    }
    
    @IBAction func Save(_ sender: UIButton) {
        copyViewToWorkout()
        WorkoutHistory.workoutList.append(workoutToSave)
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    func copyViewToWorkout()
    {
        validationError = false
        if(name!.text == nil || name!.text == "")
        {
            if(!validationError){
                validationError = true
                Utility.raiseAlert(title: "Invalid Name", message: "Workout Name must be filled in!", sender: self)
            }
            return;
        }
        
        if(name!.text != nil){
            workoutToSave.name = name.text!
        }
        workoutToSave.date = date.date
        if(length!.text != nil && length!.text != "")
        {
            let lengthText = Int(length.text!)
            if(lengthText != nil){
                workoutToSave.timeInMinutes = lengthText!
            }
            else{
                if(!validationError){
                    validationError = true
                    Utility.raiseAlert(title: "Invalid Length", message: "Workout Length must be an integer!", sender: self)
                }
            }
        }
        else{
            workoutToSave.timeInMinutes = 0
        }
        if(intensity.text != nil && intensity!.text != "")
        {
            let intensityText = Int(intensity.text!)
            if intensityText != nil
            {
                workoutToSave.intensity = intensityText!
            }
            else{
                if(!validationError){
                    validationError = true
                    Utility.raiseAlert(title: "Invalid Intensity", message: "Workout Intensity must be an integer!", sender: self)
                }
                //raise error about needing to be a number
            }
        }
        else
        {
            workoutToSave.intensity = 0
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
