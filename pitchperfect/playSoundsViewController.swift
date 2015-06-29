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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
    }

    @IBAction func stopPlaying(sender: AnyObject) {
        audioPlayer.stop()
        pitchPlayer.stop()
    }
    @IBAction func playFastAudio(sender: AnyObject) {
        playAudioAtRate(2)
    }
    
    @IBAction func playSlowSound(sender: AnyObject) {
        playAudioAtRate(0.5)
    }
    
    @IBAction func playChipmunkSound(sender: AnyObject) {
        playWithPitch(1000)
    }

    @IBAction func playDarthvaderSound(sender: AnyObject) {
        playWithPitch(-1000)
    }
    
    func playAudioAtRate(rate:Float) {
        audioPlayer.stop()
        audioPlayer.rate = rate
        audioPlayer.play()

    }
    
    func playWithPitch (pitch:Float) {
        audioPlayer.stop()
        
        audioEngine = AVAudioEngine()
        pitchPlayer = AVAudioPlayerNode()
        audioEngine.stop()
        audioEngine.reset()
        
        audioEngine.attachNode(pitchPlayer)
        
        var timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        audioEngine.attachNode(timePitch)
        
        audioEngine.connect(pitchPlayer, to: timePitch, format: nil)
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format: nil)
        
        var myAudioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        pitchPlayer.scheduleFile(myAudioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        pitchPlayer.play()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
