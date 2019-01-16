//
//  WorkoutHistoryViewController.swift
//  WorkoutTracker
//
//  Created by Jonathan Clinton on 2/24/18.
//  Copyright © 2018 Jonathan Clinton. All rights reserved.
//

import UIKit

private let reuseIdentifier = "workoutCell"
private let spacing = CGFloat(10.0)

class WorkoutHistoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet var collectionView: UICollectionView!
    
    var selectedWorkout = Workout()
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        let itemSize = UIScreen.main.bounds.width/2-spacing*2
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(2*spacing, 0, spacing, 0)
        layout.itemSize = CGSize(width: itemSize, height: 50)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return WorkoutHistory.workoutList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! WorkoutCollectionViewCell
        
        //var test = indexPath
        cell.name.text = WorkoutHistory.workoutList[indexPath.row].name
        let dateString = Utility.getDateString(date: WorkoutHistory.workoutList[indexPath.row].date)
        cell.date.text = dateString
    
        // Configure the cell
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        guard let destination = segue.destination as? WorkoutTableViewController else {
            return
        }
        
        guard let selectedCell = sender as? WorkoutCollectionViewCell else {
            let error="Unknown Sender"
            fatalError("Unexpected sender: \(sender ?? error)")
        }
        guard let indexPath = collectionView.indexPath(for: selectedCell) else {
            fatalError("The selected cell is not being displayed by the collection")
        }
        selectedWorkout = WorkoutHistory.workoutList[indexPath.row]
        destination.workout = selectedWorkout
        destination.historyView = true;
    }

}
