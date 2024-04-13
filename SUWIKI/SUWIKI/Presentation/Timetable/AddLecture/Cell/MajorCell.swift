//
//  DepartmentCell.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/05/31.
//

import UIKit

import SnapKit
import Reusable

class MajorCell: UITableViewCell, Reusable {
    
    //MARK: UI
    
    let bookmarkButton = UIButton().then {
        $0.setImage(UIImage(systemName: "star"), for: .normal)
        $0.tintColor = .primaryColor
    }
    
    let majorLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        $0.textColor = .black
    }
    
    let countLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
    let chevronRight = UIImageView().then {
        $0.tintColor = .lightGray
        $0.image = UIImage(systemName: "chevron.right")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(bookmarkButton)
        contentView.addSubview(majorLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(chevronRight)
        
        bookmarkButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
        
        majorLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(52)
            $0.top.equalTo(self.contentView.snp.top).offset(16)
            $0.bottom.equalTo(self.contentView.snp.bottom).offset(-16)
        }
        
        countLabel.snp.makeConstraints {
            $0.leading.equalTo(majorLabel.snp.trailing).offset(4)
            $0.top.equalTo(self.contentView.snp.top).offset(17)
            $0.height.equalTo(22)
        }
        
        chevronRight.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    
