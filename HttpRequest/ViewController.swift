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
    
    let apis = ["HTTP Get connection",
                "HTTP POST connection"]
    
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
            HttpRequest(url: "http://153.126.160.55/getApi.json", method: .get)
                .getHttp(completion: { (data, responce, error) in
                self.detail(data: data!)
            })
            break
        case 1:
            HttpRequest(url: "http://153.126.160.55/postApi.json",method: .post)
                .postHttp(param: ["http_post":"Http Request POST 😄"],
                          completionHandler: { (data, responce, error) in
                self.detail(data: data!)
            })
        default:
            print ("DEfault")
        }
        
    }
}

