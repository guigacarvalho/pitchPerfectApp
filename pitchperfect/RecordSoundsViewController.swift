//
//  RecordSoundsViewController.swift
//  pitchperfect
//
//  Created by Guilherme Carvalho on 6/21/15.
//  Copyright (c) 2015 Guilherme Carvalho. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    // Class variables
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var micButton: UIButton!
    var audioRecorder:AVAudioRecorder!
    var recAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // UI adjustments before showing the view
    override func viewWillAppear(animated: Bool) {
        recordingLabel.text = "tap the mic to start"
        stopButton.hidden = true
    }
    
    // Stop buttion tapped action
    @IBAction func stopRecording(sender: AnyObject) {
        recordingLabel.text = "tap the mic to start"
        stopButton.hidden = true
        micButton.enabled = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }
    
    // Mic button tapped action
    @IBAction func recordAudio(sender: AnyObject) {
        // UI updates
        recordingLabel.text = "recording"
        recordingLabel.hidden = false
        stopButton.hidden = false
        micButton.enabled = false
        
        // File processing
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let recordingName = "recordedAudio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        // Audio Recording
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    
    }
    
    // After processing the recorded audio, show next screen
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        //
        if (flag) {
            recAudio = RecordedAudio(title: recorder.url.lastPathComponent!, filePathUrl: recorder.url)
            self.performSegueWithIdentifier("stopRecording", sender: recAudio)
        }
        
    }
    
    // Passing data to the next screen/screens
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:playSoundsViewController = segue.destinationViewController as! playSoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
        
        
    }

}

