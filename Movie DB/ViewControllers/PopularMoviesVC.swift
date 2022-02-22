//
//  PopularMoviesVC.swift
//  Movie DB
//
//  Created by Kishore on 22/02/22.
//

import UIKit
import SVProgressHUD

class PopularMoviesVC: UIViewController {
    
    @IBOutlet weak var moviesTV: UITableView!
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.destination {
        case is MoviewDetailsVC:
            let vc = segue.destination as! MoviewDetailsVC
            vc.movie = sender as? Movie
        default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SVProgressHUD.show()
        Webservice().getPopularMovies { response in
            SVProgressHUD.dismiss()
            switch response.status {
            case .failure(let message):
                SVProgressHUD.showDismissableError(message: message)
            case .success(let movies):
                self.movies = movies as? [Movie] ?? [Movie]()
                DispatchQueue.main.async {
                    self.moviesTV.reloadData()
                }
            }
        }
    }

}

extension PopularMoviesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.movieCell.rawValue) as? MovieTVC else {
            return UITableViewCell()
        }
        
        cell.setup(movie: movies[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: SegueIdentifier.movieDetails.rawValue, sender: movies[indexPath.row])
    }
}
