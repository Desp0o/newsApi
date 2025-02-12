import UIKit

final class DetailsVC: UIViewController {
    private let news: SinglePost
    private let navigationStack = UIStackView()
    private let backButton = UIButton()
    private let screenTitle = UILabel()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let newsTitle = UILabel()
    private let dateLabel = UILabel()
    private let newsPoster = UIImageView()
    private let newsDescription = UILabel()
    private let authorLabel = UILabel()
    
    init(news: SinglePost) {
        self.news = news
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.preservesSuperviewLayoutMargins = true
        view.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        setupNavigation()
        setupScrollView()
        setupContentView()
        setupNewsTitle()
        setupDateLabel()
        setupNewsPoster()
        setupNewsDescription()
        setupAuthorLabels()
    }
    
    private func setupNavigation() {
        view.addSubview(navigationStack)
        navigationStack.translatesAutoresizingMaskIntoConstraints = false
        navigationStack.axis = .horizontal
        navigationStack.distribution = .fillProportionally
        navigationStack.spacing = 123
        
        NSLayoutConstraint.activate([
            navigationStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            navigationStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            navigationStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
        
        setupBackButton()
        setupScreenTitle()
    }
    
    private func setupBackButton() {
        navigationStack.addArrangedSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named: "backArrow"), for: .normal)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: navigationStack.leadingAnchor, constant: 0)
        ])
        
        backButton.addAction(UIAction(handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
    }
    
    private func setupScreenTitle() {
        navigationStack.addArrangedSubview(screenTitle)
        screenTitle.configureScreenTitle(text: "Hot Updates", size: 17)
        
        NSLayoutConstraint.activate([
            screenTitle.centerYAnchor.constraint(equalTo: navigationStack.centerYAnchor)
        ])
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: navigationStack.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupNewsTitle() {
        contentView.addSubview(newsTitle)
        newsTitle.configureNunitoLabels(text: news.title, fontName: "Nunito-SemiBold", color: .black, size: 16)
        newsTitle.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            newsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsTitle.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
  
    private func setupDateLabel() {
        contentView.addSubview(dateLabel)
        
        dateLabel.configureNunitoLabels(text: news.publishedAt, fontName: "Nunito-Regular", color: .customBrown, size: 12)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
    private func setupNewsPoster() {
        contentView.addSubview(newsPoster)
        newsPoster.translatesAutoresizingMaskIntoConstraints = false
        
        newsPoster.configureImgBasicSettings()
        newsPoster.contentMode = .scaleAspectFill

        if let urlString = news.urlToImage, let url = URL(string: urlString) {
            self.newsPoster.imageFrom(url: url)
        } else {
            newsPoster.image = UIImage(named: "bgImg")
        }
        
        
        NSLayoutConstraint.activate([
            newsPoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            newsPoster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            newsPoster.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 11),
            newsPoster.heightAnchor.constraint(equalToConstant: 144)
        ])
    }
    
    private func setupNewsDescription() {
        contentView.addSubview(newsDescription)
        newsDescription.translatesAutoresizingMaskIntoConstraints = false
        newsDescription.numberOfLines = 0
        newsDescription.configureNunitoLabels(text: news.description, fontName: "Nunito-Regular", color: .black, size: 14)
        
        NSLayoutConstraint.activate([
            newsDescription.topAnchor.constraint(equalTo: newsPoster.bottomAnchor, constant: 7),
            newsDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            newsDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        ])
    }
    
    private func setupAuthorLabels() {
        contentView.addSubview(authorLabel)
        
        authorLabel.configureNunitoLabels(text: "Published by: \(String(describing: news.author))", fontName: "Nunito-Bold", color: .customBrown, size: 12)
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: newsDescription.bottomAnchor, constant: 8),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
