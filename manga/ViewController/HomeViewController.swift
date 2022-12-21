//
//  HomeViewController.swift
//  manga
//
//  Created by Apple on 31/08/2021.
//

import UIKit
import AVFoundation
class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var ListImage:[String] = ["Image_play","Image_point","Image_otherapp"]
    var ListLabel:[String] = [" Start ","Points","Other Apps"]
    var ListData:[Model_Sound] = [Model_Sound]()
    var runCount:Int = 0
    var player: AVAudioPlayer?
    
    @IBOutlet weak var View_Collection: UIView!
    
    @IBOutlet weak var LabelManga: UILabel!
    
    @IBOutlet weak var HomeCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Sound_Service.shared.getData(){ [self] repond,error in
            if let repond = repond{
                self.ListData = repond
                
            }
        }
        
        
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        HomeCollection.register(nib, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        HomeCollection.delegate = self
        HomeCollection.dataSource = self
        
        View_Collection.backgroundColor = .clear
        
        LabelManga.textColor = .white
        LabelManga.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
        let myColor = UIColor.white
        LabelManga.layer.borderWidth = 0.5
        LabelManga.layer.shadowColor = UIColor.white.cgColor
        LabelManga.layer.shadowOpacity = 1
        LabelManga.layer.shadowOffset = CGSize.zero
        LabelManga.layer.shadowRadius = 5
        LabelManga.layer.borderColor = myColor.cgColor
        LabelManga.layer.cornerRadius = 10
        
        LabelManga.text = "\nManga  \n"
        if (UIDevice.current.userInterfaceIdiom == .pad){
            LabelManga.font = UIFont(name:"Times New Roman", size: 30)
            
        }
        else if(UIDevice.current.userInterfaceIdiom == .phone){
            LabelManga.font = UIFont(name:"Times New Roman", size: 25)
            
        }
        else{
            LabelManga.font = UIFont(name:"Times New Roman", size: 25)
        }
        //
        
        if ListData[0].turn == 1{
            PlaySoundService.shared.playSound()
        }
        else{
            PlaySoundService.shared.StopPlayer()
        }
        
        
        
        
        
        
        
        }
    
        
        
        
        // Do any additional setup after loading the view.
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath as IndexPath) as! HomeCollectionViewCell
        let myColor = UIColor.white
        cell.Image?.image = UIImage(named: ListImage[indexPath.row])
        
        cell.ViewImage.layer.borderWidth = 1
        cell.ViewImage.layer.borderColor = myColor.cgColor
        cell.ViewImage.layer.cornerRadius = 25
        cell.ViewImage.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1)
        
        cell.Label.text = ListLabel[indexPath.row]
        cell.Label.textColor = .white
        
        if (UIDevice.current.userInterfaceIdiom == .pad){
            cell.Label.font = UIFont(name:"Times New Roman", size: 40)
        }
        else if(UIDevice.current.userInterfaceIdiom == .phone){
            cell.Label.font = UIFont(name:"Times New Roman", size: 30)
        }
        else{
            cell.Label.font = UIFont(name:"Times New Roman", size: 25)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("0")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
            vc.navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        case 1:
            print("1")
        case 2:
            print("2")
        default:
            print("")
        }
    }
    
    @IBAction func Button_Setting(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        vc.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: true)
    }
    
    @IBAction func Button_Infor(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Infor_ViewController") as! Infor_ViewController
        vc.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
    
}
extension HomeViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (UIDevice.current.userInterfaceIdiom == .pad){
            var dem = -1
            for item in ListLabel[indexPath.item]{
                if item == "t"{
                    dem = dem + 1
                }
            }
            let width = collectionView.bounds.width/2.1
            var widthpro = width + CGFloat(dem * 158)
            let height = collectionView.bounds.height/3.5
            return CGSize(width: widthpro, height: height)
        }
        else if (UIDevice.current.userInterfaceIdiom == .phone){
            var dem = -1
            for item in ListLabel[indexPath.item]{
                if item == "t"{
                    dem = dem + 1
                }
            }
            let width = collectionView.bounds.width/2.1
            var widthpro = width + CGFloat(dem * 150)
            let height = collectionView.bounds.height/3
            return CGSize(width: widthpro, height: height)
            
        }
        else{
            let yourWidth = view.frame.width/1.2
            let yourHeight = collectionView.bounds.height/2.4
            return CGSize(width: yourWidth, height: yourHeight)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        collectionView.backgroundColor = .clear
        return CGFloat(20)
    }
    
    
}
