//
//  ViewController.swift
//  HttpRequest
//
//  Created by Shichimitoucarashi on 2018/04/22.
//  Copyright © 2018年 keisuke yamagishi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var apis = ["HTTP Get connection",
                "HTTP POST connection",
                "HTTP POST Authentication",
                "HTTP GET SignIned Connection",
                "HTTP POST Upload image png",
                "HTTP POST Twitter OAuth"]
    
    var isAuth = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func detailViewController (text: String) {
        let detailViewController: DetailViewController = self.storyboard?.instantiateViewController(withIdentifier: detailViewControllerId) as! DetailViewController
        print ("text: \(text)")
        self.navigationController?.pushViewController(detailViewController, animated: true)
        detailViewController.text = text
    }
    
    func detail(data: Data) {
        DispatchQueue.main.async {
            let responceStr = String(data: data, encoding: .utf8)
            self.detailViewController(text: responceStr!)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apis.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.apis[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            HttpSession(url: "http://153.126.160.55/getApi.json", method: .get)
                .getHttp(completion: { (data, responce, error) in
                self.detail(data: data!)
            })
            break
        case 1:
            HttpSession(url: "http://153.126.160.55/postApi.json",method: .post)
                .postHttp(param: ["http_post":"Http Request POST 😄"],
                          completionHandler: { (data, responce, error) in
                self.detail(data: data!)
            })
            break
        case 2:
            HttpSession(url: "http://153.126.160.55/signIn.json",method: .post, cookie: true)
                .signIn(param: ["http_sign_in":"Http Request SignIn",
                                "userId":"keisukeYamagishi",
                                "password": "password_jisjdhsnjfbns"],
                          completionHandler: { (data, responce, error) in
                            self.detail(data: data!)
                })
            break
        case 3:
            HttpSession(url: "http://153.126.160.55/signIned.json", method: .get, cookie: true )
                .getHttp(completion: { (data, responce, error) in
                    self.detail(data: data!)
            })
            break
            
        case 4:
            var dto: MultipartDto = MultipartDto()
            let image: String? = Bundle.main.path(forResource: "re", ofType: "txt")
            let img: Data = try! Data(contentsOf:  URL(fileURLWithPath:image!))
            
            dto.fileName = "Hello.txt"
            dto.mimeType = "text/plain"
            dto.data = img
            
            HttpSession(url:"http://153.126.160.55/imageUp.json",method: .get).upload(param: ["img":dto], completionHandler: { (data, responce, error) in
                self.detail(data: data!)
            })
            break
        case 5:
            TwitterAuth.twitterOAuth(urlType: "httpRequest://success", completion: { (data, responce, error) in
                if self.isAuth == false {
                    self.isAuth = true
                    self.apis.append("Tweet")
                    self.tableView.reloadData()
                }
                print ("responce: \(String(describing: responce))")
            })
            break
        case 6:
            HttpSession().postTweet(tweet: "HttpSession https://cocoapods.org/pods/HttpSession", img: UIImage(named: "Re120.jpg")!, success: { (data, responce, error) in
                self.detail(data: data!)
            })
            break
        default:
            print ("Default")
        }
        
    }
}

