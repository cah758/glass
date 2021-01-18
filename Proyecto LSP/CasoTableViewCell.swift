//
//  CasoTableViewCell.swift
//  Proyecto LSP
//
//  Created by Bruno on 01/12/2020.
//  Copyright © 2020 Cristian Alvarez hossein. All rights reserved.
//

import UIKit

class CasoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nombreCasoLbl: UILabel!
    
    @IBOutlet weak var estadoCasoImg: UIImageView!

    @IBOutlet weak var fechaDelCasoLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
