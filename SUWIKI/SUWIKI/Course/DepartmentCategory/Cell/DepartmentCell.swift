//
//  DepartmentCell.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/05/31.
//

import UIKit

import SnapKit
import Reusable

class DepartmentCell: UITableViewCell, Reusable {
    
    static let reuseIdentifier: String = "DepartmentCell"
    
    let justLabel = UILabel().then {
        $0.textColor = .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(justLabel)
        
        justLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    
