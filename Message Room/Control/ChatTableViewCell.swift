//
//  ChatTableViewCell.swift
//  Message Room
//
//  Created by Ahmed Mamdouh on 08/11/2021.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var NameUser: UILabel!
    
    @IBOutlet weak var textChat: UITextView!
    
    @IBOutlet weak var stackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        textChat.layer.cornerRadius = textChat.frame.size.height / 10
        // Initialization code
    }

    enum buble {
        case incoming
        case outcoming
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func bubleChat(bb : buble) {
        if bb == .incoming {
            stackView.alignment = .trailing
            textChat.backgroundColor = .systemBlue
        }else if bb == .outcoming {
            stackView.alignment = .leading
            textChat.backgroundColor = .gray
        }
    }

}
