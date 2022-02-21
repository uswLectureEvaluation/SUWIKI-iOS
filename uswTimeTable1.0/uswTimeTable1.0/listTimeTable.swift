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
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func readData(){
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
        myCell.listView.layer.borderWidth = 1.0
        myCell.listView.layer.borderColor = UIColor.lightGray.cgColor
        myCell.listView.layer.cornerRadius = 12.0
        
        
        return myCell
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
                let firstVC = self.storyboard?.instantiateViewController(withIdentifier: "firstVC") as! firstSceneCheck
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

    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showVC = self.storyboard?.instantiateViewController(withIdentifier: "showVC") as! showTimeTable
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.set(uswUser[indexPath.row].timetableName, forKey: "name")
        print(UserDefaults.standard.string(forKey: "name"))
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

    @IBOutlet weak var delBtn: UIButton!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var yearTxtField: UILabel!
    @IBOutlet weak var semeTxtField: UILabel!
    @IBOutlet weak var nameTxtField: UILabel!
    
    
    
    
}
