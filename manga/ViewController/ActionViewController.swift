//
//  ActionViewController.swift
//  manga
//
//  Created by Apple on 05/09/2021.
//

import UIKit
import SQLite3
import SQLite.Swift
class ActionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var causo:Int = 0
    var indexCauHoi = 0
    var level:String!
    var nextsceen:Int!
    var ListData:[Model_qus_text] = [Model_qus_text]()
    var ListDataprocess:[Model_qus_text] = [Model_qus_text]()
    var ListDataAnswer:[UIImage] = []
    var ListDataAnswerShow:[UIImage] = []
    var runCount:Float = 0
    var phantramshow:Float!
    var phantram:Float = 1.00
    var suff:[Int] = []
    var suff12:[Int] = []
    var solan:Int = 1
    var ID:Int!
    @IBOutlet weak var numberofques: UILabel!
    var abc:IndexPath!
    @IBOutlet weak var Ans_Image_Collection: UICollectionView!
    var vitri:Int = 0
    
    
    @IBOutlet weak var khoangcach: NSLayoutConstraint!
    
    @IBOutlet weak var khoangcachphai: NSLayoutConstraint!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var ViewQuestion: UIView!
    @IBOutlet weak var TimeBlue: UIView!
    @IBOutlet weak var ViewBlue: UIView!
    @IBOutlet weak var Blue: NSLayoutConstraint!
    var isPaused = true
    @IBOutlet weak var percent: UILabel!
    var timer = Timer()
    @IBOutlet weak var QuestionText: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var ViewCollection: UIView!
    var check:Bool = true
    var checkrepeat:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        Ques_text_Service.shared.getData(){ [self] repond,error in
                 if let repond = repond{
                     self.ListData = repond
                     self.Ans_Image_Collection.reloadData()
                    }
                }
        let nib = UINib(nibName: "ActionCollectionViewCell", bundle: nil)
        Ans_Image_Collection.register(nib, forCellWithReuseIdentifier: "ActionCollectionViewCell")
        Ans_Image_Collection.delegate = self
        Ans_Image_Collection.dataSource = self
        Ans_Image_Collection.backgroundColor = .clear
        ViewCollection.backgroundColor = .clear
        btnNext.isHidden = true
        
        //
        for item in ListData{
            if item.level == level{
                ListDataprocess.append(item)
            }
            print("ListDataprocess.count \(ListDataprocess.count)")
           
        }
        
        
        nextsceen = ListDataprocess.count
//        ListDataAnswerShow = ListDataAnswer.shuffled()

        ViewQuestion.backgroundColor = .clear
        ViewQuestion.layer.cornerRadius = 20
        ViewQuestion.layer.borderWidth = 1
        ViewQuestion.layer.borderColor = UIColor.white.cgColor
        
        TimeBlue.backgroundColor = .clear
        TimeBlue.layer.cornerRadius = 20
        TimeBlue.layer.borderWidth = 1
        TimeBlue.layer.borderColor = UIColor.white.cgColor
        ViewBlue.backgroundColor = .blue
        ViewBlue.layer.cornerRadius = 20
        //
        percent.textColor = .white
        //
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.timegiam), userInfo: nil, repeats: true)
        //
        if (UIDevice.current.userInterfaceIdiom == .pad){
            khoangcach.constant = 40
            khoangcachphai.constant = 40
        }
        
        // Do any additional setup after loading the view.
        btnBack.titleLabel?.font = UIFont(name:"Times New Roman", size: 30)
        btnNext.titleLabel?.font = UIFont(name:"Times New Roman", size: 16)
        btnBack.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.69)
        btnNext.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.69)
        btnBack.clipsToBounds = true
        btnBack.layer.cornerRadius = 10
        btnNext.layer.cornerRadius = 10
        btnBack.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        btnNext.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        
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
            
            self.Blue.constant = self.TimeBlue.frame.width - self.TimeBlue.frame.width*CGFloat((15.0 - self.runCount)/15.0)
            

            if self.phantram > 50 {self.ViewBlue.backgroundColor = .blue}
            else if self.phantram <= 50 && self.phantram > 20{self.ViewBlue.backgroundColor = .yellow}
            else{self.ViewBlue.backgroundColor = .red}
            timedat()
            
        }
        else{
//            timer.invalidate()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
            let data1 = NSData(bytes:  ListDataprocess[causo].ans1.bytes, length: ListDataprocess[causo].ans1.bytes.count)
            if let image1 = UIImage(data: data1 as Data){
                ListDataAnswer.append(image1)
            }
            
            let data2 = NSData(bytes:  ListDataprocess[causo].ans2.bytes, length: ListDataprocess[causo].ans2.bytes.count)
            if let image2 = UIImage(data: data2 as Data){
                ListDataAnswer.append(image2)
            }
            
            let data3 = NSData(bytes:  ListDataprocess[causo].ans3.bytes, length: ListDataprocess[causo].ans3.bytes.count)
            if let image3 = UIImage(data: data3 as Data){
                ListDataAnswer.append(image3)
            }
            
            let data4 = NSData(bytes:  ListDataprocess[causo].ans4.bytes, length: ListDataprocess[causo].ans4.bytes.count)
            if let image4 = UIImage(data: data4 as Data){
                ListDataAnswer.append(image4)
            }
        let num = 0...3
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
        numberofques.text = "\(indexCauHoi+1)"+"/4"
        numberofques.textColor = .white
        QuestionText.text = ListDataprocess[causo].ques
        QuestionText.textColor = .white
        if (UIDevice.current.userInterfaceIdiom == .pad){
            QuestionText.font = UIFont(name:"Times New Roman", size: 30)
            percent.font = UIFont(name:"Times New Roman", size: 30)
            numberofques.font = UIFont(name:"Times New Roman", size: 30)
        }
        else if(UIDevice.current.userInterfaceIdiom == .phone){
            QuestionText.font = UIFont(name:"Times New Roman", size: 17)
            percent.font = UIFont(name:"Times New Roman", size: 17)
            numberofques.font = UIFont(name:"Times New Roman", size: 17)
        }
        else{
            QuestionText.font = UIFont(name:"Times New Roman", size: 30)
            percent.font = UIFont(name:"Times New Roman", size: 30)
            numberofques.font = UIFont(name:"Times New Roman", size: 30)
        }
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActionCollectionViewCell", for: indexPath as IndexPath) as! ActionCollectionViewCell
        let myColor = UIColor.white
        
        cell.Image_Ans.image = ListDataAnswerShow[indexPath.row]
        
        cell.ViewCell.backgroundColor = nil
        cell.ViewCell.layer.borderWidth = 2
        cell.ViewCell.layer.borderColor = myColor.cgColor
        cell.ViewCell.layer.cornerRadius = 20
        cell.Image_Ans.layer.cornerRadius = 20
        
        
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
    
    func timedat(){
        if phantram < 0{
            timer.invalidate()
            solan = solan - 1
            btnNext.isHidden = false
            checkrepeat = false
            isPaused = false
            check = false
            Ans_Image_Collection.shaking()
            Ans_Image_Collection.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if solan > 0{
        switch indexPath.row {
        case indexPath.row:
            check = false
            Ans_Image_Collection.reloadItems(at: [abc])
            solan = solan - 1
                if ListDataAnswer[1] == ListDataAnswerShow[indexPath.row]{
                    btnNext.isHidden = false
                    isPaused = false
                    Ans_Image_Collection.reloadItems(at: [indexPath])
                }
                else{
                    btnNext.isHidden = false
                    isPaused = false
                    Ans_Image_Collection.reloadItems(at: [indexPath])
                
            }
        default:
            print("")
        }
    }
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        indexCauHoi = indexCauHoi + 1
        isPaused = true
        check = true
        causo = 0
        causo = causo + 1
        ListDataAnswerShow = []
        solan = 1
        
        if indexCauHoi <= nextsceen - 1{
            ListDataAnswer = []
            ListDataAnswerShow = []
            btnNext.isHidden = true
            
            runCount = 0
            phantram = 1.00
            percent.text = "100%"
            Ans_Image_Collection.reloadData()
        }
        else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "Action_TextViewController") as! Action_TextViewController
            vc.navigationController?.pushViewController(vc, animated: false)
            vc.modalPresentationStyle = .overFullScreen
            vc.level = level
            vc.ID = ID
            vc.number = indexCauHoi
            self.present(vc, animated: false)
        }
        
    }
    
    
}


extension ActionViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (UIDevice.current.userInterfaceIdiom == .pad){
            let yourWidth = view.frame.width/3
            let yourHeight = collectionView.bounds.height/2.3
            return CGSize(width: yourWidth, height: yourHeight)
        }
        else if (UIDevice.current.userInterfaceIdiom == .phone){
            let yourWidth = collectionView.bounds.width/2.4
            let yourHeight = collectionView.bounds.height/2.5
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
