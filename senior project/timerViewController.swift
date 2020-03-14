//
//  timerViewController.swift
//  senior project
//
//  Created by Stephaney Sumner on 3/13/20.
//  Copyright © 2020 senior project. All rights reserved.
//

import UIKit

class timerViewController: UIViewController {

   @IBOutlet weak var timerLabel: UILabel!
    var totalSeconds = 7200 //This variable will hold a starting value of seconds. 7200 = 2 hours
    var seconds = 0
    var minutes = 0
    var hours = 0
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        //creates one timer when start is pressed
        if isTimerRunning == false{
        runTimer()
        //once timer starts the button cant be pressed again
        
        }
    }
    //timeInterval - how often the a method will be called, selector - method being called updateTimer
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    //if time is less then 1 stop timer else keep counting down
    @objc func updateTimer() {
        if totalSeconds < 1 {
             timer.invalidate()
             //Send alert to indicate "time's up!" UI alert
        } else {
            totalSeconds = totalSeconds - 1
             timerLabel.text = timeString(time: TimeInterval(totalSeconds)) //This will update the label. This will send it through the timeString method where it will be formatted first and then set as the text label
            
        }
    }
    //The first time the stop button is tapped the resumeTapped will be false and the timer will be stopped with timer.invalidate(), else The following time the pause button is tapped runTimer() will again initialize the timer
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        if self.resumeTapped == false {
                 timer.invalidate()
                 self.resumeTapped = true
            } else {
                 runTimer()
                 self.resumeTapped = false
            }
    }
    //stops timer and resets the clock back to zero
    @IBAction func addButtonPressed(_ sender: UIButton) {
         timer.invalidate()
         seconds = 0
         minutes = 0
         hours = 0
         timerLabel.text = timeString(time: TimeInterval(totalSeconds))
         
         isTimerRunning = false
    }
    //It will take a time interval or Integer and return a String with the formatted time. The label will now update using this string. create a seconds, hours, mins
    func timeString(time:TimeInterval) -> String {
         let hours = totalSeconds / 3600
         let minutes = (totalSeconds % 3600) / 60
         let seconds = (totalSeconds % 3600) % 60

        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
