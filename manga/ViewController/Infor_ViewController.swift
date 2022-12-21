//
//  Infor_ViewController.swift
//  manga
//
//  Created by Apple on 14/09/2021.
//

import UIKit
import StoreKit
class Infor_ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var ListTitle:[String] = ["Email", "Rate","Version","Infor"]
    var ListButton:[String] = ["  Email  ","  Rate  ","",""]
    var ListImage:[String] = ["image_email","Image_rate","Image_version","Image_infor"]
    var ListInfor:[String] = ["Do you have any question, \n ideas, problem, or suggestions?", "Would you like to rate for app?","1.9822(98) manga.anime.comic.quiz","AGB/Dataprotection/Imprint"]
    
    
    @IBOutlet weak var ViewCollec_and_Text: UIView!
    @IBOutlet weak var Label_Infor: UILabel!
    @IBOutlet var ViewTong: UIView!
    @IBOutlet weak var ViewCollection: UIView!
    @IBOutlet weak var Infor_Collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "infor_CollectionViewCell", bundle: nil)
        Infor_Collection.register(nib, forCellWithReuseIdentifier: "infor_CollectionViewCell")
        Infor_Collection.delegate = self
        Infor_Collection.dataSource = self
        ViewTong.backgroundColor = .clear
        ViewCollection.backgroundColor = .clear
        Infor_Collection.backgroundColor = .clear
        
        ViewCollec_and_Text.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.69)
        ViewCollec_and_Text.layer.cornerRadius = 20
        ViewCollec_and_Text.layer.borderWidth = 1
        ViewCollec_and_Text.layer.borderColor = UIColor.white.cgColor
        
        Label_Infor.text = " Infos "
        Label_Infor.textColor = .black
        Label_Infor.backgroundColor = .white
        
        Label_Infor.layer.borderWidth = 3
        Label_Infor.layer.borderColor = UIColor.white.cgColor
        
        if (UIDevice.current.userInterfaceIdiom == .pad){
            Label_Infor.font = UIFont(name:"Times New Roman", size: 30)
        }
        else if (UIDevice.current.userInterfaceIdiom == .phone){
            Label_Infor.font = UIFont(name:"Times New Roman", size: 20)
        }
        else{
            Label_Infor.font = UIFont(name:"Times New Roman", size: 15)
        }
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ListTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infor_CollectionViewCell", for: indexPath as IndexPath) as! infor_CollectionViewCell
        let myColor = UIColor.white
        cell.Label_Title.text = ListTitle[indexPath.row]
        cell.Label_infor.text = ListInfor[indexPath.row]
        cell.Button.text = " "  + ListButton[indexPath.row] + " "
        cell.Image_Title.image = UIImage(named: ListImage[indexPath.row])
        
        cell.Label_Title.textColor = .white
        cell.Label_infor.textColor = .white
        cell.Button.textColor = .white
        
        
        if cell.Button.text != "  "{
            cell.Button.layer.borderWidth = 1
            cell.Button.layer.borderColor = myColor.cgColor
        }
        cell.Button.layer.cornerRadius = 10
        if (UIDevice.current.userInterfaceIdiom == .pad){
            cell.Label_Title.font = UIFont(name:"Times New Roman", size: 30)
            cell.Label_infor.font = UIFont(name:"Times New Roman", size: 20)
            cell.Button.font = UIFont(name:"Times New Roman", size: 30)
            
        }
        else if(UIDevice.current.userInterfaceIdiom == .phone){
            cell.Label_Title.font = UIFont(name:"Times New Roman", size: 20)
            cell.Label_infor.font = UIFont(name:"Times New Roman", size: 12)
            cell.Button.font = UIFont(name:"Times New Roman", size: 20)
        }
        else{
            cell.Label_Title.font = UIFont(name:"Times New Roman", size: 40)
            cell.Label_infor.font = UIFont(name:"Times New Roman", size: 40)
            cell.Button.font = UIFont(name:"Times New Roman", size: 40)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("email")
        case 1:
            guard let sce = view.window?.windowScene else {
                print("dat dep trai")
                return
            }
            SKStoreReviewController.requestReview(in: sce)
        default:
            print()
        }
    }

    @IBAction func BtnBack(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
extension Infor_ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (UIDevice.current.userInterfaceIdiom == .pad){
            let yourWidth = view.frame.width/1.2
            let yourHeight = collectionView.bounds.height/4
            return CGSize(width: yourWidth, height: yourHeight)
        }
        else if (UIDevice.current.userInterfaceIdiom == .phone){
            let yourWidth = view.frame.width/1.2
            let yourHeight = collectionView.bounds.height/4.5
            return CGSize(width: yourWidth, height: yourHeight)
            
        }
        else{
            let yourWidth = view.frame.width/1.2
            let yourHeight = collectionView.bounds.height/2.4
            return CGSize(width: yourWidth, height: yourHeight)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        collectionView.backgroundColor = .clear
        return CGFloat(5)
    }
}
