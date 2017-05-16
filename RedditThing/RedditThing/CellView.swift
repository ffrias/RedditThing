//
//  Cell.swift
//  RedditThing
//
//  Created by Alejandro Santander on 1/19/17.
//  Copyright © 2017 Alejandro Santander. All rights reserved.
//

import UIKit

class CellView: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var favoriteSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func loadData(title:String, author:String, isFavorite:Bool) {
        titleLabel.text = title;
        authorLabel.text = author;
        favoriteSwitch.setOn(isFavorite, animated: false)
    }
    
    func getIsFavoriteSwitchOn() -> Bool {
        return favoriteSwitch.isOn
    }
    
    @IBAction func onSwitchChanged(_ sender: UISwitch) {
        print("changed \(sender.isOn)")
    }
}
