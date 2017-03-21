//
//  PacienteTableViewCell.swift
//  TVPS
//
//  Created by SOFTAM03 on 3/10/17.
//  Copyright © 2017 SOFTAM03. All rights reserved.
//

import UIKit

class PacienteTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
