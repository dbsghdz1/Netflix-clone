//
//  MainViewModel.swift
//  NetflixClone
//
//  Created by 김윤홍 on 8/1/24.
//

import Foundation
import RxSwift

class MainViewModel {
  
  private let apiKey = "036fd5591d1443e0e5c290a61d021a31"
  private let disposeBag = DisposeBag()
  
  let popularMoiveSubject = BehaviorSubject(value: [Movie]())
  let topRatedMovieSubject = BehaviorSubject(value: [Movie]())
  let upcomingMovieSubject = BehaviorSubject(value: [Movie]())
  
  init () {
    fetchPopularMovie()
    fetchUpcomingMovie()
    fetchTopRatedMovie()
  }
  
  func fetchPopularMovie() {
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)") else {
      popularMoiveSubject.onError(NetworkError.invalidUrl)
      return
    }
    NetworkManager.shared.fetch(url: url)
      .subscribe(onSuccess: { [weak self] (movieData: MovieData) in
        self?.popularMoiveSubject.onNext(movieData.results)
      }, onFailure: { [weak self] error in
        self?.popularMoiveSubject.onError(error)
      }).disposed(by: disposeBag)
  }
  
  func fetchTopRatedMovie() {
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)") else {
      topRatedMovieSubject.onError(NetworkError.invalidUrl)
      return
    }
    NetworkManager.shared.fetch(url: url)
      .subscribe(onSuccess: { [weak self] (movieData: MovieData) in
        self?.topRatedMovieSubject.onNext(movieData.results)
      }, onFailure: { [weak self] error in
        self?.topRatedMovieSubject.onError(error)
      }).disposed(by: disposeBag)
  }
  
  func fetchUpcomingMovie() {
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)") else {
      upcomingMovieSubject.onError(NetworkError.invalidUrl)
      return
    }
    NetworkManager.shared.fetch(url: url)
      .subscribe(onSuccess: { [weak self] (movieData: MovieData) in
        self?.upcomingMovieSubject.onNext(movieData.results)
      }, onFailure: { [weak self] error in
        self?.upcomingMovieSubject.onError(error)
      }).disposed(by: disposeBag)
  }
  
  // movieId 로 부터 예고편 영상 URL 을 얻어온다.
  func fetchTrailerKey(movie: Movie) -> Single<String> {
    guard let movieId = movie.id else { return Single.error(NetworkError.dataFetchFail) }
    let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey)"
    guard let url = URL(string: urlString) else {
      return Single.error(NetworkError.invalidUrl)
    }
    
    return NetworkManager.shared.fetch(url: url)
      .flatMap { (videoResponse: VideoResponse) -> Single<String> in
        if let trailer = videoResponse.results.first(where: { $0.type == "Trailer" && $0.site == "YouTube" }) {
          let key = trailer.key
          return Single.just(key)
        } else {
          return Single.error(NetworkError.dataFetchFail)
        }
      }
  }
}


