import UIKit

extension UITableView {
    
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "SFUIText-Bold", size: 20)
        titleLabel.text = title
        
        messageLabel.textColor = .lightGray
        messageLabel.font = UIFont(name: "SFUIText-Medium", size: 17)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        
        let titleLabelConstraints = [titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor)]
        
        let messageLabelConstraints = [messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10), messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20), messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20)]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(messageLabelConstraints)
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
