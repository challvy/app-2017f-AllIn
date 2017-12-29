//
//  MenuTableViewCell.swift
//  AllIn
//
//  Created by apple on 2017/12/5.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    func configureForMenu(_ menu: MenuCell) {
        iconImageView.image = menu.image
        cellTitleLabel.text = menu.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.cellTitleLabel.textColor = UIColor(displayP3Red:96/256, green:96/256, blue:96/256, alpha:1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
