//
//  ExerciseSelectViewController.swift
//  WorkoutTracker
//
//  Created by Jonathan Clinton on 2/18/18.
//  Copyright © 2018 Jonathan Clinton. All rights reserved.
//

import UIKit

class ExerciseSelectViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var Name: SearchTextField!
    @IBOutlet weak var Weight: UITextField!
    @IBOutlet weak var Reps: UITextField!
    @IBOutlet weak var Time: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var Notes: UITextView!
    
    var exerciseInView = Exercise()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.view.addSubview(autocompleteTableView)
        configureSimpleSearchTextField()
        Name.delegate = self
        Name.addTarget(self, action: #selector(ExerciseSelectViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        Name.text = exerciseInView.name
        Weight.text = exerciseInView.weight == 0 ? "" : String(exerciseInView.weight)
        Reps.text = exerciseInView.reps == 0 ? "" :  String(exerciseInView.reps)
        Time.text = exerciseInView.time == 0 ? "" :  String(exerciseInView.time)
        Notes.text = exerciseInView.notes
        
        Notes.layer.cornerRadius = 5
        Notes.layer.borderColor = UIColor.lightGray.cgColor
        Notes.layer.borderWidth = 1
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK : Autocomplete
    fileprivate func configureSimpleSearchTextField() {
        // Start visible even without user's interaction as soon as created - Default: false
        //leaving false
        
        // Set data source
        Name.filterStrings(Array(WorkoutHistory.exerciseNames))
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            //verify that save was pressed
                return
        }
        let name = Name.text ?? ""
        let weight = Int(Weight.text ?? "") ?? 0
        let reps = Int(Reps.text ?? "") ?? 0
        let time = Int(Time.text ?? "") ?? 0
        let notes = Notes.text ?? ""
        exerciseInView = Exercise(name: name, time: time, reps: reps, weight: weight, notes: notes)!
        WorkoutHistory.exerciseNames.insert(name)
    }
 
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - UITextFieldDelegate
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    //MARK: - Private Methods
    private func updateSaveButtonState()
    {
        let text = Name.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}
