//
//  ViewController.swift
//  SoundBoard
//
//  Created by Mac 17 on 5/24/21.
//  Copyright © 2021 deah. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableRecordings: UITableView!
    
    var recordings: [Recording] = []
    var playAudio: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableRecordings.delegate = self
        tableRecordings.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            recordings = try
                context.fetch(Recording.fetchRequest())
            tableRecordings.reloadData()
        } catch {}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recordings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let recording = recordings[indexPath.row]
        cell.textLabel?.text = recording.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recording = recordings[indexPath.row]
        do {
            playAudio = try AVAudioPlayer(data: recording.audio! as Data)
            print("Reproduciendo audio \(recording.name!)")
        } catch {}
        tableRecordings.deselectRow(at: indexPath, animated: true)
    }
}

