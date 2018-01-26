//
//  TableViewCell.swift
//  65apps-1
//
//  Created by Garafutdinov Ravil on 23/01/2018.
//  Copyright © 2018 RG. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        self.imageView?.image = UIImage(named: "pic")
    }

    override func prepareForReuse() {
        self.imageView?.image = UIImage(named: "pic")
    }
}
