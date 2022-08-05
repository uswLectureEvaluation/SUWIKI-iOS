//
//  uswMakeSchedule.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/01/07.
//

import UIKit
import DropDown
import RealmSwift
import GoogleMobileAds


class uswMakeSchedule: UIViewController, UITextFieldDelegate {
    let realm = try! Realm()
    
    var nameCheck = [String]()
    
    
    @IBOutlet weak var yearDropdown: UIView!
    @IBOutlet weak var yearTxtField: UILabel!
    @IBOutlet weak var semeDropdown: UIView!
    @IBOutlet weak var semeTxtField: UILabel!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet weak var test2: UITextField!
    @IBOutlet weak var test: UITextField!
    let dropDown1 = DropDown()
    let dropDown2 = DropDown()
    
    let yearList = ["2022","2023","2024"]
    let semeList = ["1", "2"]
    
    override func viewDidLoad() {
        nameTxtField.delegate = self
        super.viewDidLoad()
        readName()
        navigationBarHidden()
        navigationBackSwipeMotion()
        
        bannerView.adUnitID = "ca-app-pub-8919128352699409/3950816041"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        
        dropDown1.anchorView = yearDropdown
        dropDown1.dataSource = yearList
        dropDown1.bottomOffset = CGPoint(x: 0, y:(dropDown1.anchorView?.plainView.bounds.height)!)
        dropDown1.direction = .bottom
        dropDown1.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.yearTxtField.text = yearList[index]
            self.yearTxtField.font = UIFont(name: "system", size: 17)
            self.yearTxtField.textColor = .black
            self.yearTxtField.textAlignment = .center
                                            
        }
        dropDown2.anchorView = semeDropdown
        dropDown2.dataSource = semeList
        dropDown2.bottomOffset = CGPoint(x: 0, y:(dropDown2.anchorView?.plainView.bounds.height)!)
        dropDown2.direction = .bottom
        dropDown2.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.semeTxtField.text = semeList[index]
            self.semeTxtField.font = UIFont(name: "system", size: 17)
            self.semeTxtField.textColor = .black
            self.semeTxtField.textAlignment = .center
        }
        
        
    }

    @IBAction func finishBtnClicked(_ sender: Any) {
        if nameTxtField.text == "" {
            let alert = UIAlertController(title:"시간표 이름을 알려주세요!",
                message: "확인을 눌러주세요!",
                preferredStyle: UIAlertController.Style.alert)
            //2. 확인 버튼 만들기
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            //3. 확인 버튼을 경고창에 추가하기
            alert.addAction(cancle)
            //4. 경고창 보이기
            present(alert,animated: true,completion: nil)
        } else if nameTxtField.text?.contains(" ") == true{
            let alert = UIAlertController(title:"시간표 이름에 띄어쓰기가 있네요!",
                message: "확인을 눌러주세요!",
                preferredStyle: UIAlertController.Style.alert)
            //2. 확인 버튼 만들기
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            //3. 확인 버튼을 경고창에 추가하기
            alert.addAction(cancle)
            //4. 경고창 보이기
            present(alert,animated: true,completion: nil)
        } else if nameCheck.contains(nameTxtField.text!) {
            let alert = UIAlertController(title:"이미 같은 이름이 있어요!",
                message: "시간표 이름을 바꿔주세요!",
                preferredStyle: UIAlertController.Style.alert)
            //2. 확인 버튼 만들기
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            //3. 확인 버튼을 경고창에 추가하기
            alert.addAction(cancle)
            //4. 경고창 보이기
            present(alert,animated: true,completion: nil)
            
        }
        else {
            UserDefaults.standard.set(nameTxtField.text!, forKey: "name")
            UserDefaults.standard.synchronize()
            let showVC = self.storyboard?.instantiateViewController(withIdentifier: "showVC") as! showTimeTable
            showVC.timeTableName = nameTxtField.text!
            self.navigationController?.pushViewController(showVC, animated: true)
            save()
            print(Realm.Configuration.defaultConfiguration.fileURL!)
        }
    }
    @IBAction func yearBtnClicked(_ sender: Any) {
        dropDown1.show()
    }
    
    @IBAction func semeBtnClicekd(_ sender: Any) {
        dropDown2.show()
    }
  
    func save(){
        realm.beginWrite()
        let userData = userDB()
        var userCnt = realm.objects(userDB.self).count
        userData.tableCnt = userCnt
        userData.year = yearTxtField.text!
        userData.semester = semeTxtField.text!
        userData.timetableName = nameTxtField.text!
        realm.add(userData)
        try! realm.commitWrite()
    }
    
    func readName(){
        let name = realm.objects(userDB.self)
        for i in 0..<name.count{
            var appName = name[i].timetableName
            nameCheck.append(appName)
        }
        
    }
    
    func navigationBarHidden() {
            self.navigationController?.navigationBar.isHidden = true
        }
    
    func navigationBackSwipeMotion() {
           self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
       }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 

    
        let maxLength = 10
        let currentString: NSString = (nameTxtField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
         
    }
}

extension String{
    func hasCharacters() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9_]$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) { return true }
            
        } catch {
            return false
        }
        return false
    }

}


