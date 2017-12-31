//
//  DigestTwoTableViewCell.swift
//  AllIn
//
//  Created by Apple on 2017/12/31.
//

import UIKit

class DigestBTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var digestImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        titleLabel.textColor = UIColor(displayP3Red:64/256, green:64/256, blue:64/256, alpha:1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
