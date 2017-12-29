//
//  SourceTableViewCell.swift
//  AllIn
//
//  Created by Apple on 2017/12/29.
//

import UIKit

class SourceTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceIconImageView: UIImageView!
    @IBOutlet weak var sourceTitleLabel: UILabel!
    
    func configureForMenu(_ menu: MenuCell) {
        sourceIconImageView.image = menu.image
        sourceTitleLabel.text = menu.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        //self.sourceTitleLabel.textColor = UIColor(displayP3Red:96/256, green:96/256, blue:96/256, alpha:1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
