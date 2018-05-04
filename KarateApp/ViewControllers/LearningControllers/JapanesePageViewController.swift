//
//  JapanesePageViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 28/02/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit

class JapanesePageViewController: UIPageViewController , UIPageViewControllerDataSource, UIPageViewControllerDelegate {


    lazy var subViewControllers:[UIViewController] = {
        return [
            UIStoryboard(name: "Learning", bundle: nil).instantiateViewController(withIdentifier: "JapaneseText") as! JapaneseTextViewController,
            UIStoryboard(name: "Learning", bundle: nil).instantiateViewController(withIdentifier: "JapaneseAudio") as! JapaneseAudioViewController,
            UIStoryboard(name: "Learning", bundle: nil).instantiateViewController(withIdentifier: "JapaneseVideo") as! JapaneseVideoViewController
        ]
    }()
    
    var pageContr = UIPageControl()
    
    var optionSelected : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        // Do any additional setup after loading the view.
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
        configPageCController()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func configPageCController() {
        pageContr = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY-210, width: UIScreen.main.bounds.width, height: 50))
        pageContr.numberOfPages = subViewControllers.count
        pageContr.currentPage = 0
        pageContr.tintColor = UIColor.blue
        pageContr.pageIndicatorTintColor = UIColor.lightGray
        pageContr.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageContr)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageContr.currentPage = subViewControllers.index(of: pageContentViewController)!
        
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.index(of: viewController) ?? 0
        if(currentIndex <= 0 ) {
            return nil
        }
        return subViewControllers[currentIndex-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.index(of: viewController) ?? 0
        if(currentIndex >= subViewControllers.count-1 ) {
            return nil
        }
        return subViewControllers[currentIndex+1]
    }

}
