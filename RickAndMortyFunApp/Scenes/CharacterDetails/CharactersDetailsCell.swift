//
//  CharactersDetailsCell.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/04/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class CharactersDetailsCell: UICollectionViewCell {

    var detail: CharacterDetails! {
        didSet {
           fetchData()
        }
    }
// MARK: - Views
    let stackView = UIStackView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return label
    }()

    let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.text = "N/A"
        return label
    }()
    let valueButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
// MARK: - Fetch Data
    func fetchData() {
        titleLabel.text = "\(detail.title):"
        if detail.isButton {
            valueButton.setTitle(detail.value, for: .normal)
            [titleLabel, valueButton].forEach({ stackView.addArrangedSubview($0)})
        } else {
            if detail.value != "" {
                valueLabel.text = detail.value
            }
            [titleLabel, valueLabel].forEach({ stackView.addArrangedSubview($0)})
        }
    }
// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Setup UI
    fileprivate func setupViews() {
        addSubview(stackView)
        stackView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         padding: .init(top: 4, left: 8, bottom: 4, right: 8))
        stackView.axis = .horizontal
        stackView.spacing = 10
        let seperatorView = UIView()
        seperatorView.backgroundColor = .gray
        addSubview(seperatorView)
        seperatorView.anchor(top: stackView.bottomAnchor,
                             leading: stackView.leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: stackView.trailingAnchor,
                             padding: .init(top: 14, left: 0, bottom: 0, right: 0),
                             size: .init(width: 0, height: 0.5))
    }
}
