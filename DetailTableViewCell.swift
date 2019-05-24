//
//  DetailTableViewCell.swift
//  CHANN
//
//  Created by 陳豐文 on 2019/05/22.
//  Copyright © 2019 BooLuON. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var noteLabelText: UILabel!
    @IBOutlet weak var vocabLabelText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        vocabLabelText.lineBreakMode = .byClipping
        noteLabelText.lineBreakMode = .byClipping
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
