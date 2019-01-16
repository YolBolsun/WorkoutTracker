//
//  WorkoutTableViewController.swift
//  WorkoutTracker
//
//  Created by Jonathan Clinton on 2/16/18.
//  Copyright © 2018 Jonathan Clinton. All rights reserved.
//

import UIKit

class WorkoutTableViewController: UITableViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var navBar: UINavigationItem!
    
    @IBOutlet weak var completeWorkoutView: UIView!
    
    var historyView = false
    var workout = Workout()
    var selectedExercise = Exercise()
    var timer = Timer()
    var counter = 0.0
    var minutes = 0
    public var timerEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.leftBarButtonItem = editButtonItem
        navBar.title = workout.name

        tableView.tableFooterView = completeWorkoutView
        if(historyView)
        {
            completeWorkoutView.isHidden = true
        }
        if(timerEnabled){
            timeLabel.isEnabled = true
            timeLabel.isHidden = false
            timeLabel.frame.size.height = 44
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        }
        else{
            timeLabel.isEnabled = false
            timeLabel.isHidden = true
            timeLabel.frame.size.height = 0
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func UpdateTimer() {
        counter = counter + 0.1
        if(counter >= 60)
        {
            counter = counter.truncatingRemainder(dividingBy: 60);
            minutes = minutes + 1
        }
        var stringMinutes = String(format: "%D", minutes)
        if(minutes < 10)
        {
            stringMinutes = "0" + stringMinutes
        }
        var stringSeconds = String(format: "%.1f", counter)
        if(counter < 10)
        {
            stringSeconds = "0" +  stringSeconds
        }
        let stringToPrint = stringMinutes + ":" + stringSeconds
        timeLabel.text = stringToPrint
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK : Button setup
    
   /* override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var frame = completeWorkoutView.frame;
        frame.origin.y = scrollView.contentOffset.y + tableView.frame.size.height - completeWorkoutView.frame.size.height;
        completeWorkoutView.frame = frame;
        
        view.bringSubview(toFront: completeWorkoutView)
    }*/
    /*func setupCompleteButton()
    {
        completeWorkoutView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            completeWorkoutView.rightAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
            completeWorkoutView.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        } else {
            completeWorkoutView.rightAnchor.constraint(equalTo: tableView.layoutMarginsGuide.rightAnchor, constant: 0).isActive = true
            completeWorkoutView.bottomAnchor.constraint(equalTo: tableView.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true
        }
    }*/
    
    //MARK table functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workout.exercises.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! WorkoutTableViewCell
        cell.name.text = workout.exercises[indexPath.row].name
        cell.reps.text = String(workout.exercises[indexPath.row].reps)
        cell.weight.text = String(workout.exercises[indexPath.row].weight)
        cell.length.text = String(workout.exercises[indexPath.row].time)
        if(cell.length.text == "0")
        {
            cell.timeStack.isHidden = true
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Exercise List"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            workout.exercises.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        var navController = UINavigationController()
        if(segue.destination is UINavigationController)
        {
            navController = segue.destination as! UINavigationController
        }
        /*guard let navController = segue.destination as? UINavigationController else {
            return;// backing out and no need to do more
        }*/
        var destination = ExerciseSelectViewController()
        var destinationCompleteWorkout = CompleteWorkoutViewController()
        
        if(navController.childViewControllers.count > 0 && navController.childViewControllers[0] is ExerciseSelectViewController){
        destination = navController.childViewControllers[0] as! ExerciseSelectViewController
        }
        else if(segue.destination is CompleteWorkoutViewController){
            destinationCompleteWorkout = segue.destination as! CompleteWorkoutViewController
        }
        
        
        switch(segue.identifier ?? "") {
        case "AddExercise":
            selectedExercise = Exercise()
        case "EditExercise":
            guard let selectedCell = sender as? WorkoutTableViewCell else {
                let error="Unknown Sender"
                fatalError("Unexpected sender: \(sender ?? error)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            selectedExercise = workout.exercises[indexPath.row]
        case "CompleteWorkout":
            destinationCompleteWorkout.minutes = self.minutes;
            destinationCompleteWorkout.seconds = self.counter;
            destinationCompleteWorkout.workoutToSave = self.workout;
            return;
        default:
            fatalError("Unexpected segue error")
        }
        destination.exerciseInView = selectedExercise
    }
    
    @IBAction func unwindToExerciseList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ExerciseSelectViewController{
            let exercise = sourceViewController.exerciseInView
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                workout.exercises[selectedIndexPath.row] = exercise
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                let newIndexPath = IndexPath(row: (workout.exercises.count), section: 0)
                workout.exercises.append(exercise)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    @IBAction func completeWorkout(_ sender: Any) {
        //WorkoutHistory.workoutList.append(workout)
        //dismiss(animated: true, completion: nil)
        }
    }
