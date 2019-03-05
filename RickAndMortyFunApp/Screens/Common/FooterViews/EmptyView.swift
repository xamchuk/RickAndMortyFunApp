//
//  emptyView.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 27/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class EmptyView: UIView {

    @IBOutlet var emptyView: UIView!
    let nibName = String(describing: EmptyView.self)

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        initFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromNib()
    }

    func initFromNib() {
        emptyView = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView
        addSubview(emptyView)
    }

}
