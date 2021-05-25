//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by Mac 17 on 5/24/21.
//  Copyright © 2021 deah. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var recordAudio: AVAudioRecorder?
    var playAudio: AVAudioPlayer?
    var audioURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recordingConfiguration()
        playButton.isEnabled = false
    }
    
    func recordingConfiguration() {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: [])
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            let basePath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            print("******************************")
            print(audioURL!)
            print("******************************")
            
            var settings: [String: AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            recordAudio = try AVAudioRecorder(url: audioURL!, settings: settings)
            recordAudio!.prepareToRecord()
        }
        catch let error as NSError{
            print(error)
        }
    }
    
    @IBAction func recordTapped(_ sender: Any) {
        if recordAudio!.isRecording {
            recordAudio?.stop()
            recordButton.setTitle("Grabar", for: .normal)
            playButton.isEnabled = true
        }
        else {
            recordAudio?.record()
            recordButton.setTitle("Detener", for: .normal)
            playButton.isEnabled = false
        }
        
    }
    
    @IBAction func playTapped(_ sender: Any) {
        do {
            try playAudio = AVAudioPlayer(contentsOf: audioURL!)
            playAudio!.play()
            print("Reproduciendo")
        } catch {}
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
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
