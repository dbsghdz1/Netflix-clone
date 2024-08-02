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
        self?.popularMoiveSubject.onNext(movieData.result)
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
        self?.topRatedMovieSubject.onNext(movieData.result)
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
        self?.upcomingMovieSubject.onNext(movieData.result)
      }, onFailure: { [weak self] error in
        self?.upcomingMovieSubject.onError(error)
      }).disposed(by: disposeBag)
  }
}


