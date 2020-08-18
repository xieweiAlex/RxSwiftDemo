//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by Alex Xie on 8/7/20.
//  Copyright © 2020 Sam's Club. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        print("Let the magic begin")
//        testBasics()
        testSubjet()
    }
    
    func testBasics() {
        let bag = DisposeBag()
//        let ob = Observable.just("Hello")
        let ob = Observable.from(["a", "b", "d"]).debug("K")
        
        _ = ob.subscribe(onNext: { (str) in
            print("sub: " + str)
        })
        
        ob.subscribe { (event) in
            print(event)
        }.disposed(by: bag)
    }
    
    func testSubjet() {
        let bag = DisposeBag()
        let publishSubject = PublishSubject<String>()
        publishSubject.onNext("Hello")
        publishSubject.onNext("World!")

        let _ = publishSubject.subscribe(onNext: { (text) in
          print("text \(text)")
        }).disposed(by: bag)

        publishSubject.onNext("Hello")
        publishSubject.onNext("Again!")

        let _ = publishSubject.subscribe(onNext:{
            print(#line,$0)
        }).disposed(by: bag)
        
        publishSubject.onNext("Both Subscriptions receive this message")
    }
    
}

