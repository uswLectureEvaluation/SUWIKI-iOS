//
//  moveViewController.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/11.
//

import UIKit
import RealmSwift

class moveViewController: UIViewController {
    let realm = try! Realm()
    
    @IBOutlet weak var loadingGif: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkUserData()
        let loadGif = UIImage.gifImageWithName("loading")
        loadingGif.image = loadGif
    }
    
    func checkUserData(){
        let userData = realm.objects(userDB.self).count
        if userData > 0 {
            let showVC = self.storyboard?.instantiateViewController(withIdentifier: "showVC") as! showTimeTable
            self.navigationController?.pushViewController(showVC, animated: true)
        } else {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "firstVC") as! firstSceneCheck
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
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
