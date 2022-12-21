//
//  SettingViewController.swift
//  manga
//
//  Created by Apple on 18/09/2021.
//

import UIKit
import AVFoundation
class SettingViewController: UIViewController {
    
    @IBOutlet weak var Label_Setting: UILabel!
    @IBOutlet weak var Image_sound: UIImageView!
    @IBOutlet weak var image_vibration: UIImageView!
    
    @IBOutlet weak var Label_Sound: UILabel!
    @IBOutlet weak var Label_Vibration: UILabel!
    @IBOutlet weak var Label_TitleSound: UILabel!
    @IBOutlet weak var Label_TitleVibration: UILabel!
    @IBOutlet weak var Switch_Sound: UISwitch!
    @IBOutlet weak var Switch_Vibration: UISwitch!
    
    @IBOutlet weak var ViewSound: UIView!
    var player:AVAudioPlayer?
    @IBOutlet weak var ViewVibration: UIView!
    
    @IBOutlet weak var ViewSound_Vibration: UIView!
    var ListData:[Model_Sound] = [Model_Sound]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Sound_Service.shared.getData(){ [self] repond,error in
            if let repond = repond{
                self.ListData = repond
                
            }
        }
        //am nhac
        
        //am nhac
        Label_Setting.text = "Setting"
        Label_Sound.text = "Sound"
        Label_Vibration.text = "Vibration"
        Label_TitleSound.text = "Enable App sound"
        Label_TitleVibration.text = "Enable App sound"
        
        if (UIDevice.current.userInterfaceIdiom == .pad){
            Label_Setting.font = UIFont(name:"Times New Roman", size: 30)
            Label_Sound.font = UIFont(name:"Times New Roman", size: 30)
            Label_Vibration.font = UIFont(name:"Times New Roman", size: 30)
            Label_TitleSound.font = UIFont(name:"Times New Roman", size: 20)
            Label_TitleVibration.font = UIFont(name:"Times New Roman", size: 20)
            
        }
        else if (UIDevice.current.userInterfaceIdiom == .phone){
            Label_Setting.font = UIFont(name:"Times New Roman", size: 20)
            Label_Sound.font = UIFont(name:"Times New Roman", size: 20)
            Label_Vibration.font = UIFont(name:"Times New Roman", size: 20)
            Label_TitleSound.font = UIFont(name:"Times New Roman", size: 12)
            Label_TitleVibration.font = UIFont(name:"Times New Roman", size: 12)

        }
        else{
            Label_Setting.font = UIFont(name:"Times New Roman", size: 15)
        }
        
        Switch_Sound.backgroundColor = .clear
        
        Switch_Vibration.backgroundColor = .clear
        
        ViewSound.backgroundColor = .clear
        ViewVibration.backgroundColor = .clear
        ViewSound_Vibration.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.69)
        ViewSound_Vibration.layer.cornerRadius = 20
        ViewSound_Vibration.layer.borderWidth  = 1
        ViewSound_Vibration.layer.borderColor = UIColor.white.cgColor
        if ListData[0].turn == 1{
            Switch_Sound.setOn(true, animated: false)
            
        }
        else{
            Switch_Sound.setOn(false, animated: false)
            
        }
        
        
            }
        // Do any additional setup after loading the view.
    
    
    @IBAction func backtong(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func Turn_on_Sound(_ sender: Any) {
        if Switch_Sound.isOn{
            
            Sound_Service.shared.updatesound(check: 1) { _,_ in}
            PlaySoundService.shared.playSound()
            }
        else{
            
            Sound_Service.shared.updatesound(check: 0) { _,_ in}
            PlaySoundService.shared.StopPlayer()
        }
    }
    
    
    
}
    

