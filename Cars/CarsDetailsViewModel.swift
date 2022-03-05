//
//  CarsDetailsViewModel.swift
//  Cars
//
//  Created by Mohamed Hashem on 05/03/2022.
//

import Foundation

import RxSwift
import RxCocoa

class CarDetailsViewModel {
    
    let cars : PublishSubject<[CarsDetailsModel]> = PublishSubject()
    let carsImage : PublishSubject<[String]> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    let error : PublishSubject<Error> = PublishSubject()
    
    private var currentPage = 1
    private let disposable = DisposeBag()
    
    func requestCarsImageData(make: String, model: String) {
        self.loading.onNext(true)
        
        CarsEndPoints.shared
            .provider.rx
            .request(.getCarPhoto(make: make, model: model))
            .filterSuccessfulStatusCodes()
            .timeout(.seconds(120), scheduler: MainScheduler.instance)
            .retry(2)
            .map(CarsPhoto.self)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                if let cars = response.photos {
                    var images: [String] = []
                    cars.forEach { photo in
                        photo.sources.forEach { source in
                            images.append("http://media.ed.edmunds-media.com/\(source.link.href)")
                        }
                    }
                    self?.carsImage.onNext(images)
                }
                
            }) { [weak self] error in
                self?.error.onNext(error)
            }.disposed(by: disposable)
    }
    
    func requestCarsDetailsData(makeName: String, modelName: String, make: String, model: String) {
        self.loading.onNext(true)
        
        CarsEndPoints.shared
            .provider.rx
            .request(.getCarModelDetail(makeNiceName: makeName, modelNiceName: modelName))
            .filterSuccessfulStatusCodes()
            .timeout(.seconds(120), scheduler: MainScheduler.instance)
            .retry(2)
            .map(Welcome.self)
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] response in
                if let cars = response.results {
                    self?.cars.onNext(cars)
                }
                self?.requestCarsImageData(make: make, model: model)
            }) { [weak self] error in
                self?.error.onNext(error)
            }.disposed(by: disposable)
    }
    
    
}
