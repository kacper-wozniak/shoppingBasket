//
//  RxAlamofire.swift
//  ShoppingBasket
//
//  Created by Kacper Woźniak on 29/11/2018.
//  Copyright © 2018 Kacper Woźniak. All rights reserved.
//

import RxSwift
import Alamofire

struct RxAlamofire {

    static func request<T>(url: URLConvertible) -> Observable<T> where T:Decodable {
        return Observable<T>.create { observer in
            let request = Alamofire.request(url)
                .validate()
                .responseData { response in
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(T.self, from: data)
                            observer.onNext(result)
                            observer.onCompleted()
                        } catch {
                            observer.onError(error)
                        }
                    } else if let error = response.error {
                        observer.onError(error)
                    }
            }
            return Disposables.create {
                request.cancel()
            }
        }.share().debug()
    }

}
