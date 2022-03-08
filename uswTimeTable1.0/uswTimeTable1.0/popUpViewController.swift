//
//  popUpViewController.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/08.
//

import UIKit
import RealmSwift
import DropDown

class popUpViewController: UIViewController {

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
        if yearTxtField.text == "Year" || nameTxtField.text == "" || semeTxtField.text == "1 or 2"{
            let alert = UIAlertController(title:"비어 있는 데이터가 있어요!",
                message: "데이터를 다 알려주세요!",
                preferredStyle: UIAlertController.Style.alert)
            //2. 확인 버튼 만들기
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            //3. 확인 버튼을 경고창에 추가하기
            alert.addAction(cancle)
            //4. 경고창 보이기
            present(alert,animated: true,completion: nil)
        } else if nameCheck.contains(nameTxtField.text!) {
            let alert = UIAlertController(title:"비어 있는 데이터가 있어요!",
                message: "데이터를 다 알려주세요!",
                preferredStyle: UIAlertController.Style.alert)
            //2. 확인 버튼 만들기
            let cancle = UIAlertAction(title: "확인", style: .default, handler: nil)
            //3. 확인 버튼을 경고창에 추가하기
            alert.addAction(cancle)
            //4. 경고창 보이기
            present(alert,animated: true,completion: nil)
        } else {
            realm.beginWrite()
            let userData = realm.objects(userDB.self)
            userData[arrayIndex].year = yearTxtField.text ?? "2022"
            userData[arrayIndex].semester = semeTxtField.text ?? "1"
            userData[arrayIndex].timetableName = nameTxtField.text ?? "-"
            try! realm.commitWrite()
            let timeVC = self.storyboard?.instantiateViewController(withIdentifier: "timeVC") as! listTimeTable
            self.navigationController?.pushViewController(timeVC, animated: true)
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
    
    
    /*    // MARK: - Navigatio
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
