//
//  CustomMovieCell.swift
//  TheMoviesAppMVVMwithRxSwift
//
//  Created by Александр Воробей on 15.05.2024.
//

import UIKit
import RxSwift

class CustomMovieCell: UITableViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovieLabel: UILabel!
    @IBOutlet weak var descriptionMovieLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    private var managerConnections = ManagerConnections()
    
    static let indetifierCell = "CustomMovieCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageMovie.image = nil
        titleMovieLabel.text = nil
        descriptionMovieLabel.text = nil
    }
    
    private func getImageMovie(urlString: String) {
        managerConnections.getImageFromServer(urlString: urlString)
            .observe(on: MainScheduler())
            .subscribe { data in
                self.imageMovie.image = UIImage(data: data)
        }.disposed(by: disposeBag)

    }
    
    func configureCell(_ movie: Movie) {
        getImageMovie(urlString: Constants.URL.urlImages+movie.image)
        titleMovieLabel.text = movie.title
        descriptionMovieLabel.text = movie.overview
    }
    
}
