//
//  NotificationCell.swift
//  witOrbit
//
//  Created by Gul Mehru on 2/7/18.
//  Copyright © 2018 Gul Mehru. All rights reserved.
//

import UIKit

class NotificationCell: VideoCell {
    
    
    override func setupViews() {
        addSubview(titleLabel)
        addSubview(subTitleView)
        addSubview(dateView)
        addConstraintsWithFormat(format: "V:|-20-[v0]-8-[v1]-8-[v2]", views: titleLabel, subTitleView, dateView)
        addConstraintsWithFormat(format: "H:|-20-[v0]", views: titleLabel)
        addConstraintsWithFormat(format: "H:|-20-[v0]", views: subTitleView)
        addConstraintsWithFormat(format: "H:|-20-[v0]", views: dateView)
    }
}
