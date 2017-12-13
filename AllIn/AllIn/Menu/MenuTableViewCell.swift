//
//  MenuTableViewCell.swift
//  AllIn
//
//  Created by apple on 2017/12/5.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBInspectable @IBOutlet weak var iconImageView: UIImageView!
    @IBInspectable @IBOutlet weak var cellTitleLabel: UILabel!
    
    
    func configureForMenu(_ menu: MenuCell) {
        iconImageView.image = menu.image
        cellTitleLabel.text = menu.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.cellTitleLabel.textColor = UIColor(displayP3Red:64/256, green:64/256, blue:64/256, alpha:1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
