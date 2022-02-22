//
//  MovieTVC.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import UIKit

class MovieTVC: UITableViewCell {
    
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var ratingLB: UILabel!
    @IBOutlet weak var releaseDateLB: UILabel!
    @IBOutlet weak var posterIV: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(movie: Movie) {
        titleLB.text = movie.title
        ratingLB.text = "\(movie.voteAverage?.clean ?? "0")%"
        releaseDateLB.text = movie.releaseDate?.toString() ?? ""
        posterIV.image = nil
        guard let url = URL(string: "\(BASE_POSTER_URL)\(movie.posterPath ?? "")") else {
            posterIV.image = nil
            return
        }
        Webservice().getData(fromURL: url) { [self] response in
            switch response.status {
            case .failure(_):
                DispatchQueue.main.async {
                    self.posterIV.image = nil
                }
            case .success(let data):
                if let data = data as? Data {
                    DispatchQueue.main.async {
                        self.posterIV.image = UIImage(data: data)
                    }
                }
            }
        }
    }

}
