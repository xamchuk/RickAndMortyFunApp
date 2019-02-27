//
//  LoadingView.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 27/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    let nibName = String(describing: LoadingView.self)

    @IBOutlet var loadingView: UIView!

    @IBOutlet var loadingIndicator: UIActivityIndicatorView!


    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
   //     loadingIndicator.color = .black
        initFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromNib()
    }

    func initFromNib() {
        loadingView = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView
        addSubview(loadingView)
    }
}
