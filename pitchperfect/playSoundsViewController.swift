//
//  playSoundsViewController.swift
//  pitchperfect
//
//  Created by Guilherme Carvalho on 6/28/15.
//  Copyright (c) 2015 Guilherme Carvalho. All rights reserved.
//

import UIKit
import AVFoundation

class playSoundsViewController: UIViewController {

    var receivedAudio:RecordedAudio!
    var audioPlayer:AVAudioPlayer!
    var pitchPlayer:AVAudioPlayerNode!
    var audioEngine:AVAudioEngine!
    
    
    // Receives audio file from previous View Controller and setting up audio engine
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        pitchPlayer = AVAudioPlayerNode()
    }
    
    // Actions for playing with varying pitch and speed and stop playback
    @IBAction func stopPlaying(sender: AnyObject) {
        audioPlayer.stop()
        pitchPlayer.stop()
    }
    @IBAction func playFastAudio(sender: AnyObject) {
        audioEngine.stop()
        audioEngine.reset()
        playAudioAtRate(2)
    }
    
    @IBAction func playSlowSound(sender: AnyObject) {
        audioEngine.stop()
        audioEngine.reset()
        playAudioAtRate(0.5)
    }
    
    @IBAction func playChipmunkSound(sender: AnyObject) {
        playWithPitch(1000)
    }

    @IBAction func playDarthvaderSound(sender: AnyObject) {
        playWithPitch(-1000)
    }
    
    
    // Auxiliary methods for playing with varying speed and pitch
    func playAudioAtRate(rate:Float) {
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func playWithPitch (pitch:Float) {
        // Setting up audio engine
        audioPlayer.stop()
        audioEngine = AVAudioEngine()
        pitchPlayer = AVAudioPlayerNode()
        audioEngine.stop()
        audioEngine.reset()
        audioEngine.attachNode(pitchPlayer)
        
        // Adjusting audio pitch
        var timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        audioEngine.attachNode(timePitch)
        audioEngine.connect(pitchPlayer, to: timePitch, format: nil)
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format: nil)
        
        // Playing audio
        var myAudioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        pitchPlayer.scheduleFile(myAudioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        pitchPlayer.play()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
