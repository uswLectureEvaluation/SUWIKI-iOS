//
//  writtenExamPostCell.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/12.
//

import UIKit

class writtenExamPostCell: UITableViewCell {

    @IBOutlet weak var semesterLabel: UILabel!
    @IBOutlet weak var examTypeLabel: UILabel!
    
    @IBOutlet weak var lectureNameLabel: UILabel!
    @IBOutlet weak var professorLabel: UILabel!
    @IBOutlet weak var majorTypeLabel: UILabel!
    
    @IBOutlet weak var examInfoLabel: UILabel!
    @IBOutlet weak var examDifficultyLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var adBtn: UIButton!
    @IBOutlet weak var delBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 8.0
        // Initialization code
    }

    override func layoutSubviews() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
