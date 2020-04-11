//
//  ButtonVideLarge.swift
//  3-MitsuPrevention
//
//  Created by 吉川椛 on 2020/04/10.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class BtnVideLarge: BtnVide {
    override func awakeFromNib() {
        super.awakeFromNib()
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
