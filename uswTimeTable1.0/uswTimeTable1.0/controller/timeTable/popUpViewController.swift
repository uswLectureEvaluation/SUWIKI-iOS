//
//  popUpViewController.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/08.
//

import UIKit
import RealmSwift
import DropDown

class popUpViewController: UIViewController, UITextFieldDelegate {

    let realm = try! Realm()
    
    @IBOutlet weak var yearView: UIView!
    @IBOutlet weak var semeView: UIView!
    @IBOutlet weak var table: UILabel!
    @IBOutlet weak var yearTxtField: UILabel!
    @IBOutlet weak var semeTxtField: UILabel!
    @IBOutlet weak var nameTxtField: UITextField!
    var nameCheck = [String]()
    let yearDropDown = DropDown()
    let semeDropDown = DropDown()
    
    var timetableName = ""
    var semester = ""
    var year = ""
    var arrayIndex = 0

    let yearList = ["2022","2023","2024"]
    let semeList = ["1", "2"]
    
    override func viewDidLoad() {
        nameTxtField.delegate = self
        super.viewDidLoad()
        readName()
        yearDropDown.anchorView = yearView
        yearDropDown.dataSource = yearList
        yearDropDown.bottomOffset = CGPoint(x: 0, y:(yearDropDown.anchorView?.plainView.bounds.height)!)
        yearDropDown.direction = .bottom
        yearDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.yearTxtField.text = yearList[index]
            self.yearTxtField.font = UIFont(name: "system", size: 17)
            self.yearTxtField.textColor = .black
            self.yearTxtField.textAlignment = .center
                                            
        }
        
        semeDropDown.anchorView = semeView
        semeDropDown.dataSource = semeList
        semeDropDown.bottomOffset = CGPoint(x: 0, y:(semeDropDown.anchorView?.plainView.bounds.height)!)
        semeDropDown.direction = .bottom
        semeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.semeTxtField.text = semeList[index]
            self.semeTxtField.font = UIFont(name: "system", size: 17)
            self.semeTxtField.textColor = .black
            self.semeTxtField.textAlignment = .center
                                            
        }
        
    }
    
    @IBAction func yearBtnClicked(_ sender: Any) {
        yearDropDown.show()
    }
    
    @IBAction func semeBtnClicked(_ sender: Any) {
        semeDropDown.show()
    }
    
    
    
    @IBAction func finishBtnClicked(_ sender: Any) {
        if nameTxtField.text == ""{
            let alert = UIAlertController(title:"시간표 이름을 적어주세요!",
                message: "확인을 눌러주세요!",
                preferredStyle: UIAlertController.Style.alert)
            //2. 확인 버튼 만들기
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            //3. 확인 버튼을 경고창에 추가하기
            alert.addAction(cancle)
            //4. 경고창 보이기
            present(alert,animated: true,completion: nil)
        } else if nameTxtField.text?.contains(" ") == true {
            let alert = UIAlertController(title:"시간표 이름에 띄어쓰기가 있네요!",
                message: "확인을 눌러주세요!",
                preferredStyle: UIAlertController.Style.alert)
            //2. 확인 버튼 만들기
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            //3. 확인 버튼을 경고창에 추가하기
            alert.addAction(cancle)
            //4. 경고창 보이기
            present(alert, animated: true,completion: nil)
        } else if nameCheck.contains(nameTxtField.text!) {
            let alert = UIAlertController(title:"이름이 중복되었어요!",
                message: "이름을 바꿔주세요!",
                preferredStyle: UIAlertController.Style.alert)
            //2. 확인 버튼 만들기
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            //3. 확인 버튼을 경고창에 추가하기
            alert.addAction(cancle)
            //4. 경고창 보이기
            present(alert, animated: true,completion: nil)
        } else {
            realm.beginWrite()
            let userData = realm.objects(userDB.self)
            userData[arrayIndex].year = yearTxtField.text ?? "2022"
            userData[arrayIndex].semester = semeTxtField.text ?? "1"
            userData[arrayIndex].timetableName = nameTxtField.text ?? "-"
            UserDefaults.standard.removeObject(forKey: "name")
            UserDefaults.standard.set(nameTxtField.text, forKey: "name")

            try! realm.commitWrite()

            self.dismiss(animated: true, completion: nil)
        }
        
        
    }

    func readName(){
        let name = realm.objects(userDB.self)
        for i in 0..<name.count{
            if name[i].timetableName != timetableName{
                var appName = name[i].timetableName
                nameCheck.append(appName)
                
            }
            
        }
        
    }
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 

    
        let maxLength = 10
        let currentString: NSString = (nameTxtField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
         
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

          self.view.endEditing(true)

    }


}
