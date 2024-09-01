//
//  TimetableEmptyView.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/09/12.
//

import UIKit

class TimetableEmptyView: UIView {

  let topLabel: UILabel = {
    let label = UILabel()
    label.text = "아직 시간표가 없어요."
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 27, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let middleLabel: UILabel = {
    let label = UILabel()
    label.text = "새로운 시간표를 만들어보아요!"
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    label.textColor = .gray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  let addButton: UIButton = {
    let button = UIButton()
    button.setTitle("추가", for: UIControl.State())
    button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    button.tintColor = .white
    button.backgroundColor = .primaryColor
    button.layer.cornerRadius = 12
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()


  override init(frame: CGRect) {
    super.init(frame: frame)
    setStyle()
    setUI()
    setLayout()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setStyle() {
    backgroundColor = .white
    layer.cornerRadius = 12
  }

  private func setUI() {
    addSubview(topLabel)
    addSubview(middleLabel)
    addSubview(addButton)
  }

  private func setLayout() {
    addButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    addButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    addButton.widthAnchor.constraint(equalToConstant: 172).isActive = true
    addButton.heightAnchor.constraint(equalToConstant: 45).isActive = true

    middleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    middleLabel.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -6).isActive = true
    middleLabel.heightAnchor.constraint(equalToConstant: 38).isActive = true

    topLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    topLabel.bottomAnchor.constraint(equalTo: middleLabel.topAnchor).isActive = true
  }

  func updateUI(searchText: String) { }
}
