//
//  uswMakeSchedule.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2021/12/31.
//

import UIKit

class uswMakeSchedule: UIViewController {
   
    @IBOutlet weak var buttonSwitch: UIButton!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var semeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    let yearList = ["2022", "2023", "2024"]
    let semeList = ["1", "2"]
    
    var yearPickerView = UIPickerView()
    var semePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        yearTextField.inputView = yearPickerView
        semeTextField.inputView = semePickerView
        yearTextField.placeholder = "20XX"
        semeTextField.placeholder = "X"
        
        yearTextField.textAlignment = .center
        semeTextField.textAlignment = .center
        
        yearPickerView.delegate = self
        yearPickerView.dataSource = self
        semePickerView.delegate = self
        semePickerView.dataSource = self
        
        yearPickerView.tag = 1
        semePickerView.tag = 2
    
        
    }
    
<<<<<<< HEAD
    @IBAction func makeBtnClicked(_ sender: Any) {
        UserDefaults.standard.bool(forKey: "makeS")
        let showVC = self.storyboard?.instantiateViewController(withIdentifier: "showVC") as! showTimeTable
        self.navigationController?.pushViewController(showVC, animated: true)
    }
    
     
    
=======
    
     
    @IBAction func buttonClicked(_ sender: Any) {
        UserDefaults.standard.setValue("true", forKey: "checkPage")
        let vc = storyboard?.instantiateViewController(withIdentifier: "uswMakeSchedule")
        navigationController?.pushViewController(vc!, animated: true)
    }
>>>>>>> 08467a317439c6856127195161d1aaf046ab3fc9
}

extension uswMakeSchedule: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return yearList.count
        case 2:
            return semeList.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag{
        case 1:
            return yearList[row]
        case 2:
            return semeList[row]
        default:
            return "데이터를 입력하세요."
        }
    }
    
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      switch pickerView.tag{
      case 1:
          yearTextField.text = yearList[row]
          yearTextField.resignFirstResponder()
      case 2:
          semeTextField.text = semeList[row]
          semeTextField.resignFirstResponder()
      default:
          return
      }
}


}
