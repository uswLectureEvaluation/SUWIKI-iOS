//
//  InitView.swift
//  SUWIKI
//
//  Created by 한지석 on 12/28/23.
//

import UIKit

import Common

import SnapKit
import Then

class InitView: UIView {

  let logoImage = UIImageView().then {
    $0.image = UIImage(systemName: "gear")
  }

  let activityIndicator = UIActivityIndicatorView().then {
    $0.hidesWhenStopped = true
    $0.startAnimating()
  }

  let statusDescriptionLabel = UILabel().then {
    $0.text = "시간표 버전을 확인하고 있습니다."
    $0.textAlignment = .center
    $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    $0.textColor = .darkGray
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setStyle()
    setUI()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setStyle() {
    self.backgroundColor = .white
  }

  private func setUI() {
    addSubview(logoImage)
    addSubview(activityIndicator)
    addSubview(statusDescriptionLabel)
  }
}
