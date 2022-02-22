//
//  MoviewDetailsVC.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import UIKit
import SVProgressHUD

class MoviewDetailsVC: UIViewController {

    @IBOutlet weak var posterIV: UIImageView!
    @IBOutlet weak var titileLB: UILabel!
    @IBOutlet weak var genreLB: UILabel!
    @IBOutlet weak var overviewLB: UILabel!
    @IBOutlet weak var releaseDateLB: UILabel!
    @IBOutlet weak var ratingLB: UILabel!
    @IBOutlet weak var durationLB: UILabel!
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = movie?.title

        if let id = movie?.id {
            SVProgressHUD.show()
            Webservice().getMovieDetails(id: id) { response in
                SVProgressHUD.dismiss()
                switch response.status {
                case .failure(let message):
                    SVProgressHUD.showDismissableError(message: message)
                case .success(let data):
                    self.movie = data as? Movie
                    DispatchQueue.main.async {
                        self.updateUI()
                    }
                }
            }
        }
    }
    
    func updateUI() {
        if let movie = movie {
            titileLB.text = movie.title
            genreLB.text = movie.genres?.compactMap({ $0.name }).joined(separator: ",")
            overviewLB.text = movie.overview
            releaseDateLB.text = movie.releaseDate?.toString()
            ratingLB.text = "\(movie.voteAverage?.clean ?? "")%"
            if let runtime = movie.runtime {
                durationLB.text = "Duration: \(runtime/60) hours \(runtime % 60) minutes"
            }
            
            
            posterIV.image = nil
            guard let url = URL(string: "\(BASE_POSTER_URL)\(movie.backdropPath ?? "")") else {
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
    
}
