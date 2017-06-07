//
//  StudentCell.swift
//  RxDemo
//
//  Created by redtwowolf on 05/06/2017.
//

import UIKit

class StudentCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(_ model: Student) {
        nameLabel.text = model.name
        ageLabel.text = "\(model.age ?? 0)"
    }
    
}
