//
//  detailExamCell.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/09.
//

import UIKit

class detailExamCell: UITableViewCell {

    
    @IBOutlet weak var semester: UILabel!
    @IBOutlet weak var examType: UILabel!
    @IBOutlet weak var examDifficulty: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var reportBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 8.0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
