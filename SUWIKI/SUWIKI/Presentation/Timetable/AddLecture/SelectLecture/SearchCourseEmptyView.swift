//
//  SearchCourseEmptyView.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/18.
//

import UIKit

class SearchCourseEmptyView: UIView {
    
    //MARK: UI
    
    let searchTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "검색결과가 없습니다."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(searchTextLabel)
        searchTextLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        searchTextLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        if let glassImage = UIImage(named: "glass") {
            let glassImageView = UIImageView(image: glassImage)
            glassImageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(glassImageView)
            glassImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            glassImageView.bottomAnchor.constraint(equalTo: searchTextLabel.topAnchor, constant: -16).isActive = true
            glassImageView.widthAnchor.constraint(equalToConstant: 125).isActive = true
            glassImageView.heightAnchor.constraint(equalToConstant: 125).isActive = true
        }
        
        addSubview(resultLabel)
        resultLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        resultLabel.topAnchor.constraint(equalTo: searchTextLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    func updateUI(searchText: String) {
        self.searchTextLabel.text = searchText
    }

}
