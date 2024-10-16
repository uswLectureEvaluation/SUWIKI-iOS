//
//  TimetableListCell.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/30.
//

import UIKit

import Reusable
import SnapKit

class TimetableListCell: UITableViewCell, Reusable {

  private let semesterLabel = UILabel().then {
    $0.textColor = .black
    $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
  }

  private let titleLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    $0.textColor = .darkGray
  }

  private let removeButton = UIButton().then {
    $0.setImage(UIImage(systemName: "trash"), for: .normal)
    $0.tintColor = .red
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override init(
    style: UITableViewCell.CellStyle,
    reuseIdentifier: String?
  ) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUI()
    setLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setUI() {
    [
      semesterLabel,
      titleLabel,
      removeButton
    ].forEach {
      contentView.addSubview($0)
    }
  }

  private func setLayout() {
    semesterLabel.snp.makeConstraints {
      $0.top.equalTo(contentView.snp.top).offset(16)
      $0.leading.equalTo(contentView.snp.leading).offset(16)
      $0.height.equalTo(22)
    }
    removeButton.snp.makeConstraints {
      $0.centerY.equalTo(contentView.snp.centerY)
      $0.trailing.equalTo(contentView.snp.trailing).offset(-12)
      $0.height.equalTo(22)
    }
    titleLabel.snp.makeConstraints {
      $0.bottom.equalTo(contentView.snp.bottom).offset(-12)
      $0.leading.equalTo(contentView.snp.leading).offset(16)
      $0.trailing.lessThanOrEqualTo(removeButton.snp.leading).offset(-12)
      $0.height.equalTo(22)
    }
  }

  func updateUI(
    semester: String,
    title: String,
    action: UIAction
  ) {
    semesterLabel.text = semester
    titleLabel.text = title
    removeButton.addAction(action, for: .touchUpInside)
  }
}
