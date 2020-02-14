//

import UIKit

protocol DictionaryTableDelegate {
    //func didAddnewRow(_ tag: Int)
    func didAddnewRow(_ sender: UIButton)
    func didDeleteRow(_ sender: UIButton)
}

class DictionaryTableViewCell: UITableViewCell {
        
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
  
    var delegate: DictionaryTableDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
        
        btnAdd.setTitle("Add", for: .normal)
        btnAdd.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 14.0)
        btnAdd.setTitleColor(.white, for: .normal)
        btnAdd.layer.cornerRadius = 5.0
        btnAdd.clipsToBounds = true
        
        btnDelete.setTitle("Delete", for: .normal)
        //btnDelete.frame = CGRect(x: self.contentView.frame.size.width - 70, y: 15, width: 75, height: 30)
        btnDelete.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 14.0)
        btnDelete.setTitleColor(.white, for: .normal)
        btnDelete.backgroundColor = .red
        btnDelete.layer.cornerRadius = 5.0
        btnDelete.clipsToBounds = true
        
        btnAdd.isHidden = false
        btnDelete.isHidden = true
        
        titleView.textColor = .black
        titleView.lineBreakMode = .byWordWrapping
        titleView.numberOfLines = 0
    }
    
    
    @IBAction func addClicked(_ sender: UIButton) {
        //delegate?.didAddnewRow(sender.tag)
        delegate?.didAddnewRow(sender)
    }
    
    @IBAction func deleteClicked(_ sender: UIButton) {
        delegate?.didDeleteRow(sender)
    }
    
    
}

