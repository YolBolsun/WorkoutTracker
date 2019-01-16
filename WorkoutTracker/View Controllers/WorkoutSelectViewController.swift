//
//  FirstViewController.swift
//  WorkoutTracker
//
//  Created by Jonathan Clinton on 2/11/18.
//  Copyright © 2018 Jonathan Clinton. All rights reserved.
//

import UIKit

class WorkoutSelectViewController: UIViewController, UITextFieldDelegate {

    var workoutInView = Workout()
    var validationError = false
    
    @IBOutlet weak var WorkoutName: UITextField!
    @IBOutlet weak var WorkoutDate: UIDatePicker!
    @IBOutlet weak var WorkoutLength: UITextField!
    @IBOutlet weak var WorkoutIntensity: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WorkoutName.delegate = self
        WorkoutLength.delegate = self
        WorkoutIntensity.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
   /* func textFieldDidEndEditing(_ textField: UITextField)
    {
        workoutInView.name = textField.text!

    }*/

    @IBAction func StartWorkout(_ sender: Any) {
        
        workoutInView = Workout()
        copyViewToWorkout()
        performSegue(withIdentifier: "ToWorkoutTable", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let workoutTable = segue.destination as! WorkoutTableViewController
        workoutTable.workout = self.workoutInView
        workoutTable.timerEnabled = true
    }
    func copyViewToWorkout()
    {
        validationError = false
        if(WorkoutName!.text == nil || WorkoutName!.text == "")
        {
            if(!validationError){
                validationError = true
                Utility.raiseAlert(title: "Invalid Name", message: "Workout Name must be filled in!", sender: self)
            }
            return;
        }
        

        if(WorkoutName!.text != nil){
            workoutInView.name = WorkoutName.text!
        }
        workoutInView.date = WorkoutDate.date
        if(WorkoutLength!.text != nil && WorkoutLength!.text != "")
        {
            let length = Int(WorkoutLength.text!)
            if(length != nil){
                workoutInView.timeInMinutes = length!
            }
            else{
                if(!validationError){
                    validationError = true
                    Utility.raiseAlert(title: "Invalid Length", message: "Workout Length must be an integer!", sender: self)
                }
            }
        }
        else{
            workoutInView.timeInMinutes = 0
        }
        if(WorkoutIntensity.text != nil && WorkoutIntensity!.text != "")
        {
            let intensity = Int(WorkoutIntensity.text!)
            if intensity != nil
            {
                workoutInView.intensity = intensity!
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
            workoutInView.intensity = 0
        }
    }
    @IBAction func unwindToWorkoutSelect(sender:UIStoryboardSegue)
    {
        if sender.source is WorkoutTableViewController{
            WorkoutHistory.SaveAppData()
        }
    }
    
}

