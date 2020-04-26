//
//  matrixCell.swift
//  Find determinant app
//
//  Created by Евгений Испольнов on 24.04.2020.
//  Copyright © 2020 Евгений Испольнов. All rights reserved.
//

import UIKit

class MatrixCell: UICollectionViewCell {
    @IBOutlet private weak var valueLabel: UILabel!
    
    func setText(text: String) {
        valueLabel.text = text
    }
    
    override func awakeFromNib() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
}
