
import UIKit
import izziGradient

final class Cell: UITableViewCell {
    private let cellStack = UIStackView()
    private let cellBg = UIImageView()
    private let cellTitle = UILabel()
    private let cellBottomStack = UIStackView()
    private let authorLabel = UILabel()
    private let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        
        setupCellBackground()
        setupCellView()
        addGradient()
        
        setupCellTitle()
        setupCellBottomStack()
        setupBottomLabels()
    }
    
    private func setupCellBackground() {
        contentView.addSubview(cellBg)
        
        cellBg.configureImgBasicSettings()
        
        NSLayoutConstraint.activate([
            cellBg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            cellBg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            cellBg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            cellBg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupCellView() {
        contentView.addSubview(cellStack)
        
        cellStack.translatesAutoresizingMaskIntoConstraints = false
        cellStack.isLayoutMarginsRelativeArrangement = true
        cellStack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        cellStack.axis = .vertical
        cellStack.distribution = .equalCentering
        
        NSLayoutConstraint.activate([
            cellStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupCellTitle() {
        cellStack.addArrangedSubview(cellTitle)
        
        cellTitle.configureNunitoLabels(text: "FBI Arrests Man Who Searched ‘How Can I Know for Sure If I Am Being Investigated by the FBI", fontName: "Nunito-Bold", color: .white, size: 12)
        cellTitle.numberOfLines = 0
    }
    
    private func setupCellBottomStack() {
        cellStack.addArrangedSubview(cellBottomStack)
        
        cellBottomStack.translatesAutoresizingMaskIntoConstraints = false
        cellBottomStack.axis = .horizontal
        cellBottomStack.distribution = .equalCentering
    }
    
    private func setupBottomLabels() {
        cellBottomStack.addArrangedSubview(authorLabel)
        cellBottomStack.addArrangedSubview(dateLabel)
    }
    
    private func addGradient(){
        
        let gradientView = IzziLinearGradient()
        gradientView.gradientColors = [.gradientFirst, .black]
        gradientView.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientView.startPoint = CGPoint(x: 0.0, y: 0.1)
        
        cellStack.insertSubview(gradientView, at: 0)
        
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.clipsToBounds = true
        gradientView.layer.cornerRadius = cellBg.layer.cornerRadius
        gradientView.layer.opacity = 0.6
        
        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: cellStack.leadingAnchor),
            gradientView.topAnchor.constraint(equalTo: cellStack.topAnchor),
            gradientView.trailingAnchor.constraint(equalTo: cellStack.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: cellStack.bottomAnchor),
        ])
    }
    
    func configureCell(news: SinglePost) {
        self.dateLabel.configureNunitoLabels(text: news.publishedAt, fontName: "Nunito-SemiBold", color: .white, size: 12)
        self.cellTitle.configureNunitoLabels(text: news.title, fontName: "Nunito-Bold", color: .white, size: 12)
        self.authorLabel.configureNunitoLabels(text: news.author ?? "", fontName: "Nunito-SemiBold", color: .white, size: 12)
        
        if let urlString = news.urlToImage, let url = URL(string: urlString) {
            self.cellBg.imageFrom(url: url)
        } else {
            cellBg.image = UIImage(named: "bgImg")
        }
    }
}
