//
//  listTimeTable.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/02/15.
//

import UIKit
import RealmSwift

class listTimeTable: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let realm = try! Realm()
    
    var uswUser: Array<userTable> = []
    
    override func viewDidLoad() {

        navigationBarHidden()
        navigationBackSwipeMotion()
        readData()
        print("viewdidload")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBarHidden()
        navigationBackSwipeMotion()
        readData()
    }
    
    func readData(){
        uswUser.removeAll()
        let userDB = realm.objects(userDB.self)
        for i in 0...userDB.count-1{
            var readData = userTable(year: userDB[i].year , semester: userDB[i].semester, timetableName: userDB[i].timetableName)
            uswUser.append(readData)
            tableView?.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uswUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! timetableCell
        myCell.nameTxtField.text = uswUser[indexPath.row].timetableName
        myCell.yearTxtField.text = "\(uswUser[indexPath.row].year)년"
        myCell.semeTxtField.text = "\(uswUser[indexPath.row].semester)학기"
        myCell.delBtn.tag = indexPath.row
        myCell.delBtn.addTarget(self, action: #selector(btnaction), for: .touchUpInside)
        myCell.adBtn.tag = indexPath.row
        myCell.adBtn.addTarget(self, action: #selector(adjustBtnAction), for: .touchUpInside)
        
        myCell.selectionStyle = .none

        
        return myCell
    }
    
    @objc func adjustBtnAction(sender: UIButton){
        
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let myCell = uswUser[indexPath.row].timetableName
        // alert 쓸 필요 없을듯
        let adjustDB = realm.objects(userDB.self)
        
        let adjustIndex: Int = uswUser.firstIndex(where: { $0.timetableName == myCell}) ?? 0
        print(adjustIndex)
        
        
        let popVC = storyboard?.instantiateViewController(withIdentifier: "popVC") as! popUpViewController
        popVC.arrayIndex = adjustIndex
        popVC.timetableName = adjustDB[adjustIndex].timetableName
        popVC.semester = adjustDB[adjustIndex].semester
        popVC.year = adjustDB[adjustIndex].year
        popVC.modalPresentationStyle = .fullScreen
        
        self.present(popVC, animated: true, completion: nil)
        
        

        
        
        // 인덱스 뽑아오면 ? 그 인덱스 값대로 수정해주는 로직
        // 내일 할 일 --> 수정 버튼 누를 시 배열 수정 and 데이터베이스값 수정해주는 작업하면 끝 - > 메인화면 생성
        // uswUser[1].semester
    }
    
    @objc func btnaction(sender: UIButton)
    {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let myCell = uswUser[indexPath.row].timetableName
        
        let deleteDB = realm.objects(userDB.self).filter("timetableName == %s", myCell)
        
        let removeAlert = UIAlertController(title: myCell, message: "삭제 하시겠어요?", preferredStyle: UIAlertController.Style.alert)
        
        let deleteButton = UIAlertAction(title: "삭제", style: .destructive, handler: { [self] (action) -> Void in
            uswUser.removeAll(where: { $0.timetableName == "\(myCell)"})
            print("Delete button tapped")
            
            for mydata in deleteDB{
            try! realm.write{
                realm.delete(mydata)
                }
            }
            
            tableView.reloadData()
            tableView?.beginUpdates()
            tableView.endUpdates()
            
            UserDefaults.standard.removeObject(forKey: "name")
            
            if realm.objects(userDB.self).count > 0{
                UserDefaults.standard.set(uswUser[0].timetableName, forKey: "name")
            } else {
                let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "showVC") as! showTimeTable
                self.navigationController?.pushViewController(firstVC, animated: true)
            }
        })
        
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        removeAlert.addAction(deleteButton)
        removeAlert.addAction(cancelButton)
        self.navigationController!.present(removeAlert, animated: true, completion: nil)
        
    }

    
    @IBAction func homeBtnClicked(_ sender: Any) {
        let showVC = self.storyboard?.instantiateViewController(withIdentifier: "showVC") as! showTimeTable
        self.navigationController?.pushViewController(showVC, animated: true)
    }
    @IBAction func addTimeTable(_ sender: Any) {
        let makeVC = self.storyboard?.instantiateViewController(withIdentifier: "makeVC") as! uswMakeSchedule
        self.navigationController?.pushViewController(makeVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showVC = self.storyboard?.instantiateViewController(withIdentifier: "showVC") as! showTimeTable
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.set(uswUser[indexPath.row].timetableName, forKey: "name")
        self.navigationController?.pushViewController(showVC, animated: true)
    }
    
   
 
    func navigationBarHidden() {
            self.navigationController?.navigationBar.isHidden = true
        }
    
    func navigationBackSwipeMotion() {
           self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
       }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class timetableCell: UITableViewCell {

    @IBOutlet weak var adBtn: UIButton!
    @IBOutlet weak var delBtn: UIButton!
    @IBOutlet weak var yearTxtField: UILabel!
    @IBOutlet weak var semeTxtField: UILabel!
    @IBOutlet weak var nameTxtField: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 12.0
}
    
    
}
