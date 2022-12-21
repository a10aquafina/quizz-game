//
//  Action_TextViewController.swift
//  manga
//
//  Created by Apple on 08/09/2021.
//

import UIKit

class Action_TextViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
   
    @IBOutlet weak var causobn: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var width_Blue: NSLayoutConstraint!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var Blue: UIView!
    @IBOutlet weak var TimeBlue: UIView!
    @IBOutlet weak var ViewImage_Question: UIView!
    @IBOutlet weak var ViewCollection: UIView!
    @IBOutlet weak var Label_Question: UILabel!
    
    @IBOutlet weak var khoangcachview: NSLayoutConstraint!
    var isPaused = true
    var nextsceen:Int!
    var level:String!
    var causo:Int = 0
    var timer = Timer()
    var runCount:Float = 0
    var number:Int!
    var check:Bool = true
    var checkrepeat:Bool = true
    var vitri:Int = 0
    var abc:IndexPath!
    var solan:Int = 1
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var Image_ques: UIImageView!
    var ListData:[Model_qus_img] = [Model_qus_img]()
    var ListDataprocess:[Model_qus_img] = [Model_qus_img]()
    var ListDataAnswer:[String] = []
    var ListDataAnswerShow:[String] = []
    let screenSize:CGRect = UIScreen.main.bounds
    var phantram:Float = 1.00
    var phantramshow:Float!
    var suff:[Int] = []
    var suff12:[Int] = []
    var ID:Int!
    @IBOutlet weak var Action_Text_Collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Ques_img_Service.shared.getData(){ [self] repond,error in
                 if let repond = repond{
                     self.ListData = repond
                     self.Action_Text_Collection.reloadData()
                    }
                }
        TimeBlue.layer.cornerRadius = 20
        Blue.layer.cornerRadius = 20
        btnNext.isHidden = true
        
        btnNext.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.69)
        btnBack.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.69)
        
        
        btnBack.clipsToBounds = true
        btnBack.layer.cornerRadius = 10
        btnNext.layer.cornerRadius = 10
        btnBack.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        btnNext.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        btnNext.titleLabel?.font = UIFont(name:"Times New Roman", size: 17)
        btnBack.titleLabel?.font = UIFont(name:"Times New Roman", size: 30)
        
        let nib = UINib(nibName: "Action_TextCollectionViewCell", bundle: nil)
        Action_Text_Collection.register(nib, forCellWithReuseIdentifier: "Action_TextCollectionViewCell")
        Action_Text_Collection.delegate = self
        Action_Text_Collection.dataSource = self
        Action_Text_Collection.backgroundColor = .clear
        
        ViewCollection.backgroundColor = .clear
        let myColor = UIColor.white
        //
        TimeBlue.backgroundColor = .clear
        TimeBlue.layer.borderWidth = 1
        TimeBlue.layer.borderColor = myColor.cgColor
        //
     
        ViewImage_Question.layer.borderWidth = 1.5
        ViewImage_Question.layer.borderColor = myColor.cgColor
        ViewImage_Question.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.69)
        
        for item in ListData{
            if item.level == level{
                ListDataprocess.append(item)
            }
        }
        nextsceen = ListDataprocess.count
        percent.textColor = .white
        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timegiam), userInfo: nil, repeats: true)
        
        
        
        ViewImage_Question.clipsToBounds = true
        ViewImage_Question.layer.cornerRadius = 20
        ViewImage_Question.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        
//        if (UIDevice.current.userInterfaceIdiom == .pad){
//            khoangcachview.constant = 80
//        }
       
        // ngoiaf viewdiaload
    }
    @objc func timegiam(){
        if isPaused {
            self.runCount += 0.15
           
            self.phantram = Float((15.0 - self.runCount)/15.0 * 100)
            self.phantramshow = Float(Double(self.phantram).rounded(toPlaces: 2))
            if Float(Double(self.phantramshow)) > 0{
                self.percent.text = "\(Float(Double(self.phantramshow)))" + "%"}
            else{
                self.percent.text = "0" + "%"
                    }
            self.width_Blue.constant = self.TimeBlue.frame.width - self.TimeBlue.frame.width*CGFloat((15.0 - self.runCount)/15.0)
            if self.phantram > 50 {self.Blue.backgroundColor = . blue}
            else if self.phantram <= 50 && self.phantram > 20{self.Blue.backgroundColor = .yellow}
            else{self.Blue.backgroundColor = .red}
            timedat()
            
        }
        else{
            //timer.invalidate()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        ListDataAnswer.append(ListDataprocess[causo].ans1)
        ListDataAnswer.append(ListDataprocess[causo].ans2)
        ListDataAnswer.append(ListDataprocess[causo].ans3)
        ListDataAnswer.append(ListDataprocess[causo].ans4)
        
        let num = [0,1,2,3]
        suff = num.shuffled()
        suff12 = suff
        
        for item in 0...3{
            ListDataAnswerShow.append(ListDataAnswer[suff[0]])
            suff.remove(at: 0)
        }
        for i in 0...suff12.count - 1 {
            if suff12[i] == 1{
                vitri = i
            }
        }
        
        
        abc = IndexPath(item: vitri, section: 0)
        
        let data = NSData(bytes:  ListDataprocess[causo].img.bytes, length: ListDataprocess[causo].img.bytes.count)
        if let image = UIImage(data: data as Data){
            Image_ques.image = image
        }
        causobn.text = "\(number+1)"+"/4"
        causobn.textColor = .white
        Label_Question.text = ListDataprocess[causo].ques
        Label_Question.font = UIFont(name:"Times New Roman", size: 20)
        Label_Question.textColor = .white
        
        return 4
    }
    func timedat(){
        if phantram < 0{
            timer.invalidate()
            solan = solan - 1
            btnNext.isHidden = false
            checkrepeat = false
            isPaused = false
            check = false
            Action_Text_Collection.shaking()
            Action_Text_Collection.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Action_TextCollectionViewCell", for: indexPath as IndexPath) as! Action_TextCollectionViewCell
        let myColor = UIColor.white
        cell.Label_Answer.text = ListDataAnswerShow[indexPath.row]
        cell.ViewLabel_Question.backgroundColor = UIColor(red: 0/255, green:  0/255, blue:  0/255, alpha: 0.69)
        cell.ViewLabel_Question.layer.borderWidth = 1
        cell.ViewLabel_Question.layer.borderColor = myColor.cgColor
        cell.ViewLabel_Question.layer.cornerRadius = 20
        cell.Label_Answer.font = UIFont(name:"Times New Roman", size: 20)
        cell.Label_Answer.textColor = .white
        
        if ListDataAnswerShow[indexPath.row] == ListDataAnswer[1]{
            cell.image_tich.isHidden = check
            cell.image_tich.image = UIImage(named: "tichv")
            }
        else{
            cell.image_tich.isHidden = check
            cell.image_tich.image = UIImage(named: "tichx")
           
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if solan > 0{
        switch indexPath.row {
        case indexPath.row:
            check = false
            Action_Text_Collection.reloadItems(at: [abc])
            solan = solan - 1
            if ListDataAnswer[1] == ListDataAnswerShow[indexPath.row]{
                
                btnNext.isHidden = false
                isPaused = false
                
                Action_Text_Collection.reloadItems(at: [indexPath])
            }
            else{
                btnNext.isHidden = false
                isPaused = false
                Action_Text_Collection.reloadItems(at: [indexPath])
            }
           
        default:
            print("default")
        }
    }
    }
    
    @IBAction func btnNext(_ sender: Any) {
        causo = causo + 1
        isPaused = true
        number = number + 1
        check = true
        solan = 1
        if causo <= nextsceen - 1{
            ListDataAnswer = []
            ListDataAnswerShow = []
            btnNext.isHidden = true
            runCount = 0
            phantram = 1.00
            percent.text = "100%"
            Action_Text_Collection.reloadData()
        }
        else{
            causo = 0
            Level_Service.shared.update(level: Int(ID) ) { _,_ in}
            
            print("level \(level)")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
            vc.navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true)
        }
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PlayViewController") as! PlayViewController
        vc.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .overFullScreen
        
        
        self.present(vc, animated: true)
    }
    
}
extension Action_TextViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (UIDevice.current.userInterfaceIdiom == .pad){
            let yourWidth = view.frame.width/1.3
            let yourHeight = collectionView.bounds.height/6
            return CGSize(width: yourWidth, height: yourHeight)
        }
        else if (UIDevice.current.userInterfaceIdiom == .phone){
            let yourWidth = collectionView.bounds.width/1.5
            let yourHeight = collectionView.bounds.height/7
            return CGSize(width: yourWidth, height: yourHeight)
        }
        else {
            let yourWidth = view.frame.width/1.2
            let yourHeight = collectionView.bounds.height/2.4
            return CGSize(width: yourWidth, height: yourHeight)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)
    }
}

extension Double {
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

