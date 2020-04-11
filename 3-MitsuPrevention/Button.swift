//
//  Button.swift
//  3-MitsuPrevention
//
//  Created by 吉川椛 on 2020/04/10.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class Button: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel?.font = UIFont(name: "Avenir", size: 12)
    }
}
