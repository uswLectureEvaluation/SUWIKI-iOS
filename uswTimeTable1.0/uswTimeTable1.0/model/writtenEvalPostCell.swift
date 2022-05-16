//
//  writtenEvalPostCell.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/05/12.
//

import UIKit

class writtenEvalPostCell: UITableViewCell {

    @IBOutlet weak var semesterLabel: UILabel!
    @IBOutlet weak var lectureNameLabel: UILabel!
    @IBOutlet weak var professorLabel: UILabel!
    
    @IBOutlet weak var totalAvgLabel: UILabel!
    
    @IBOutlet weak var satisfactionLabel: UILabel!
    @IBOutlet weak var honeyLabel: UILabel!
    @IBOutlet weak var learningLabel: UILabel!
    
    
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var homeworkLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 8.0
    }
    
    override func layoutSubviews() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
