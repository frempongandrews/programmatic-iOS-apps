//
//  ViewController.swift
//  07-audibleGuide
//
//  Created by Andrews Frempong on 29/12/2017.
//  Copyright © 2017 Andrews Frempong. All rights reserved.
//

//to implement:
//keyboard return pressed hide keyboard DONE
//screen rotation
//image based on screen rotation
//login button
//track login state

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    var currentPage: Int = 0;
    let cellId = "cell"
    let loginCell = "loginCell"
    
    let pages: [Page] = {
        
        let pageOne = Page(pageTitle: "Share a great listen", pageMessage: "It's free to send your books to people in your life. Every recepient's first book is on us", pageImage: #imageLiteral(resourceName: "page1"))
        let pageTwo = Page(pageTitle: "Send from your library", pageMessage: "Tap the More menu next to any book. Choose \"send this book\"", pageImage: #imageLiteral(resourceName: "page2"))
        let pageThree = Page(pageTitle: "Send from the player", pageMessage: "Tap the More menu in the upper corner. Choose \"Send this book\"", pageImage: #imageLiteral(resourceName: "page3"))
        
        return [pageOne, pageTwo, pageThree]
        
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.isPagingEnabled = true
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        cv.delegate = self
        cv.dataSource = self
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        return                                                                                                                                                                                                                         cv
    }()
    
    //Next - Skip buttons
    
    let nextButton: UIButton = {
        
        let btn = UIButton(type: .system)
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(.orange, for: .normal)
        btn.addTarget(self, action: #selector(onGoNext), for: .touchUpInside)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    let skipButton: UIButton = {
        
        let btn = UIButton(type: .system)
        btn.setTitle("Skip", for: .normal)
        btn.setTitleColor(.orange, for: .normal)
        btn.addTarget(self, action: #selector(onSkip), for: .touchUpInside)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    lazy var pageControl: UIPageControl = {
        
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = .gray
        pc.currentPageIndicatorTintColor = .orange
        pc.numberOfPages = pages.count + 1
        pc.currentPage = self.currentPage;
        
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
        
    }()
    
    
    func setupView () {
        //add to screen
        view.addSubview(collectionView)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        view.addSubview(pageControl)
        //constraints
        
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        
        skipButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        pageControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        pageControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        //pageControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupView()
        
        registerCells()
        
        observeKeyboardNotifications()
    }
    
    
}//end ViewController

//<!------------------ViewControler extension ----------------->

extension ViewController {
    
    //observe keyboard-> make login button accessible when keyboard shows
    
    func observeKeyboardNotifications () {
        //adding observer to current viewController
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        
        //removing black 50 space when keyboard is not showing
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @objc func onKeyboardShow () {
        print("keyboard shown")
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -50, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
        
    }
    
    @objc func onKeyboardHide () {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
        
    }
    
    
    
    
    //dismiss keyboard
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    
    //page tracking with pageControl
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //        print(targetContentOffset.pointee.x)
        
        self.currentPage = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = currentPage
        
        //on last page
        //print(currentPage)
        if currentPage == pages.count {
            //print("yes")
            hideNextAndSkip()
        } else {
            showNextAndSkip()
        }
        
    }
    
    //hide next and skip buttons with animation
    func hideNextAndSkip () {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.nextButton.transform = CGAffineTransform(translationX: 0, y: -100)
            self.skipButton.transform = CGAffineTransform(translationX: 0, y: -100)
        }, completion: nil)
    }
    
    
    //show next and skip buttons with animation
    func showNextAndSkip () {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.nextButton.transform = .identity
            self.skipButton.transform = .identity
        }, completion: nil)
    }
    
    
    func registerCells () {
        collectionView.register(CustomPageCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCell)
    }
    
    //when Next is pressed
    @objc func onGoNext () {
        //print("next")
        
        //on last page
        if pageControl.currentPage == pages.count { return }
        
        //on second last page
        if pageControl.currentPage == pages.count - 1 {
            hideNextAndSkip()
        } else {
            showNextAndSkip()
        }
        
        //first page is 0(indexPath.item) + 1
        //where it will scroll to
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
    
    //when Skip is pressed
    @objc func onSkip () {

        pageControl.currentPage = pages.count - 1
        //print("current: \(pageControl.currentPage)")
        onGoNext()
        
    }
    
    
    //hide keyboard when return pressed
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //screen rotation
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        print("rotated")
        
        collectionView.collectionViewLayout.invalidateLayout()
        
    }
    
    
    //conform to protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.item == pages.count) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loginCell", for: indexPath) as! LoginCell
            cell.emailTextField.delegate = self
            cell.passwordTextField.delegate = self
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomPageCell
        let page = pages[indexPath.item]
        cell.page = page
        //cell.backgroundColor = .yellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}//end ViewController extension


