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

    var stackView = UIStackView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        label.textColor = .white
        return label
    }()
    let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.callout)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        label.text = "N/A"
        return label
    }()
    let valueButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(#colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), for: .normal)
        return button
    }()

    func fetchData() {
        titleLabel.text = "\(detail.title):"
        if detail.isButton {
            let underlineAttribute: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.foregroundColor: UIColor.red]
            let underlineAttributedString = NSAttributedString(string: detail.value, attributes: underlineAttribute)
            valueButton.setAttributedTitle(underlineAttributedString, for: .normal)
            [titleLabel, valueButton].forEach({ stackView.addArrangedSubview($0)})
        } else {
            if detail.value != "" {
                valueLabel.text = detail.value
            }
            [titleLabel, valueLabel].forEach({ stackView.addArrangedSubview($0)})
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.1215686275, green: 0.1294117647, blue: 0.1411764706, alpha: 1)
        layer.cornerRadius = 10
        addSubview(stackView)
        stackView.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         padding: .init(top: 4, left: 8, bottom: 4, right: 8))
        stackView.axis = .horizontal
        stackView.spacing = 10
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
