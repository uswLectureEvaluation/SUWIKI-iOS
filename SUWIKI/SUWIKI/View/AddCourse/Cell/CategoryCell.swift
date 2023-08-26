//
//  CategoryCell.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/02.
//

import UIKit

import SnapKit
import Then
import Reusable

class CategoryCell: UITableViewCell, Reusable {

    let categoryNameLabel = UILabel().then {
        $0.textColor = .black
    }
    let selectedLabel = UILabel().then {
        $0.textColor = .gray
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(categoryNameLabel)
        contentView.addSubview(selectedLabel)
        categoryNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.centerY.equalToSuperview()
        }
        selectedLabel.snp.makeConstraints {
            $0.trailing.equalTo(contentView.snp_trailingMargin)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
