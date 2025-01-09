//
//  Untitled.swift
//  A3
//
//  Created by Archita Nemalikanti Nov 12th
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties (view)
    
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    private let logoImageView = UIImageView()
    
    private let messageLabel = UILabel()
    private let likeButton = UIButton()
    private let likesLabel = UILabel()
    
    static let reuse = "PostCollectionViewCell"
    
    private var postID: String?
    private var netID = "apn32"
    
    // MARK: - Init
    
    private var likeCount: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.a3.white
        layer.cornerRadius = 16
        
        setupNameLabel()
        setupDateLabel()
        setupLogoImageView()
        setupMessageLabel()
        setupLikeButton()
        setupLikesLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(with post: Post) {
        messageLabel.text = post.message
        dateLabel.text = post.time.convertToAgo()
        likesLabel.text = "\(post.likes.count) likes"
        
        postID = post.id
        if post.likes.contains(netID) {
            likeButton.tintColor = UIColor.a3.ruby
            likeButton.isEnabled = false
        } else {
            likeButton.tintColor = UIColor.a3.silver
            likeButton.isEnabled = true
        }
    }
    
    // MARK: - Set Up Views
    
    private func setupNameLabel() {
        nameLabel.text = "Anonymous"
        nameLabel.textColor = UIColor.a3.black
        nameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 64),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24.5)
        ])
    }
    
    private func setupDateLabel() {
        dateLabel.textColor = UIColor.a3.silver
        dateLabel.font = .systemFont(ofSize: 14)
        
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor)
        ])
    }
    
    private func setupLogoImageView() {
        logoImageView.image = UIImage(named: "logo")
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(logoImageView)
        
        let sidePadding: CGFloat = 24
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 32),
            logoImageView.heightAnchor.constraint(equalToConstant: 32),
            logoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: sidePadding),
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24)
        ])
    }
    
    private func setupMessageLabel() {
        messageLabel.textColor = UIColor.a3.black
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.numberOfLines = 0
        
        contentView.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor),
            messageLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 17)
        ])
    }
    
    private func setupLikeButton() {
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = UIColor.a3.silver
        likeButton.addTarget(self, action: #selector(likePostTapped), for: .touchUpInside)
        
        contentView.addSubview(likeButton)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            likeButton.leadingAnchor.constraint(equalTo: logoImageView.leadingAnchor),
            likeButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 80)
        ])
    }
    
    @objc private func likePostTapped() {
        guard let postID = postID, likeButton.tintColor != UIColor.a3.ruby else { return }
        
        NetworkManager.shared.likePost(postID: postID, netID: netID) { success in
            if success {
                self.likeButton.tintColor = UIColor.a3.ruby
                self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) // Change to filled heart icon
                self.likesLabel.text = "\(Int(self.likesLabel.text?.components(separatedBy: " ").first ?? "0")! + 1) likes"
                self.likeButton.isEnabled = false
                
                UIView.animate(withDuration: 0.1, animations: {
                    self.likeButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                }) { _ in
                    UIView.animate(withDuration: 0.1) {
                        self.likeButton.transform = CGAffineTransform.identity // Return to original size
                    }
                }
            } else {
                print("Failed to like the post.")
            }
        }
    }


    
    private func setupLikesLabel() {
        likesLabel.textColor = UIColor.a3.black
        likesLabel.font = .systemFont(ofSize: 14)
        
        contentView.addSubview(likesLabel)
        likesLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            likesLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 4),
            likesLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor)
        ])
    }
    
}
