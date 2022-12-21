//
//  PlayViewController.swift
//  manga
//
//  Created by Apple on 01/09/2021.
//

import UIKit

class PlayViewController: UIViewController {
    var ListData:[Model_Level] = [Model_Level]()
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var ViewCollection: UIView!
    
    @IBOutlet weak var PlayCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Level_Service.shared.getData(){ [self] repond,error in
            if let repond = repond{
                self.ListData = repond
                self.PlayCollection.reloadData()
            }
        }
        
        
        let nib = UINib(nibName: "PlayCollectionViewCell", bundle: nil)
        PlayCollection.register(nib, forCellWithReuseIdentifier: "PlayCollectionViewCell")
        PlayCollection.delegate = self
        PlayCollection.dataSource = self
        PlayCollection.backgroundColor = .clear
        ViewCollection.backgroundColor = .clear
        btn.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.69)
        // Do any additional setup after loading the view.
        btn.titleLabel?.font = UIFont(name:"Times New Roman", size: 25)
        btn.layer.cornerRadius = 10
        btn.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    @IBAction func back(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.navigationController?.pushViewController(vc, animated: false)
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: false)
    }
    
    
    
    
}
extension PlayViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return ListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("------------------------\(ListData[indexPath.row].id)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayCollectionViewCell", for: indexPath as IndexPath) as! PlayCollectionViewCell
        cell.ViewTong.backgroundColor = .clear
        cell.ViewLabel.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.69)
        
        let myColor = UIColor.white
        let data = NSData(bytes:  ListData[indexPath.row].img.bytes, length: ListData[indexPath.row].img.bytes.count)
        if let image = UIImage(data: data as Data){
            cell.Image_Play.image = image
        }
        
        cell.Level_Label.text = "Level " + "\(ListData[indexPath.row].id)"
        cell.Type_Label.text = "\(ListData[indexPath.row].type)"
        
        
        if ListData[indexPath.row].lock == 1{
            print(ListData[indexPath.row].lock)
            cell.View_Lock.backgroundColor = .clear
            cell.Image_Lock.image = UIImage(named: "lock")
            cell.Image_Lock.isHidden = true
        }
        else{
            cell.View_Lock.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.69)
            print(ListData[indexPath.row].lock)
            cell.Image_Lock.isHidden = false
            cell.Image_Lock.image = UIImage(named: "lock")
            cell.View_Lock.layer.borderWidth = 2
            cell.View_Lock.layer.borderColor = myColor.cgColor

        }
        
        
        cell.Level_Label.textColor = .white
        cell.Type_Label.textColor = .white
        cell.number_of_complete.textColor = .white
        cell.lock_Label.textColor = .white
        
        
        cell.ViewLabel.layer.borderWidth = 1
        cell.ViewLabel.layer.borderColor = myColor.cgColor
        
        cell.Image_Play.layer.borderWidth = 2
        cell.Image_Play.layer.borderColor = myColor.cgColor
        
        
        if (UIDevice.current.userInterfaceIdiom == .pad){
            cell.Level_Label.font = UIFont(name:"Times New Roman", size: 25)
            cell.Type_Label.font = UIFont(name:"Times New Roman", size: 25)
            cell.lock_Label.font = UIFont(name:"Times New Roman", size: 25)
            
        }
        else if(UIDevice.current.userInterfaceIdiom == .phone){
            cell.Level_Label.font = UIFont(name:"Times New Roman", size: 20)
            cell.Type_Label.font = UIFont(name:"Times New Roman", size: 20)
            cell.lock_Label.font = UIFont(name:"Times New Roman", size: 20)
        }
        else{
            cell.Level_Label.font = UIFont(name:"Times New Roman", size: 20)
        }
        
        
        cell.ViewLabel.clipsToBounds = true
        cell.ViewLabel.layer.cornerRadius = 20
        cell.ViewLabel.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case indexPath.row:
            if ListData[indexPath.row].lock == 1{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ActionViewController") as! ActionViewController
                vc.navigationController?.pushViewController(vc, animated: true)
                vc.modalPresentationStyle = .overFullScreen
                vc.level = "\(indexPath.row + 1)"
                vc.ID = indexPath.row + 1
                print(indexPath.row + 1)
                self.present(vc, animated: true)
                print(indexPath.row)
            }
            
        default:
            print("")
        }
    }
    
    
}
extension PlayViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (UIDevice.current.userInterfaceIdiom == .pad){
            let yourWidth = view.frame.width/1.3
            let yourHeight = collectionView.bounds.height/3
            return CGSize(width: yourWidth, height: yourHeight)
        }
        
        else if (UIDevice.current.userInterfaceIdiom == .phone){
            let yourWidth = view.frame.width/1.2
            let yourHeight = collectionView.bounds.height/3
            return CGSize(width: yourWidth, height: yourHeight)
        }
        else {
            let yourWidth = view.frame.width/1.2
            let yourHeight = collectionView.bounds.height/2.4
            return CGSize(width: yourWidth, height: yourHeight)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(20)
    }
}


