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
    
    var userYear = [String]()
    var userSeme = [String]()
    var userName = [String]()
    
    override func viewDidLoad() {
        readData()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func readData(){
        let userDB = realm.objects(userDB.self)
        var readYear = String()
        var readSeme = String()
        var readName = String()
        for i in 0...userDB.count-1{
            readYear = userDB[i].year
            readSeme = userDB[i].semester
            readName = userDB[i].timetableName
            userYear.append(readYear)
            userSeme.append(readSeme)
            userName.append(readName)
            tableView?.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userYear.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! timetableCell
        myCell.nameTxtField.text = userName[indexPath.row]
        myCell.yearTxtField.text = "\(userYear[indexPath.row])년"
        myCell.semeTxtField.text = "\(userSeme[indexPath.row])학기"
        myCell.listView.layer.borderWidth = 1.0
        myCell.listView.layer.borderColor = UIColor.lightGray.cgColor
        myCell.listView.layer.cornerRadius = 12.0
        return myCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showVC = self.storyboard?.instantiateViewController(withIdentifier: "showVC") as! showTimeTable
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.set(userName[indexPath.row], forKey: "name")
        print(UserDefaults.standard.string(forKey: "name"))
        self.navigationController?.pushViewController(showVC, animated: true)
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
    
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var yearTxtField: UILabel!
    @IBOutlet weak var semeTxtField: UILabel!
    @IBOutlet weak var nameTxtField: UILabel!
    
}
