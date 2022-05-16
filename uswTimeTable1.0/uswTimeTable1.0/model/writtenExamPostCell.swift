//
//  writtenExamPostCell.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/12.
//

import UIKit

class writtenExamPostCell: UITableViewCell {

    @IBOutlet weak var semesterLabel: UILabel!
    
    @IBOutlet weak var lectureNameLabel: UILabel!
    @IBOutlet weak var professorLabel: UILabel!
    
    @IBOutlet weak var examInfoLabel: UILabel!
    @IBOutlet weak var examDifficultyLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
