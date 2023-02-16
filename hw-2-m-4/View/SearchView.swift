//
//  SearchView.swift
//  hw-2-m-4
//
//  Created by Kamila on 16/2/23.
//

import UIKit

class SearchView: UIView {
    
    @IBOutlet weak var magnifyingglassImageView: UIImageView!
    @IBOutlet weak var settingsImageView: UIImageView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchContainer: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let fileName = String(describing: SearchView.self)
        Bundle.main.loadNibNamed(fileName, owner: self)
        addSubview(searchContainer)
        searchContainer.frame = self.bounds
        searchContainer.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

