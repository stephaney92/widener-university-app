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
    var seconds = 60 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var resumeTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        runTimer()
    }
    //timeInterval - how often the a method will be called, selector - method being called updateTimer
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        timerLabel.text = "\(seconds)" //This will update the label.
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
        seconds = 60
        timerLabel.text = "\(seconds)"
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
