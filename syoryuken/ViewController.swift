//
//  ViewController.swift
//  syoryuken
//
//  Created by 吉田力 on 2019/06/05.
//  Copyright © 2019 吉田力. All rights reserved.
//
//
//  ViewController.swift
//  syoryuken
//
//  Created by 吉田力 on 2019/06/03.
//  Copyright © 2019 吉田力. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate{
    let attackImage = UIImageView()
    var audioPlayer: AVAudioPlayer!
    let correctCommand : Array <String> = ["→","↓","↘","Y"]
    var ShuffleCommand : Array <String> = ["→","↓","↘","Y"]
    var commandCount : Int = 0
    
//    randomLIstとbuttonListのマッチングをしすること!
    func Shuffle(){
        let buttonList : Array<UIButton> = [Button1, Button2, Button3, Button4]
        ShuffleCommand = ShuffleCommand.shuffled()
        for i in 0 ... 3{
            buttonList[i].setTitle(ShuffleCommand[i], for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Shuffle()
        
        
        ryu.image = UIImage(named: "attak1")
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    @IBOutlet weak var ryu: UIImageView!
    
    func buttonActivate (){
        self.Button1.isEnabled = true
        self.Button2.isEnabled = true
        self.Button3.isEnabled = true
        self.Button4.isEnabled = true
    }
    
    
    @IBAction func command(_ sender: UIButton) {
        sender.isEnabled = false
        
        if sender.titleLabel?.text! == correctCommand[commandCount] && commandCount < 3{
            commandCount += 1
        }else if sender.titleLabel?.text! == correctCommand[commandCount] && commandCount == 3{
            commandCount = 0
            let audioPath = Bundle.main.path(forResource: "nc177750", ofType: "wav")!
            let audioUrl = URL(fileURLWithPath: audioPath)
            var audioError: NSError?
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
            }catch let error as NSError{
                audioError = error
                audioPlayer = nil
                if let error = audioError{
                    print("Error \(error.localizedDescription)")
                }
                audioPlayer.delegate = self
                audioPlayer.prepareToPlay()
            }
            let time = DispatchTime.now()
            for i in 1 ... 20{
                DispatchQueue.main.asyncAfter(deadline: time + 0.1 * Double(i)) {
                    self.ryu.image = UIImage(named: "attak\(i)")
                    if i == 20{
                        self.buttonActivate()
                    }
                }
            }
            audioPlayer.play()
            Shuffle()
        }else{
            commandCount = 0
            self.buttonActivate()
        }
    }
}

